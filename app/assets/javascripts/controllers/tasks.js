(function(taskTracker){
  taskTracker.ControlMessages = function(){
    this._bindEvents();
  }

  var proto = taskTracker.ControlMessages.prototype;

  proto._bindEvents = function(){
    this._completeTask();
    this._uncompleteTask();
    this._removeTask();
  }

  proto._completeTask = function(){
    $('table#tasks-list tr td a.complete').on("ajax:success", function(e, data, status, xhr){
      self = e.target;
      $(self).parent().parent().addClass('completed');
      $(self).hide();
      $(self).parent().find('.uncomplete').show();
      this._update_flash(data.message);
    }.bind(this));
  }

  proto._uncompleteTask = function(){
    $('table#tasks-list tr td a.uncomplete').on("ajax:success", function(e, data, status, xhr){
      self = e.target;
      $(self).parent().parent().removeClass('completed');
      $(self).hide();
      $(self).parent().find('.complete').show();
      this._update_flash(data.message);
    }.bind(this));
  }

  proto._removeTask = function(){
    $('table#tasks-list tr td a#remove').on("ajax:success", function(e, data, status, xhr){
      self = e.target
      $(self).parent().parent().remove();
      this._update_flash(data.message);
    }.bind(this));
  }

  proto._update_flash = function(message){
    $('#notice').html(message);
    $('#notice').fadeIn('fast').delay(3000).fadeOut('fast');
  }
})(taskTracker);
