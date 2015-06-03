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

function balance_height(){
  $('.todo_tasks').each(function(){
    var todo_tab = $(this);
    var done_tab = $(this).next();

    if (done_tab.height() > done_tab.height() || todo_tab.height() >= 150){
      $(this).next().height(todo_tab.height());
    }
  })
}

$(document).on('ready page:load', function (){
  $('#notice').delay(3000).fadeOut('fast');
  $('#tasks-tab').tab();
  balance_height();

  options = {
    autoResize: true,
    offset: 10, // Optional, the distance between grid items
  };

  var wookmark = new Wookmark('.container .row', options);
  
  $('.container').on('applyWookmark', '.row', function(event){
    balance_height();
    wookmark.initItems();
    wookmark.layout(true);

  })
})
