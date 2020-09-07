({
    getPrimaryNeg: function(component, event, helper) {
        var rid = component.get("v.recordId");
        var action = component.get("c.getPrimaryNeg"); // Calling apex method
        action.setParams({ recordId: rid });
        action.setCallback(this, function(data) {
            var state = data.getState();
            if (state === "SUCCESS") {
                var prmNeg = data.getReturnValue();
                
                if(prmNeg != null){
                    component.set("v.selTabId ", prmNeg);
                }else{
                    component.set("v.selTabId ", "tab1");
                }
                
                /**var workspaceAPI = component.find("workspace");
			console.log('focusedTabId################'+workspaceAPI);
            workspaceAPI.setTabHighlighted({
                tabId: prmNeg,
                highlighted: true,
                options: {
                    pulse: true,
                    state: "success"
         }
            });*/
                
                //$A.get('e.force:refreshView').fire();
            } else if (state === "ERROR") {
                var errors = data.getError();
                console.error(errors);
            }
        });
        
        $A.enqueueAction(action);
    },
    getNegotiator1Values: function(component, event, helper){
        var rid = component.get("v.recordId");
        var action = component.get("c.getNegotiator1Values"); // Calling apex method
        action.setParams({ recordId: rid });
        action.setCallback(this, function(data) {
            var state = data.getState();
            if (state === "SUCCESS") {
                var records = data.getReturnValue();
                records.forEach(function(record){
                    component.set("v.aADValue", record.ExperisPricing__Additional_Discount__c);
                    component.set("v.adD", record.ExperisPricing__Additional_Discount_Amt__c);
                    component.set("v.ncprice", record.ExperisPricing__Customer_Price1__c);
                    component.set("v.ncpricePct", (record.ExperisPricing__Customer_Price1__c/record.ExperisPricing__List_Price__c)*100);
                    component.set("v.niprice", record.ExperisPricing__Invoice_Price1__c);
                    component.set("v.nipricePct", (record.ExperisPricing__Invoice_Price1__c/record.ExperisPricing__List_Price__c)*100);
                    component.set("v.nnprice", record.ExperisPricing__Net_Price1__c);
                    component.set("v.nnpricePct", (record.ExperisPricing__Net_Price1__c/record.ExperisPricing__List_Price__c)*100);
                    component.set("v.npprice", record.ExperisPricing__Pocket_Price1__c);
                    component.set("v.nppricePct", (record.ExperisPricing__Pocket_Price1__c/record.ExperisPricing__List_Price__c)*100);
                    component.set("v.npmargin", record.ExperisPricing__Pocket_Margin1__c);
                    component.set("v.npmarginPct", (record.ExperisPricing__Pocket_Margin1__c/record.ExperisPricing__List_Price__c)*100);
                    //component.set("v.aADValue3", record.ExperisPricing__Additional_Discount__c);
                    //component.set("v.aADValue3", record.ExperisPricing__Additional_Discount__c);
                    //component.set("v.aADValue3", record.ExperisPricing__Additional_Discount__c);
                    //component.set("v.aADValue3", record.ExperisPricing__Additional_Discount__c);
                });
            }
        });
        $A.enqueueAction(action);
    },
    getNegotiator2Values: function(component, event, helper){
        var rid = component.get("v.recordId");
        var action = component.get("c.getNegotiator2Values"); // Calling apex method
        action.setParams({ recordId: rid });
        action.setCallback(this, function(data) {
            var state = data.getState();
            if (state === "SUCCESS") {
                var records = data.getReturnValue();
                records.forEach(function(record){
                    component.set("v.aADValue2", record.ExperisPricing__Additional_Discount__c);
                    component.set("v.adD", record.ExperisPricing__Additional_Discount_Amt__c);
                    component.set("v.ncprice2", record.ExperisPricing__Customer_Price1__c);
                    component.set("v.ncpricePct2", (record.ExperisPricing__Customer_Price1__c/record.ExperisPricing__List_Price__c)*100);
                    component.set("v.niprice2", record.ExperisPricing__Invoice_Price1__c);
                    component.set("v.nipricePct2", (record.ExperisPricing__Invoice_Price1__c/record.ExperisPricing__List_Price__c)*100);
                    component.set("v.nnprice2", record.ExperisPricing__Net_Price1__c);
                    component.set("v.nnpricePct2", (record.ExperisPricing__Net_Price1__c/record.ExperisPricing__List_Price__c)*100);
                    component.set("v.npprice2", record.ExperisPricing__Pocket_Price1__c);
                    component.set("v.nppricePct2", (record.ExperisPricing__Pocket_Price1__c/record.ExperisPricing__List_Price__c)*100);
                    component.set("v.npmargin2", record.ExperisPricing__Pocket_Margin1__c);
                    component.set("v.npmarginPct2", (record.ExperisPricing__Pocket_Margin1__c/record.ExperisPricing__List_Price__c)*100);
                    //component.set("v.aADValue3", record.ExperisPricing__Additional_Discount__c);
                    //component.set("v.aADValue3", record.ExperisPricing__Additional_Discount__c);
                    //component.set("v.aADValue3", record.ExperisPricing__Additional_Discount__c);
                    //component.set("v.aADValue3", record.ExperisPricing__Additional_Discount__c);
                });
            }
        });
        $A.enqueueAction(action);
    },
    getNegotiator3Values: function(component, event, helper){
        var rid = component.get("v.recordId");
        var action = component.get("c.getNegotiator3Values"); // Calling apex method
        action.setParams({ recordId: rid });
        action.setCallback(this, function(data) {
            var state = data.getState();
            if (state === "SUCCESS") {
                var records = data.getReturnValue();
                records.forEach(function(record){
                    component.set("v.aADValue3", record.ExperisPricing__Additional_Discount__c);
                    component.set("v.adD", record.ExperisPricing__Additional_Discount_Amt__c);
                    component.set("v.ncprice3", record.ExperisPricing__Customer_Price__c);
                    component.set("v.ncpricePct2", (record.ExperisPricing__Customer_Price__c/record.ExperisPricing__List_Price1__c)*100);
                    component.set("v.niprice3", record.ExperisPricing__Invoice_Price__c);
                    component.set("v.nipricePct3", (record.ExperisPricing__Invoice_Price__c/record.ExperisPricing__List_Price1__c)*100);
                    component.set("v.nnprice3", record.ExperisPricing__Net_Price__c);
                    component.set("v.nnpricePct3", (record.ExperisPricing__Net_Price__c/record.ExperisPricing__List_Price1__c)*100);
                    component.set("v.npprice3", record.ExperisPricing__Pocket_Price__c);
                    component.set("v.nppricePct3", (record.ExperisPricing__Pocket_Price__c/record.ExperisPricing__List_Price1__c)*100);
                    component.set("v.npmargin3", record.ExperisPricing__Pocket_Margin__c);
                    component.set("v.npmarginPct3", (record.ExperisPricing__Pocket_Margin__c/record.ExperisPricing__List_Price1__c)*100);
                    //component.set("v.aADValue3", record.ExperisPricing__Additional_Discount__c);
                    //component.set("v.aADValue3", record.ExperisPricing__Additional_Discount__c);
                    //component.set("v.aADValue3", record.ExperisPricing__Additional_Discount__c);
                    //component.set("v.aADValue3", record.ExperisPricing__Additional_Discount__c);
                });
                
            }
        });
        $A.enqueueAction(action);
    },
    saveOnClick: function(component, event, helper) {
        var rid = component.get("v.recordId");
        var eventFields = event.getParam("fields"); //get the fields
        var ef = JSON.stringify(eventFields);
        var action = component.get("c.getQuoteId"); // Calling apex method
        action.setParams({ recordId: rid, qFields: ef });
        action.setCallback(this, function(data) {
            var state = data.getState();
            if (state === "SUCCESS") {
                var qID = data.getReturnValue();
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    url:
                    "/apex/sbqq__sb?scontrolCaching=1&id=" +
                    qID +
                    "#quote/le?qId=" +
                    qID
                });
                urlEvent.fire();
                $A.get("e.force:refreshView").fire();
            } else if (state === "ERROR") {
                var errors = data.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
    },
    saveOnClick2: function(component, event, helper) {
        var rid = component.get("v.recordId");
        var eventFields = event.getParam("fields"); //get the fields
        var ef = JSON.stringify(eventFields);
        var action = component.get("c.getQuoteId2"); // Calling apex method
        action.setParams({ recordId: rid, qFields: ef });
        action.setCallback(this, function(data) {
            var state = data.getState();
            if (state === "SUCCESS") {
                var qID = data.getReturnValue();
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    url:
                    "/apex/sbqq__sb?scontrolCaching=1&id=" +
                    qID +
                    "#quote/le?qId=" +
                    qID
                });
                urlEvent.fire();
                $A.get("e.force:refreshView").fire();
            } else if (state === "ERROR") {
                var errors = data.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
    },
    saveOnClick3: function(component, event, helper) {
        var rid = component.get("v.recordId");
        var eventFields = event.getParam("fields"); //get the fields
        var ef = JSON.stringify(eventFields);
        var action = component.get("c.getQuoteId3"); // Calling apex method
        action.setParams({ recordId: rid, qFields: ef });
        action.setCallback(this, function(data) {
            var state = data.getState();
            if (state === "SUCCESS") {
                var qID = data.getReturnValue();
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    url:
                    "/apex/sbqq__sb?scontrolCaching=1&id=" +
                    qID +
                    "#quote/le?qId=" +
                    qID
                });
                urlEvent.fire();
                $A.get("e.force:refreshView").fire();
            } else if (state === "ERROR") {
                var errors = data.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
    },
    calculate: function(component){
        var ad = component.find("adF").get("v.value");
        if (ad != undefined) {
        var pc = component.find("pcD").get("v.value");
        var vd = component.find("vD").get("v.value");
        var adj = component.find("adjF").get("v.value");
        var lp = component.find("lpD").get("v.value");
        if(isNaN(pc)){ pc = 0; }
        if(isNaN(vd)){ vd = 0; }
        if(isNaN(ad)){ ad = 0; }
        if(isNaN(lp)){ lp = 0; }
        if (ad != 0) {
            var adA = (ad * lp) / 100;
        }else{
            var adA = (adj * lp) / 100;
        }
        var nCP = lp - (adA + pc + vd);
        component.set("v.adD", adA);
        component.set("v.ncprice", nCP);
        var asd = (nCP/lp) * 100;
        component.set("v.ncpricePct", asd);
        //var os = component.find("osD").get("v.value");
        var fr = component.find("frD").get("v.value");
        if(fr == undefined) {
                         fr = component.get("v.OpptyRecord").ExperisPricing__Freight_Charge_Percent__c;
        } else if(isNaN(fr)){ fr = 0; }
        //if(isNaN(os)){ os = 0; }
        var frP = (fr*lp)/100;
        component.set("v.frprice", frP);
        var niP = nCP + frP;
        var niPP = (niP/lp) * 100;
        component.set("v.niprice", niP);
        component.set("v.nipricePct", niPP);
        var rr = component.find("rrD").get("v.value");
        var vr = component.find("vrD").get("v.value");
        if(isNaN(rr) || rr==null){ rr = 0; }
        if(isNaN(vr)){ vr = 0; }
        var nnP = niP - (rr + vr);
        var nnPP = (nnP/lp) * 100;
        component.set("v.nnprice", nnP);
        component.set("v.nnpricePct", nnPP);
        var fc = component.find("fcD").get("v.value");
        var sec = component.find("secD").get("v.value");
        if(isNaN(fc)){ fc = 0; }
        if(isNaN(sec)){ sec = 0; }
        var npP = nnP - (fc + sec);
        var npPP = (npP/lp) * 100;
        component.set("v.nppricePct", npPP);
        component.set("v.npprice", npP);
        var sc = component.find("scD").get("v.value");
        if(isNaN(sc)){ sc = 0; }
        var npM = npP - sc;
        var npMP = (npM/lp) * 100;
        component.set("v.npmargin", npM);
        component.set("v.npmarginPct", npMP);
        }
    },
    calculate2: function(component){
        var ad = component.find("adF2").get("v.value");
 		var fr = component.find("frD2").get("v.value");
        if (ad != undefined) {
        var pc = component.find("pcD2").get("v.value");
        var vd = component.find("vD2").get("v.value");
        var adj = component.find("adjF2").get("v.value");
        var lp = component.find("lpD2").get("v.value");
        if(isNaN(pc)){ pc = 0; }
        if(isNaN(vd)){ vd = 0; }
        if(isNaN(ad)){ ad = 0; }
        if(isNaN(lp)){ lp = 0; }
        if (ad != 0) {
            var adA = (ad * lp) / 100;
        }else{
            var adA = (adj * lp) / 100;
        }
        var nCP = lp - (adA + pc + vd);
        component.set("v.adD2", adA);
        component.set("v.ncprice2", nCP);
        var asd = (nCP/lp) * 100;
        component.set("v.ncpricePct2", asd);
        //var os = component.find("osD2").get("v.value");
        if(fr == undefined) {
                         fr = component.get("v.OpptyRecord").ExperisPricing__Freight_Charge_Percent__c;
        } else if(isNaN(fr)){ fr = 0; }
        //if(isNaN(os)){ os = 0; }
        var frP = (fr*lp)/100;
        component.set("v.frprice2", frP);
        var niP = nCP + frP;
        var niPP = (niP/lp) * 100;
        component.set("v.niprice2", niP);
        component.set("v.nipricePct2", niPP);
        var rr = component.find("rrD2").get("v.value");
        var vr = component.find("vrD2").get("v.value");
        if(isNaN(rr) || rr==null){ rr = 0; }
        if(isNaN(vr)){ vr = 0; }
        var nnP = niP - (rr + vr);
        var nnPP = (nnP/lp) * 100;
        component.set("v.nnprice2", nnP);
        component.set("v.nnpricePct2", nnPP);
        var fc = component.find("fcD2").get("v.value");
        var sec = component.find("secD2").get("v.value");
        if(isNaN(fc)){ fc = 0; }
        if(isNaN(sec)){ sec = 0; }
        var npP = nnP - (fc + sec);
        var npPP = (npP/lp) * 100;
        component.set("v.nppricePct2", npPP);
        component.set("v.npprice2", npP);
        var sc = component.find("scD2").get("v.value");
        if(isNaN(sc)){ sc = 0; }
        var npM = npP - sc;
        var npMP = (npM/lp) * 100;
        component.set("v.npmargin2", npM);
        component.set("v.npmarginPct2", npMP);
        }
    },
    calculate3: function(component){
        var ad = component.find("adF3").get("v.value");
        if (ad != undefined) {
        var pc = component.find("pcD3").get("v.value");
        var vd = component.find("vD3").get("v.value");
        var adj = component.find("adjF3").get("v.value");
        var lp = component.find("lpD3").get("v.value");
        if(isNaN(pc)){ pc = 0; }
        if(isNaN(vd)){ vd = 0; }
        if(isNaN(ad)){ ad = 0; }
        if(isNaN(lp)){ lp = 0; }
        if (ad != 0) {
            var adA = (ad * lp) / 100;
        }else{
            var adA = (adj * lp) / 100;
        }
        var nCP = lp - (adA + pc + vd);
        component.set("v.adD3", adA);
        component.set("v.ncprice3", nCP);
        var asd = (nCP/lp) * 100;
        component.set("v.ncpricePct3", asd);
        var fr = component.find("frD3").get("v.value");
        //var os = component.find("osD3").get("v.value");
        if(fr == undefined) {
                         fr = component.get("v.OpptyRecord").ExperisPricing__Freight_Charge_Percent__c;
        } else if(isNaN(fr)){ fr = 0; }
            
        //if(isNaN(os)){ os = 0; }
        var frP = (fr*lp)/100;
        component.set("v.frprice3", frP);
        var niP = nCP + frP;
        var niPP = (niP/lp) * 100;
        component.set("v.niprice3", niP);
        component.set("v.nipricePct3", niPP);
        var rr = component.find("rrD3").get("v.value");
        var vr = component.find("vrD3").get("v.value");
        if(isNaN(rr) || rr==null){ rr = 0; }
        if(isNaN(vr)){ vr = 0; }
        var nnP = niP - (rr + vr);
        var nnPP = (nnP/lp) * 100;
        component.set("v.nnprice3", nnP);
        component.set("v.nnpricePct3", nnPP);
        var fc = component.find("fcD3").get("v.value");
        var sec = component.find("secD3").get("v.value");
        if(isNaN(fc)){ fc = 0; }
        if(isNaN(sec)){ sec = 0; }
        var npP = nnP - (fc + sec);
        var npPP = (npP/lp) * 100;
        component.set("v.nppricePct3", npPP);
        component.set("v.npprice3", npP);
        var sc = component.find("scD3").get("v.value");
        if(isNaN(sc)){ sc = 0; }
        var npM = npP - sc;
        var npMP = (npM/lp) * 100;
        component.set("v.npmargin3", npM);
        component.set("v.npmarginPct3", npMP);
        }
    },
    getFreightCharge: function(component, event, helper) {
        var lookupId = event.getParam("value");
        if (lookupId != "") {
        	var productFamily = component.find("pFId").get("v.value");
        var rid = component.get("v.recordId");
        var action = component.get("c.getFreightChargePct"); // Calling apex method
        action.setParams({ lookupId: lookupId,
                          productFamily: productFamily});
        action.setCallback(this, function(data) {
            var state = data.getState();
            if (state === "SUCCESS") {
                var frtChg = data.getReturnValue();
                console.log("freightCharge	$$$$$$$$$$$$$$$$$$$$$$$$$$$$       " + frtChg);
                if(frtChg != null){
                    component.set("v.fcPct",frtChg);
                    var lp = component.find("lpD").get("v.value");
            		var frP = (frtChg*lp)/100;        
                    component.set("v.frprice",frP);
                }
                } else if (state === "ERROR") {
                var errors = data.getError();
                console.error(errors);
                }
        });     
        $A.enqueueAction(action);
             }else {
                    component.set("v.fcPct",0.0);
                    component.set("v.frprice",0.0);
                }
   
    },
    getFreightCharge2: function(component, event, helper) {
        var lookupId = event.getParam("value");
        if (lookupId != "") {
        	var productFamily = component.find("pFId2").get("v.value");
        var rid = component.get("v.recordId");
        var action = component.get("c.getFreightChargePct"); // Calling apex method
        action.setParams({ lookupId: lookupId,
                          productFamily: productFamily});
        action.setCallback(this, function(data) {
            var state = data.getState();
            if (state === "SUCCESS") {
                var frtChg = data.getReturnValue();
                console.log("freightCharge	$$$$$$$$$$$$$$$$$$$$$$$$$$$$       " + frtChg);
                if(frtChg != null){
                    component.set("v.fcPct2",frtChg);
                    var lp = component.find("lpD2").get("v.value");
            		var frP = (frtChg*lp)/100;        
                    component.set("v.frprice2",frP);
                }
                } else if (state === "ERROR") {
                var errors = data.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
             }else {
                    component.set("v.fcPct2",0.0);
                    component.set("v.frprice2",0.0);
                }
   
    },
    getFreightCharge3: function(component, event, helper) {
        var lookupId = event.getParam("value");
        if (lookupId != "") {
            var productFamily = component.find("pFId3").get("v.value");
        var rid = component.get("v.recordId");
        var action = component.get("c.getFreightChargePct"); // Calling apex method
        action.setParams({ lookupId: lookupId,
                          productFamily: productFamily});
        action.setCallback(this, function(data) {
            var state = data.getState();
            if (state === "SUCCESS") {
                var frtChg = data.getReturnValue();
                console.log("freightCharge	$$$$$$$$$$$$$$$$$$$$$$$$$$$$       " + frtChg);
                if(frtChg != null){
                    component.set("v.fcPct3",frtChg);
                    var lp = component.find("lpD3").get("v.value");
            		var frP = (frtChg*lp)/100;        
                    component.set("v.frprice3",frP);
                }
                } else if (state === "ERROR") {
                var errors = data.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
                 }else {
                    component.set("v.fcPct3",0.0);
                    component.set("v.frprice3",0.0);
                }
   
    },
    getPriceAdjFromPolicy: function(component, event, helper) {
        var rid = component.get("v.recordId");
        var action = component.get("c.getPriceAdjs"); // Calling apex method
        action.setParams({recordId: rid});
        action.setCallback(this, function(data) {
            var state = data.getState();
            if (state === "SUCCESS") {
                var priceAdj = data.getReturnValue();
   				var glPrc = Number(priceAdj.BasePrice)+Number(priceAdj.FamilyPriceAdjustment)+Number(priceAdj.ProductAdjustment);
   				var familyPrcAdj = (priceAdj.FamilyPriceAdjustment * priceAdj.BasePrice)/100;
        		var prdAdj = (priceAdj.ProductAdjustment * priceAdj.BasePrice)/100;
        		component.set("v.ProductName",priceAdj.ProductName);
                component.set("v.bpprice", priceAdj.BasePrice);
                component.set("v.faprice", familyPrcAdj);
                component.set("v.pdprice", prdAdj);
                component.set("v.glprice", glPrc);
                component.set("v.bpprice2", priceAdj.BasePrice);
                component.set("v.faprice2", familyPrcAdj);
                component.set("v.pdprice2", prdAdj);
                component.set("v.glprice2", glPrc);
                component.set("v.bpprice3", priceAdj.BasePrice);
                component.set("v.faprice3", familyPrcAdj);
                component.set("v.pdprice3", prdAdj);
                component.set("v.glprice3", glPrc);
                
                component.set("v.bpPct",(priceAdj.BasePrice/priceAdj.ListPrice)*100);
                component.set("v.bpPct2",(priceAdj.BasePrice/priceAdj.ListPrice)*100);
                component.set("v.bpPct3",(priceAdj.BasePrice/priceAdj.ListPrice)*100);
                component.set("v.faPct",(familyPrcAdj/priceAdj.ListPrice)*100);
                component.set("v.faPct2",(familyPrcAdj/priceAdj.ListPrice)*100);
                component.set("v.faPct3",(familyPrcAdj/priceAdj.ListPrice)*100);
				component.set("v.pdPct",(prdAdj/priceAdj.ListPrice)*100);
                component.set("v.pdPct2",(prdAdj/priceAdj.ListPrice)*100);
                component.set("v.pdPct3",(prdAdj/priceAdj.ListPrice)*100);
                component.set("v.glPct",(glPrc/priceAdj.ListPrice)*100);
                component.set("v.glPct2",(glPrc/priceAdj.ListPrice)*100);
                component.set("v.glPct3",(glPrc/priceAdj.ListPrice)*100);
   
                component.set("v.secprice", priceAdj.ServiceCost);
                component.set("v.secprice2", priceAdj.ServiceCost);
                component.set("v.secprice3", priceAdj.ServiceCost);
                component.set("v.scprice", priceAdj.StandardCost);
                component.set("v.scprice2", priceAdj.StandardCost);
                component.set("v.scprice3", priceAdj.StandardCost);
                component.set("v.vrprice", priceAdj.VolumeRebate);
                component.set("v.vrprice2", priceAdj.VolumeRebate);
                component.set("v.vrprice3", priceAdj.VolumeRebate);
   				component.set("v.frcprice", priceAdj.FreightCost);
                component.set("v.frcprice2", priceAdj.FreightCost);
                component.set("v.frcprice3", priceAdj.FreightCost);
                component.set("v.rrprice", priceAdj.DistrubutorRebate);
        		component.set("v.rrprice2", priceAdj.DistrubutorRebate);
        		component.set("v.rrprice3", priceAdj.DistrubutorRebate);
        
                
                component.set("v.secPct", (priceAdj.ServiceCost/priceAdj.ListPrice)*100);
                component.set("v.secPct2", (priceAdj.ServiceCost/priceAdj.ListPrice)*100);
                component.set("v.secPct3", (priceAdj.ServiceCost/priceAdj.ListPrice)*100);
                component.set("v.scPct", (priceAdj.StandardCost/priceAdj.ListPrice)*100);
                component.set("v.scPct2", (priceAdj.StandardCost/priceAdj.ListPrice)*100);
                component.set("v.scPct3", (priceAdj.StandardCost/priceAdj.ListPrice)*100);
                component.set("v.vrPct", (priceAdj.VolumeRebate/priceAdj.ListPrice)*100);
                component.set("v.vrPct2", (priceAdj.VolumeRebate/priceAdj.ListPrice)*100);
                component.set("v.vrPct3", (priceAdj.VolumeRebate/priceAdj.ListPrice)*100);
   				component.set("v.frcPct", (priceAdj.FreightCost/priceAdj.ListPrice)*100);
                component.set("v.frcPct2", (priceAdj.FreightCost/priceAdj.ListPrice)*100);
                component.set("v.frcPct3", (priceAdj.FreightCost/priceAdj.ListPrice)*100);
                component.set("v.rrPct",(priceAdj.DistrubutorRebate / priceAdj.ListPrice) * 100);
        		component.set("v.rrPct2",(priceAdj.DistrubutorRebate / priceAdj.ListPrice) * 100);
        		component.set("v.rrPct3",(priceAdj.DistrubutorRebate / priceAdj.ListPrice) * 100);
                
               } else if (state === "ERROR") {
                var errors = data.getError();
                console.error(errors);
            }
            });
        $A.enqueueAction(action);
        
    }
});