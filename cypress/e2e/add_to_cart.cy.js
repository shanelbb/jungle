// Run Tests Command: bin/rails cypress:open

describe("Add to Cart", () => {
    beforeEach(() => {
        //Go to home page before every test
        cy.visit("/");
        cy.get("body").should("be.visible");
    });

    it("should increment cart count when a product is added", () => {
        // Check the initial cart count.
        cy.get(".nav-item.end-0 .nav-link")
            .invoke("text")
            .then(initialText => {
                const initialCount = parseInt(initialText.match(/\((\d+)\)/)[1], 10);

                // Click the 'Add to Cart' button for the first product
                cy.get(".product-card").first().contains("Add").click();

                // Check the updated cart count
                cy.get(".nav-item.end-0 .nav-link")
                    .invoke("text")
                    .then(updatedText => {
                        const updatedCount = parseInt(updatedText.match(/\((\d+)\)/)[1], 10);
                        expect(updatedCount).to.equal(initialCount + 1);
                    });
            });
    });
});
