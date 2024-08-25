describe("Home Page", () => {
    beforeEach(() => {
        cy.visit("/");
        cy.get("body").should("be.visible");
    });

    it("should visit the home page", () => {
        // Check that the home page url is correct
        cy.location()
            .should(loc => {
                expect(loc.pathname).to.eq("/");
            })
            .then(url => {
                cy.log("Current Location is the home page", url);
            });
    });

    it("should verify the header text", () => {
        // Use invoke to verify the h2 text
        cy.get("h1")
            .invoke("text")
            .then(text => {
                const trimmedText = text.trim();
                console.log("", trimmedText);
            });

        // Verify that 'Where you can find any plants!' is the text for the h2 element
        cy.get("h1")
            .should("be.visible")
            .invoke("text")
            .then(text => {
                const trimmedText = text.trim();
                expect(trimmedText).to.equal("Welcome to Jungle");
            });
    });

    it("should verify that there are products on the page", () => {
        cy.visit("/");
        cy.get(".products article").should("be.visible");
    });

    it("There is 2 products on the page", () => {
        cy.visit("/");
        cy.get(".products article").should("have.length", 2);
    });
});
