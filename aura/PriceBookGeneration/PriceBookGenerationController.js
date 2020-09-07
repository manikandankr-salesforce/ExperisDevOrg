({
    doInit : function(component, event, helper) {
        component.set("v.mycolumns",[
                                      {label: 'Product', fieldName: 'linkName', type: 'url', 
            typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'},initialWidth:200,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Product Family", fieldName: "ExperisPricing__Product_Family_Name__c",type: "text",initialWidth:150,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Density", fieldName: "ExperisPricing__Density__c",type: "text",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Base Price", fieldName: "ExperisPricing__Base_Price__c",type: "currency",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Family Adj", fieldName: "ExperisPricing__Family_Adj_Amt__c",type: "currency",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Product Adj", fieldName: "ExperisPricing__Product_Adj_Amt__c",type: "currency",initialWidth:120,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Manual Override", fieldName: "ExperisPricing__Manual_Override_Amt__c",type: "currency",initialWidth:150,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "List Price", fieldName: "UnitPrice",type: "currency",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Past Revenue", fieldName: "ExperisPricing__Past_Revenue__c",type: "currency",initialWidth:150,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Quantity", fieldName: "ExperisPricing__Quantity__c",type: "number",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Start Date", fieldName: "ExperisPricing__Start_Date__c",type: "date",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "End Date", fieldName: "ExperisPricing__End_date__c",type: "date",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Status", fieldName: "ExperisPricing__Status__c",type: "text",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}}                                    
                                    ]);
		helper.doInitialize(component, event, helper);
    },
    
    generateRecord : function(component, event, helper) {
        console.log("inside generate Controller");
        component.set("v.mycolumns",[
                                      {label: 'Product', fieldName: 'linkName', type: 'url', 
            typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'},initialWidth:200,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Product Family", fieldName: "ExperisPricing__Product_Family_Name__c",type: "text",initialWidth:150,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Density", fieldName: "ExperisPricing__Density__c",type: "text",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Base Price", fieldName: "ExperisPricing__Base_Price__c",type: "currency",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Family Adj", fieldName: "ExperisPricing__Family_Adj_Amt__c",type: "currency",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Product Adj", fieldName: "ExperisPricing__Product_Adj_Amt__c",type: "currency",initialWidth:120,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Manual Override", fieldName: "ExperisPricing__Manual_Override_Amt__c",type: "currency",initialWidth:150,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "List Price", fieldName: "UnitPrice",type: "currency",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Past Revenue", fieldName: "ExperisPricing__Past_Revenue__c",type: "currency",initialWidth:150,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Quantity", fieldName: "ExperisPricing__Quantity__c",type: "number",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Start Date", fieldName: "ExperisPricing__Start_Date__c",type: "date",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "End Date", fieldName: "ExperisPricing__End_date__c",type: "date",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
                                     { label: "Status", fieldName: "ExperisPricing__Status__c",type: "text",initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}}                                    
                                    ]);
        helper.generateOnClick(component, event, helper);
    },
    
    saveRecords : function(component, event, helper) {
        	helper.saveOnClick(component, event, helper);
    },
    submitForApproval: function(component, event, helper) {
        	helper.submitOnClick(component, event, helper);
    },
    previewApproval : function(component, event, helper) {
        var rid = component.get("v.recordId");
        var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                      "url": '/apex/PreviewApprovals?Id=' + rid
                    });
                    urlEvent.fire();
	}
})