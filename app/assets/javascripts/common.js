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
})


