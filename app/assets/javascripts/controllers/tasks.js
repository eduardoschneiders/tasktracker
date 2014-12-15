(function(taskTracker){
  taskTracker.ControlMessages = function(){
    this.timeoutID;
    this._bindEvents();
  }

  var proto = taskTracker.ControlMessages.prototype;

  proto._bindEvents = function(){
    this._completeTask();
    this._uncompleteTask();
    this._removeTask();
    this._restoreTask();
    this._restoreAllTask();
  }

  proto._completeTask = function(){
    $('table#tasks-list tr td').on("ajax:success", '.complete', function(e, data, status, xhr){
      this._update_flash(data.message);
      self = e.target;
      $(self).parent().parent().removeClass('uncompleted').addClass('completed');
      $(self).removeClass('complete').addClass('uncomplete');
      uncomplete_path = $(self).attr('data-url-uncomplete');
      $(self).data('url', uncomplete_path);
    }.bind(this));
  }

  proto._uncompleteTask = function(){
    $('table#tasks-list tr td').on("ajax:success", '.uncomplete', function(e, data, status, xhr){
      this._update_flash(data.message);
      self = e.target;
      $(self).parent().parent().removeClass('completed').addClass('uncompleted');
      $(self).removeClass('uncomplete').addClass('complete');
      complete_path = $(self).attr('data-url-complete');
      $(self).data('url', complete_path);
    }.bind(this));
  }

  proto._removeTask = function(){
    $('table#tasks-list tr td a#remove').on("ajax:success", function(e, data, status, xhr){
      self = e.target
      $(self).parent().parent().remove();
      this._update_flash(data.message);
    }.bind(this));
  }

  proto._restoreTask = function(){
    $('table#tasks-list tr td a#restore').on("ajax:success", function(e, data, status, xhr){
      self = e.target
      $(self).parent().parent().remove();
      this._update_flash(data.message);
    }.bind(this));
  }

  proto._restoreAllTask = function(){
    $('a#permanently_remove_tasks').on("ajax:success", function(e, data, status, xhr){
      this._update_flash(data.message);
      self = e.target
      $('table#tasks-list').remove();
    }.bind(this));
  }

  proto._update_flash = function(message){
    window.clearTimeout(this.timeoutID);
    $('#notice').fadeOut('fast');
    $('#notice').html(message);
    $('#notice').fadeIn('fast');
    this.timeoutID = window.setTimeout(this._hide_message, 3000);
  }

  proto._hide_message = function(){
    $('#notice').fadeOut('fast');
  }
})(taskTracker);
