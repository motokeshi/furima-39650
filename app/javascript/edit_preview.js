function edit_preview () {
  const pagePath = location.pathname;
  if (pagePath.indexOf('edit') === -1) return null;
  const fileField = document.querySelector("#item-image");
  fileField.addEventListener('change', function(e) {
    const alreadyPreview = document.querySelector('.preview-image');
    alreadyPreview.remove();
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'preview-image');
    previewImage.setAttribute('src', blob);
    const previewWrapper = document.getElementById("preview");
    previewWrapper.appendChild(previewImage);
  });
};

window.addEventListener('turbo:load', edit_preview)
window.addEventListener('turbo:render', edit_preview)