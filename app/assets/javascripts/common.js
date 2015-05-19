if(!taskTracker) var taskTracker = {};

taskTracker.update_flash = function(message){
  window.clearTimeout(this.timeoutID);
  $('#notice').fadeOut('fast');
  $('#notice').html(message);
  $('#notice').fadeIn('fast');
  this.timeoutID = window.setTimeout(taskTracker.hide_message, 3000);
}
taskTracker.hide_message = function(){
  $('#notice').fadeOut('fast');
}
function equality(force){
  $('.todo_tasks').each(function(){
    todo_itens_count = $(this).find('table tbody tr:not(.initial-placeholder)').length;
    if (force || todo_itens_count >= 10){
      todo_height_tab = $(this).height();
      $(this).next().height(todo_height_tab);
    }
  })
}

$(document).on('ready page:load', function (){
  $('#notice').delay(3000).fadeOut('fast');
  $('#tasks-tab').tab();
  equality(true);

  options = {
    autoResize: true,
    offset: 10, // Optional, the distance between grid items
  };
  var wookmark = new Wookmark('.container .row', options);
  
  $('.container').on('applyWookmark', '.row', function(event){
    equality(false);
    wookmark.initItems();
    wookmark.layout(true);

  })
})


