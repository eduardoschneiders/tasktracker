(function(taskTracker){
  taskTracker.ControlMessagesGroup = function(){
    this.timeoutID;
    this._bindEvents();
  }

  var proto = taskTracker.ControlMessagesGroup.prototype;

  proto._bindEvents = function(){
    this._removeGroup();
  }

  proto._removeGroup = function(){
    $('table#groups-list tr td a#remove').on("ajax:success", function(e, data, status, xhr){
      self = e.target
      $(self).parent().parent().remove();
      taskTracker.update_flash(data.message);
    }.bind(this));
  }
})(taskTracker);
