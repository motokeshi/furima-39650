window.addEventListener("DOMContentLoaded", () => {
    const pagePath = location.pathname;
  if (pagePath.indexOf('orders') !== -1) {
    const publicKey = gon.public_key;
    window.payjp = Payjp(publicKey);
    const elements = payjp.elements();
    const numberElement = elements.create('cardNumber');
    const expiryElement = elements.create('cardExpiry');
    const cvcElement = elements.create('cardCvc');
  
    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');
  
    const form = document.getElementById('charge-form')
    form.addEventListener("submit", (e) => {
      console.log(numberElement)
      payjp.createToken(numberElement).then(function (response) {
        if (response.error) {
        } else {
          const token = response.id;
          console.log(token);
        }
      });
      e.preventDefault();
    });
  }
});
