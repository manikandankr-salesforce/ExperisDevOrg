({
    doInit: function(component, event, helper) {
        //component.set('v.selTabId','tab2');
        var rid = component.get("v.recordId");
        console.log("recordId	$$$$$$$$$$$$$$$$$$$$$$$$$$$$       " + rid);
        helper.getPriceAdjFromPolicy(component, event, helper);
        helper.getNegotiator1Values(component, event, helper);
        helper.getNegotiator2Values(component, event, helper);
        helper.getNegotiator3Values(component, event, helper);
        helper.getPrimaryNeg(component, event, helper);
        //var fc = component.find("selTabId").get("v.value");
    },
    handleChange : function(component, event, helper) {        
        helper.getFreightCharge(component, event, helper);
        },
    handleChange2 : function(component, event, helper) {        
        helper.getFreightCharge2(component, event, helper);
        },
    handleChange3 : function(component, event, helper) {        
        helper.getFreightCharge3(component, event, helper);
        },
    handleOnSubmit: function(component, event, helper) {
        event.preventDefault(); //Prevent default submit
        var eventFields = event.getParam("fields"); //get the fields
        var button = component.get("v.buttonlabel");
        
        if (button === "button1") {
            //inserts only to negotiator
            //helper.calculate(component);
            helper.saveOnClick(component, event, helper);
        } else if (button === "button2") {
            //inserts to quoteLine and negotiator
            helper.saveOnClick(component, event, helper);
            eventFields.ExperisPricing__PrimaryNegotiator__c = "tab1";
            component.find("QuoteLineForm").submit(eventFields);
        } else if (button === "button3") {
            helper.calculate(component);
        }
    },
    
    Submit1: function(component, event, helper) {
        component.set("v.buttonlabel", "button1");
    },
    Submit2: function(component, event, helper) {
        component.set("v.buttonlabel", "button2");
    },
    Submit3: function(component, event, helper) {
        component.set("v.buttonlabel", "button3");
    },
    handleOnSubmitNeg2: function(component, event, helper) {
        event.preventDefault(); //Prevent default submit
        var eventFields = event.getParam("fields"); //get the fields
        var button = component.get("v.buttonlabel");
        var fields = event.getParam("fields");
        if (button === "button1") {
            //inserts only to negotiator
            //helper.calculate2(component);
            helper.saveOnClick2(component, event, helper);
        } else if (button === "button2") {
            //inserts to quoteLine and negotiator
            helper.saveOnClick2(component, event, helper);
            eventFields.ExperisPricing__PrimaryNegotiator__c = "tab2";
            component.find("QuoteLineForm2").submit(eventFields);
        } else if (button === "button3") {
            var eventFields = event.getParam("fields"); //get the fields
            helper.calculate2(component);
        }
    },
    handleOnSubmitNeg3: function(component, event, helper) {
        event.preventDefault(); //Prevent default submit
        var eventFields = event.getParam("fields"); //get the fields
        var button = component.get("v.buttonlabel");
        var fields = event.getParam("fields");
        if (button === "button1") {
            //inserts only to negotiator
            //helper.calculate3(component);
            helper.saveOnClick3(component, event, helper);
        } else if (button === "button2") {
            //inserts to quoteLine and negotiator
            helper.saveOnClick3(component, event, helper);
            eventFields.ExperisPricing__PrimaryNegotiator__c = "tab3";
            component.find("QuoteLineForm3").submit(eventFields);
        } else if (button === "button3") {
            var eventFields = event.getParam("fields"); //get the fields
            helper.calculate3(component);
        }
    },
    cancel: function(component,event,helper) {
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
		dismissActionPanel.fire();
    }
});