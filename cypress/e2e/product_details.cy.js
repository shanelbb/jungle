describe("Product Details", () => {
    beforeEach(() => {
        // Go to home page before every test
        cy.visit("/");
        cy.get("body").should("be.visible");
    });

    it("should navigate to the product detail page when a product is clicked", () => {
        // Get the link to the product apge in the .product-card class
        cy.get(".product-card").first().find("a").click();

        // Verify that the url path is '/products/'
        cy.url().should("include", "/products/");

        // Verify that an element with the class of product-detail exists on the page.
        cy.get(".product-detail").should("exist");
    });
});
