$(document).ready(function(){
  $(document).on('click', '#name_button', function(){
    $.ajax({
      type: 'POST',
      url: '/set_name'
    }).done(function(msg){
      $('set_name').replaceWith(msg);
    });
    return false;
  })
});