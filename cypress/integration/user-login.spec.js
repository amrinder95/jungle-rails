describe('User login', () => {
  it('Visits the home page', () => {
    cy.visit('/');
  });
  it('Should be able to sign-up', () => {
    cy.get(".nav-link").contains("Signup")
      .click()
    cy.get("#user_first_name")
      .type("Test")
    cy.get("#user_last_name")
      .type("User")
    cy.get("#user_email")
      .type("email@example.com")
    cy.get("#user_password")
      .type("123456")
    cy.get("#user_password_confirmation")
      .type("123456")
    cy.get(".btn").contains("Create User")
      .click()
    cy.get(".nav-link").contains("Logout").should("be.visible")
  })
  it('Should be able to login', () => {
    cy.get(".nav-link").contains("Logout")
      .click()
    cy.get("#email")
      .type("email@example.com")
    cy.get("#password")
      .type("123456")
    cy.get(".btn").contains("Login")
      .click()
    cy.get(".nav-link").contains("Logout").should("be.visible")
  })
});