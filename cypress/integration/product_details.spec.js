describe('Product Navigation', () => {
  it('should navigate to product detail page when clicking on a product', () => {
    // Visit the home page.
    cy.visit('/');

    // Find the product element and click it.
    cy.get('article a').first().click(); 

    // Verify that the URL has changed to the product detail page.
    cy.url().should('include', '/products/');

    // Verify that the product details are displayed on the page.
    cy.get('.product-detail').should('be.visible');
  });
});
