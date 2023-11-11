describe('Home Page', () => {
  it('Visits the home page', () => {
    // Visit the home page
    cy.visit('/'); 
    cy.contains('Welcome to The Jungle');
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are at least 2 products on the page", () => {
    cy.get(".products article").should("have.length.at.least", 2);
  });
});
