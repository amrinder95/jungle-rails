describe('Add to cart', () => {
  it('Visits the home page', () => {
    cy.visit('/');
  });
  it('There is products on the page', () => {
    cy.get(".products article").should("be.visible");
  });
  it('Adds an item to cart and cart quantity increases by one', () => {
    let initialQuantity;
    cy.get('.navbar-nav li.nav-item.end-0').invoke('text').then(text => {
      initialQuantity = parseInt(text.match(/\d+/)[0]);
    });
    cy.get(".btn").contains("Add")
    .first()
    .click({force: true});
    cy.get('.navbar-nav li.nav-item.end-0').invoke('text').then(text => {
      const updatedQuantity = parseInt(text.match(/\d+/)[0]);
    expect(updatedQuantity).to.equal(initialQuantity + 1);
    });
  });
});