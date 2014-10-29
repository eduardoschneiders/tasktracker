(function(objectivesTracker){
  $('ul#tasks-list li a#complete').on("ajax:success", function(e, data, status, xhr){
    $(this).parent().addClass('completed');
    update_flash(data.message);
  });

  $('ul#tasks-list li a#remove').on("ajax:success", function(e, data, status, xhr){
    $(this).parent().remove();
    update_flash(data.message);
  });

  function update_flash(message){
    $('#notice').html(message);
  }
})(objectivesTracker);
