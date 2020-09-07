({
 saveRecords : function(component, event, helper) {
       		//helper.saveOnClick(component, event, helper); 
            $A.get('e.force:refreshView').fire();

	},
    cancel : function(component, event, helper){
        $A.get("e.force:closeQuickAction").fire();
    }
})