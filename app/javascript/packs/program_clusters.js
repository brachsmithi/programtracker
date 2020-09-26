export function setProgramField(fieldName) {
  var value = $('.' + fieldName).first().find('input').val();
  $('input.' + fieldName).val(value)
}

window.setProgramField = setProgramField