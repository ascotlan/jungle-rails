describe('Add to Cart', () => {
  beforeEach(() => {
    // Ensure the cart is empty before each test.
    cy.visit('/'); // Visit the home page.
    // Verify the initial cart count is zero.
    cy.get('.nav-item.end-0 .nav-link').should('contain.text', 'My Cart (0)');
  });

  it('should increase cart count when adding a product', () => {
    // Find and click the "Add to Cart" button of a product.
    cy.get('article').first().find('.btn').contains('Add').click({ force: true });
    
    // Verify that the cart count increases by one.
    cy.get('.nav-item.end-0 .nav-link').should('contain.text', 'My Cart (1)');
  });
});
