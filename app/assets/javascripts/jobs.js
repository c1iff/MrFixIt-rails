$(document).ready(function(){
  $('.current-jobs input[type=submit]').remove()
  $('.current-jobs input[type=checkbox]').click(function(){
    $(this).parent('form').submit();
  });
});
