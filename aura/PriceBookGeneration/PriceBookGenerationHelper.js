({
    doInitialize : function(component,event,helper){
       var rid = component.get("v.recordId");
       var action=  component.get('c.getInitResult');  // Calling apex method
       action.setParams({ recordId : rid });
       action.setCallback(this, function(data) {
       var state = data.getState();
       if(state === "SUCCESS") {
            var records =data.getReturnValue();
               records.forEach(function(record){
                   record.linkName = '/'+record.Product2Id;
               });
           component.set("v.mydata", records);
       }else if (state === "ERROR"){
           var errors = data.getError();
           console.error(errors);
       }
                          });
       $A.enqueueAction(action);
   },
   
   generateOnClick : function(component, event, helper) {
        console.log("inside generate helper");
       var rid = component.get("v.recordId");
       var action = component.get("c.getProductRecords");
       action.setParams({ recordId : rid });
       action.setCallback(this, function(data) {
       var state = data.getState();
       if(state === "SUCCESS") {
            var records =data.getReturnValue();
               records.forEach(function(record){
                   record.linkName = '/'+record.Product2Id;
               });
           component.set("v.mydata", records);
       }else if (state === "ERROR"){
           var errors = data.getError();
           console.error(errors);
       }
                          });
       $A.enqueueAction(action);
   },
   
   saveOnClick : function(component, event, helper) {
           var recordList = component.get("v.mydata");
           var idListJSON = JSON.stringify(recordList);
           var rid = component.get("v.recordId");
            var action = component.get("c.setPBEntryRecords");
           action.setParams({
               pbrecords : idListJSON,
               recordId : rid
               });
           action.getCallback(function(data) {
               var state = data.getState();
               if(state === "SUCCESS" || state === "DRAFT") {
                   alert ("Saved Successfully!!");
                   console.log("Save completed successfully.");
               } else if (state === "INCOMPLETE") {
                   console.log("User is offline, device doesn't support drafts.");
               }else if (state === "ERROR"){
                   var errors = data.getError();
                   console.error(errors);
               }
               else {
               console.log('Unknown problem, state: ' + state + ', error: ' + JSON.stringify(error));
               }
                          });
       $A.enqueueAction(action);
   },
   
   submitOnClick : function(component, event, helper) {
       var rid = component.get("v.recordId");
       var action = component.get("c.onSubmit");
       action.setParams({ recordId : rid });
       action.setCallback(this, function(data) {
       var state = data.getState();
       if(state === "SUCCESS") {
          var urlEvent = $A.get("e.force:navigateToURL");
           urlEvent.setParams({
             "url": '/' + rid
           });
           urlEvent.fire();

       }else if (state === "ERROR"){
           var errors = data.getError();
           console.error(errors);
       }
       });
       $A.enqueueAction(action);
   }
})