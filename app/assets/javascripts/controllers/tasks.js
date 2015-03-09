(function(taskTracker){

  taskTracker.ControlMessages = function(){
    this.actions = $('table.tasks-list tr td.actions');
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
    this._editTask();
  }

  proto._completeTask = function(){
    this.actions.on('ajax:success', '.complete', function(e, data, status, xhr){
      taskTracker.update_flash(data.message);
      self = e.target;
      uncomplete_path = $(self).attr('data-url-uncomplete');
      $(self).data('url', uncomplete_path);
      $(self).attr('class', 'uncomplete');
      $(self).removeClass('complete').addClass('uncomplete');
      done_tab = $(self).parents('.todo_tasks').next().find('table');
      $(self).parents('tr').appendTo(done_tab);
    }.bind(this));
  }

  proto._uncompleteTask = function(){
    this.actions.on('ajax:success', '.uncomplete', function(e, data, status, xhr){
      taskTracker.update_flash(data.message);
      self = e.target;
      complete_path = $(self).attr('data-url-complete');
      $(self).data('url', complete_path);
      $(self).removeClass('uncomplete').addClass('complete');
      todo_tab = $(self).parents('.done_tasks').prev().find('table');
      $(self).parents('tr').appendTo(todo_tab);
    }.bind(this));
  }

  proto._removeTask = function(){
    this.actions.find('a.remove').on("ajax:success", function(e, data, status, xhr){
      self = e.target
      $(self).parent().parent().remove();
      taskTracker.update_flash(data.message);
    }.bind(this));
  }

  proto._restoreTask = function(){
    $('table#tasks-list tr td a#restore').on("ajax:success", function(e, data, status, xhr){
      self = e.target
      $(self).parent().parent().remove();
      taskTracker.update_flash(data.message);
    }.bind(this));
  }

  proto._restoreAllTask = function(){
    $('a#permanently_remove_tasks').on("ajax:success", function(e, data, status, xhr){
      taskTracker.update_flash(data.message);
      self = e.target
      $('table#tasks-list').remove();
    }.bind(this));
  }

  proto._editTask = function(){
    $('table#tasks-list tr td.name').on("click", function(){
      $(this).find('.text-holder').hide();
      $(this).find('.form-holder').show();
      $(this).find('.form-holder').find('input').focus();
    });

    $('table#tasks-list tr td.name .form-holder input').blur(function(){
      var container = $(this).parent().parent().parent();

      container.find('.text-holder').show();
      container.find('.form-holder').hide();
    });

    $('table#tasks-list tr td.name').on("ajax:success", function(e, data, status, xhr){
      container = $(e.target).parent().parent();
      var text = container.find('.form-holder input:text').val();

      container.find('.text-holder').text(text).show();
      container.find('.form-holder').hide();

      taskTracker.update_flash(data.message);
    }.bind(this));
  }
})(taskTracker);
