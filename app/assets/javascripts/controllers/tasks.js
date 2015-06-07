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
      $(self).parents('tr').slideUp('fast', function(){
        $(this).appendTo(done_tab).show();
        $('.container .row').trigger('applyWookmark');
      });
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
      $(self).parents('tr').slideUp('fast', function(){
        $(this).appendTo(todo_tab).show();
        $('.container .row').trigger('applyWookmark');
      });
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

        $('.container .row').trigger('applyWookmark');
        taskTracker.update_flash(data.message);
      });

    });
  }

  proto._dragTask = function(){
    $(document).on('ready page:load', function(){
      this.dragFunction($('body'));
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
      self = e.target;
      var group_container = $(self).parents('.task-group.new');

      group_container.find('input[name="group[name]"]').val('');

      $.get('groups/' + data.group.id + '/html', function(data){
        var $data = $(data);

        $($data).insertBefore(group_container);
        this.dragFunction($data);
        
        $('.container .row').trigger('applyWookmark');
      }.bind(this));


      taskTracker.update_flash(data.message);
    }.bind(this));
  }

  proto.dragFunction = function(data){
    $(data.find(".todo_tasks .tasks-list tbody")).sortable({
      connectWith: '.todo_tasks .tasks-list tbody',
      placeholder: 'placeholder',
      cancel: 'tr.initial-placeholder',
      receive: function(event, ui){
        var sender_group_id =  ui.sender.parents('.todo_tasks').data('group-id');
        var receiver_group_id =  ui.item.parents('.todo_tasks').data('group-id');
        var task_id =  ui.item.data('task-id');

        // console.log(ui);
        // console.log('sender: ' + sender_group_id);
        // console.log('receiver: ' + receiver_group_id);

        $.ajax({
          url: 'tasks/' + task_id,
          data: { task: { group_id: receiver_group_id }},
          type: 'PUT',
          success: function(data) {
            $('.container .row').trigger('applyWookmark');

            taskTracker.update_flash(data.message);
          }
        });
      },
      stop: function(event, ui){
        var item                = ui.item;
        var current_item_order  = item.prev().data('task-order') ? item.prev().data('task-order') + 1 : 0;
        var next_itens          = item.nextAll();
        var receiver_group_id   = ui.item.parents('.todo_tasks').data('group-id');
        var current_task_id     = item.data('task-id');
        var next_tasks_id       = new Array();

        item.data('task-order', current_item_order);

        next_itens.each(function(index, item){
          next_tasks_id.push($(item).data('task-id'));
          $(item).data('task-order', $(item).data('task-order') + 1);
          console.log($(item).data('task-order'));
        });

        var params = {
          current_order: current_item_order,
          current_task_id: current_task_id, 
          next_tasks_id: next_tasks_id 
        };

        $.ajax({
          url: 'groups/' + receiver_group_id + '/increment_tasks',
          data: params,
          type: 'PUT',
          success: function(data) {
            console.log('put completed');
          }
        });
      }
    });
  }

  proto._removeGroup = function(){
    $('.row').on('ajax:success', '.task-group .remove-group', function(e, data, status, xhr){
      $(this).parents('.task-group').remove()
        
        $('.container .row').trigger('applyWookmark');
      taskTracker.update_flash(data.message);
    });
  }
})(taskTracker);
