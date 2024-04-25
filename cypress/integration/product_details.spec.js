describe('example jungle app', () => {
  beforeEach(() => {
    // Cypress starts out with a blank slate for each test
    // so we must tell it to visit our website with the `cy.visit()` command.
    // Since we want to visit the same URL at the start of all our tests,
    // we include it in our beforeEach function so that it runs before each test
    cy.visit('http://127.0.0.1:3000/');
  });

  it('can navigate to the product detail page by clicking on a product', () => {

    cy.get('.products article').first().click();

    cy.url().should('include', '/products/');

    cy.contains('Scented Blade');
  })
})