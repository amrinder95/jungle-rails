describe('Home Page', () => {
  it('Visits the home page', () => {
    cy.visit('/');
  });
  it('There is products on the page', () => {
    cy.get(".products article").should("be.visible");
  });
  it('Visits the products page', () => {
    cy.get(".products img")
      .first()
      .click();
  })
});