(function(taskTracker){

  taskTracker.ControlMessages = function(){
    this.actions_container = $('table.tasks-list tr td.actions');
    this.new_name_container = $('.new_task table.tasks-list tr td.name');
    this.name_container = $('table.tasks-list tr td.name').not(this.new_name_container);
    this.todo_tasks_container = $('.todo_tasks table.tasks-list');
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
    this._newTask();
    this._dragTask();
    this._editGroup();
    this._newGroup();
    this._removeGroup();
  }

  proto._completeTask = function(){
    $('.row').on('ajax:success', 'table.tasks-list tr td.actions .complete', function(e, data, status, xhr){
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
    $('.row').on('ajax:success', 'table.tasks-list tr td.actions .uncomplete', function(e, data, status, xhr){
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
    $('.row').on('ajax:success', 'table.tasks-list tr td.actions .remove', function(e, data, status, xhr){
      self = e.target
      $(self).parent().parent().remove();
      taskTracker.update_flash(data.message);
    }.bind(this));
  }

  proto._editTask = function(){
    $('.row').on('click', 'table.tasks-list tr td.name', function(){
      $(this).find('.text-holder').hide();
      $(this).find('.form-holder').show();
      $(this).find('.form-holder').find('input').focus();
    });

    $('.row').on('blur', 'table.tasks-list tr td.name .form-holder input', function(){
      var container = $(this).parents('td.name');

      container.find('.text-holder').show();
      container.find('.form-holder').hide();
    });

    $('.row').on('ajax:success', 'table.tasks-list tr td.name', function(e, data, status, xhr){
      container = $(e.target).parents('td.name');
      var text = container.find('.form-holder input:text').val();

      container.find('.text-holder').text(text).show();
      container.find('.form-holder').hide();

      taskTracker.update_flash(data.message);
    }.bind(this));
  }

  proto._newTask = function(){
    $('.row').on("ajax:success", '.new_task table.tasks-list tr td.name', function(e, data, status, xhr){
      var todo_tasks_container = $(this).parents('.new_task').prev().prev().find('table');
      $(this).find('input[name="task[name]"]').val('');

      $.get('tasks/' + data.task.id + '/html', function(data){
        todo_tasks_container.append(data);
      });

      taskTracker.update_flash(data.message);
    });
  }

  proto._dragTask = function(){
    $(document).ready(function(){
      $("table tbody").sortable({
        connectWith: 'table tbody',
        receive: function(event, ui){
          var group_id =  ui.item.parents('.todo_tasks').data('group-id');
          var task_id =  ui.item.data('task-id');

          $.ajax({
            url: 'tasks/' + task_id,
            data: { task: { group_id: group_id }},
            type: 'PUT',
            success: function(data) {
              taskTracker.update_flash(data.message);
            }
          });
        }
      });
    });
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

  proto._editGroup = function(){
    $('.row').on('click', '.task-group:not(.new) .group-name', function(){
      $(this).find('.text-holder').hide();
      $(this).find('.form-holder').show();
      $(this).find('.form-holder').find('input').focus();
    });

    $('.row').on('blur', ' .task-group:not(.new) .group-name .form-holder input', function(){
      var container = $(this).parents('.group-name');
      container.find('.text-holder').show();
      container.find('.form-holder').hide();
    });

    $('.row').on('ajax:success', '.task-group:not(.new) .group-name', function(e, data, status, xhr){
      container = $(e.target).parents('.group-name');
      var text = container.find('.form-holder input:text').val();

      container.find('.text-holder').text(text).show();
      container.find('.form-holder').hide();

      taskTracker.update_flash(data.message);
    }.bind(this));
  }

  proto._newGroup = function(){
    $('.task-group.new').on('ajax:success', function(e, data, status, xhr){
      var group_container = $(this).parent();
      $(this).find('input[name="group[name]"]').val('');

      $.get('groups/' + data.group.id + '/html', function(data){
        $(data).insertBefore(group_container);
      });

      taskTracker.update_flash(data.message);
    });
  }

  proto._removeGroup = function(){
    $('.row').on('ajax:success', '.task-group .remove-group', function(e, data, status, xhr){
      $(this).parents('.task-group').parent().remove();
      taskTracker.update_flash(data.message);
    });
  }
})(taskTracker);
