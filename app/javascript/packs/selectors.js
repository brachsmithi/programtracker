export function loadSelector(elem) {
  const rawPath = elem.getAttribute('data-search-path');
  const term = elem.value;
  const url = rawPath.replace('REPLACE', term)
  
  $.ajax({
    datatype: 'json',
    cache: false,
    url: url,
    timeout: 5000,
    error: function(XMLHttpRequest, errorTextStatus, error) {
      alert("Failed to submit : " + errorTextStatus + " ;" + error);
    },
    success: function(_) {
      $('#selected_id_value').removeClass('hidden');
    }
  });

}

export function setSelected(selectId, linkId) {
  const id = $('#selected_id_value').val();
  if (id !== '') {
    $(selectId).val(id);$(linkId).html($('#selected_id_value option:selected').text());
  }
}

window.loadSelector = loadSelector
window.setSelected = setSelected
