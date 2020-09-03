export function loadSelector(elem) {
  var rawPath = elem.getAttribute('data-search-path');
  var term = elem.value;
  var url = rawPath.replace('REPLACE', term)
  
  $.ajax({
    datatype: 'json',
    cache: false,
    url: url,
    timeout: 5000,
    error: function(XMLHttpRequest, errorTextStatus, error) {
      alert("Failed to submit : " + errorTextStatus + " ;" + error);
    }
  });

}

export function setSelected(selectId, linkId) {
  var id = $('#selected_id_value').val();
  if (id !== '') {
    $(selectId).val();$(linkId).html($('#selected_id_value option:selected').text());
  }
}

window.loadSelector = loadSelector
window.setSelected = setSelected
