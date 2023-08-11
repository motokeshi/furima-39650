function item_price () {
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener('input', () => {
    document.getElementById("add-tax-price").textContent = Math.floor(itemPrice.value * 0.1);
    document.getElementById("profit").textContent = Math.floor(itemPrice.value * 0.9);
  });
};
window.addEventListener('turbo:load', item_price);