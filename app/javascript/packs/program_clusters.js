export function setProgramField(fieldName) {
  const value = $('.' + fieldName).first().find('input').val();
  $('input.' + fieldName).val(value)
}

window.setProgramField = setProgramField