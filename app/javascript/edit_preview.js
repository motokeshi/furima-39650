window.addEventListener('turbo:load', () => {
  const pagePath = location.pathname;
  if (pagePath.indexOf('edit') === -1) return null;
  const fileField = document.querySelector("#item-image");
  fileField.addEventListener('change', function(e) {
    const previewImage = document.querySelector('.preview-image');
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    previewImage.setAttribute('src', blob);
  });
});