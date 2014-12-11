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
      this._update_flash(data.message);
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
