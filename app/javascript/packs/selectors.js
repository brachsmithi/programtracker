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

window.loadSelector = loadSelector
