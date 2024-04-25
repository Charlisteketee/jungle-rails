describe('Add to Cart', () => {
  beforeEach(() => {
    // Visit the home page
    cy.visit('http://127.0.0.1:3000/');
  });

  it('should increase cart count when a product is added', () => {
    // Get the initial count of the cart (assuming there's a cart indicator)
    // This can vary depending on your app structure; adjust as needed.
    cy.get('.nav-item end-0').then(($cart) => {
      const initialCount = parseInt($cart.text(), 10);

      // Click the 'Add to Cart' button for the first product on the page
      cy.get('.products article').first().find('.btn[type="submit"]').scrollIntoView().click({force: true});

      // Check that the cart count increases by one
      cy.get('.nav-item end-0').should(($updatedCart) => {
        const updatedCount = parseInt($updatedCart.text(), 10);
        expect(updatedCount).to.equal(initialCount + 1);
      });
    });
  });
});
