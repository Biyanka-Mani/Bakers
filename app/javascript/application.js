// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
document.addEventListener('turbo:load', () => {
    const form = document.querySelector('form[action="/cart/update"]');
    const cartMessageDiv = document.getElementById('cart-message'); 
    const subtotalElement = document.getElementById('subtotal-amount');
    if (form) {
      form.addEventListener('submit', function(event) {
        event.preventDefault(); 
  
        const formData = new FormData(this);
        const productId = formData.get('product_id');
        const quantity = formData.get('quantity');
  
        updateCartItem(productId, quantity);
      });
    }
  
    function updateCartItem(productId, quantity) {
      fetch('/cart/update', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
          'Accept': 'application/json'
        },
        body: JSON.stringify({ product_id: productId, quantity: quantity })
      })
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then(data => {
        console.log("Response data:", data);
        // Display the message in the view
        cartMessageDiv.style.display = 'block';
        cartMessageDiv.textContent = data.message;
        
        if (subtotalElement && data.subtotal) {
          subtotalElement.textContent = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: 'USD'
          }).format(data.subtotal);
        }
        // Optionally, hide the message after a few seconds
        setTimeout(() => {
          cartMessageDiv.style.display = 'none';
        }, 3000);
  
        // Update cart UI if necessary (e.g., update subtotal, etc.)
        // ... rest of your code ...
      })
      .catch(error => {
        console.error("Error updating cart:", error);
        cartMessageDiv.style.display = 'block';
        cartMessageDiv.textContent = "An error occurred while updating the cart.";
  
        setTimeout(() => {
          cartMessageDiv.style.display = 'none';
        }, 3000);
      });
    }
    
  });
  document.addEventListener('turbo:load', () => {
    const removeForms = document.querySelectorAll('form[action="<%= remove_from_cart_path %>"]');
  
    removeForms.forEach(form => {
      form.addEventListener('submit', function(event) {
        event.preventDefault(); // Prevent the form from submitting normally
        const productId = this.querySelector('input[name="product_id"]').value;
        removeCartItem(productId);
      });
    });

    function removeCartItem(productId) {
        console.log("Removing product with ID:", productId); // Debugging line
        const cartMessageDiv = document.getElementById('cart-message');
        
        fetch(`/cart/remove?product_id=${productId}`, {
          method: 'POST',
          headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
          },
        })
        .then(response => response.json())
        .then(data => {
          if (data.success) {
            console.log("Item removed successfully."); // Debugging line
            // Display success message
            cartMessageDiv.style.display = 'block';
            cartMessageDiv.textContent = 'Item removed from cart successfully';
      
            // Update the cart display on the page
            updateCartDisplay();
      
            // Hide the message after a few seconds
            setTimeout(() => {
              cartMessageDiv.style.display = 'none';
            }, 3000);
          } else {
            console.log("Failed to remove item."); // Debugging line
            // Display error message
            cartMessageDiv.style.display = 'block';
            cartMessageDiv.textContent = 'Failed to remove item from cart';
      
            // Hide the message after a few seconds
            setTimeout(() => {
              cartMessageDiv.style.display = 'none';
            }, 3000);
          }
        })
        .catch(error => {
          console.error('Error removing item from cart:', error);
          // Display error message
          cartMessageDiv.style.display = 'block';
          cartMessageDiv.textContent = 'An error occurred while removing the item from the cart.';
      
          // Hide the message after a few seconds
          setTimeout(() => {
            cartMessageDiv.style.display = 'none';
          }, 3000);
        });
      }
      
  });
  