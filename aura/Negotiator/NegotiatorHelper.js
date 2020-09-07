({
	saveOnClick : function(component, event, helper) {
		var rid = component.get("v.recordId");
        var action =  component.get('c.getQuoteId');  // Calling apex method
        action.setParams({ recordId : rid });
       	action.setCallback(this, function(data) {
       	var state = data.getState();
       	if(state === "SUCCESS") {
           	var qID =data.getReturnValue();
        	var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                      "url": '/apex/sbqq__sb?scontrolCaching=1&id='+qID+'#quote/le?qId='+qID
                    });
                    urlEvent.fire();
            $A.get('e.force:refreshView').fire();
           }else if (state === "ERROR"){
           var errors = data.getError();
           console.error(errors);
       }
                          });
       $A.enqueueAction(action);
	}
})