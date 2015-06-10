// Can attach to form fields and allow them to be fillable if another
// item is changed when this one is blank
//
// Example:
//   <select id="campaign_dfp_order">
//      <option value=""></option>
//      <option value="267070984">Andrew G.'s Test Order</option>
//   </select>
//   ...
//   <input name="order_name" data-connectable-to="campaign_dfp_order" type="text" >
//
// In this case when the  text input field is empty any change to the campaign dfp order
// field will result in the text input field assuming it's value
// field (if blank)
//
//
// It is chainable too...
//  <input id="order_name" data-connectable-to="campaign_dfp_order" type="text" >
//  <input data-connectable-to="order_name" type="text" >
//
//  Now this second text field is chained so it will be updated as the first one is updated.

ConnectableInterface = (function($){
  "use strict";

  var connections = [];
  var connectorAttribute =   "data-connectable-to";

  function shouldConnect(receiver, source){
    return $(receiver).val() === '' ||
           $(receiver).val() === sourceVal(source, receiver);
  }

  function sourceVal(source, receiver){
    var value = $(source).val();

    // Going from a selector to a text field we need to take the name of the option
    if(source.tagName === "SELECT" && (receiver.tagName !== "SELECT" &&
                                       receiver.tagName !== "CHECKBOX" &&
                                       receiver.tagName !== "RADIO")){
      return $(source).find('[value="' + value + '"]').text();
    }

    return value;
  }

  function reclassify(connectionObject){
    if(connectionObject.connected){
      $(connectionObject.receiver).addClass('connectable-receiver');
    } else {
      $(connectionObject.receiver).removeClass('connectable-receiver');
    }
  }

  function checkConnection(event){
    var receiver = event.currentTarget;

    event.data.connections.forEach(function(connection){
      if(connection.receiver == receiver){
        connection.connected = shouldConnect(connection.receiver, connection.source);
        if(connection.connected){
          // If we are now connected lets trigger a change and pick up the value
          $(connection.source).trigger('synthetic-change');
        }
        reclassify(connection);
      }
    });
  }

  function UpdateConnections(event){
    var source = event.currentTarget;

    event.data.connections.forEach(function(connection){
      if(connection.connected && connection.enabled && connection.source === source){
        var value = sourceVal(connection.source, connection.receiver);

        // Trigger a change on receiver for chainability
        $(connection.receiver).val(value).trigger('synthetic-change');
      }
    });
  }

  function attachToFields(){

    var $fields = $('[' + connectorAttribute + ']');

    $fields.map(function(){
      var $receiverField = $(this);
      var $sourceField = $('#' + $receiverField.attr(connectorAttribute));
      var isConnected = shouldConnect($receiverField[0], $sourceField[0]);

      connections.push({
        receiver:  $receiverField.get(0),
        source:    $sourceField.get(0),
        connected: isConnected,
        enabled:   true
      });

      $receiverField.on('change blur', {
        connections: connections
      }, checkConnection);

      $sourceField.on('change keyup synthetic-change', {
        connections: connections
      }, UpdateConnections);
    });
  }

  return {
    init : attachToFields
  };
})(jQuery);

// After DOM ready
jQuery(function(){
  ConnectableInterface.init();
});