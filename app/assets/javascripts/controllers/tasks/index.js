(function(objectivesTracker){
  $('table#tasks-list tr td a.complete').on("ajax:success", function(e, data, status, xhr){
    $(this).parent().parent().addClass('completed');
    $(this).hide();
    $(this).parent().find('.uncomplete').show();
    update_flash(data.message);
  });

  $('table#tasks-list tr td a.uncomplete').on("ajax:success", function(e, data, status, xhr){
    $(this).parent().parent().removeClass('completed');
    $(this).hide();
    $(this).parent().find('.complete').show();
    update_flash(data.message);
  });


  $('table#tasks-list tr td a#remove').on("ajax:success", function(e, data, status, xhr){
    $(this).parent().parent().remove();
    update_flash(data.message);
  });

  function update_flash(message){
    $('#notice').html(message);
    $('#notice').fadeIn('fast').delay(3000).fadeOut('fast');
  }
})(objectivesTracker);
