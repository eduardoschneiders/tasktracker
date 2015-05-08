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

$(document).ready(function (){
  $('#notice').delay(3000).fadeOut('fast');

  $('#tasks-tab').tab();

  handler = $('.container .row');

  options = {
    autoResize: true,
    offset: 10, // Optional, the distance between grid items
  };
  var wookmark = new Wookmark('.container .row', options);
  
  $('.container').on('applyWookmark', '.row', function(event){
    console.log('refresh');    

    wookmark.initItems();
    wookmark.layout(true, function () {
      // Fade in items after layout
      setTimeout(function() {
        console.log('asdf');
      }, 300);
    });
  })
})


