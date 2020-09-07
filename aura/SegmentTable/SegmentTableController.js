({
    init: function (component, event, helper) {
        component.set('v.columns', [
            {label: 'Product Name', fieldName: 'Name', type: 'text',initialWidth:200,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'No Of Transaction', fieldName: 'ExperisPricing__No_Of_Transcation__c', type: 'text',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'From Date', fieldName: 'ExperisPricing__From_Date__c', type:'date-local',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'To Date', fieldName: 'ExperisPricing__To_Date__c', type:'date-local',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'Margin Amount', fieldName: 'ExperisPricing__Margin_Amount__c', type: 'currency',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'Revenue', fieldName: 'ExperisPricing__Revenue__c', type: 'currency',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: '97th Percentile', fieldName: 'ExperisPricing__X97th_Percentile__c', type: 'number',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: '3rd Percentile', fieldName: 'ExperisPricing__X3rd_Percentile__c', type: 'number',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'Margin To List', fieldName: 'ExperisPricing__Margin_To_List__c', type: 'number',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'Minimum Percentile', fieldName: 'ExperisPricing__Minimum_Percentile_Discount__c', type: 'number',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'Maximum Percentile', fieldName: 'ExperisPricing__Max_Percentile_Discount__c', type: 'number',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'Range Discount', fieldName: 'ExperisPricing__Range_Discount__c', type: 'number',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'SD Disocunt', fieldName: 'ExperisPricing__SD_Discount__c', type: 'number',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'Median Discount', fieldName: 'ExperisPricing__Median_Discount__c', type: 'number',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'Green%', fieldName: 'ExperisPricing__Green__c', type: 'number' ,initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'},editable: true},
            {label: 'Yellow%', fieldName: 'ExperisPricing__Yellow__c', type: 'number',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'} ,editable: true},
            {label: 'Red%', fieldName: 'ExperisPricing__Red__c', type: 'number' ,initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'},editable: true},
            {label: 'Active', fieldName: 'ExperisPricing__Active__c', type: 'boolean' ,initialWidth:60,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'Status', fieldName: 'ExperisPricing__Status__c', type: 'picklist' ,initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'}},
            {label: 'Valid', fieldName: 'ExperisPricing__Valid__c', type:'picklist',initialWidth:100,"max-column-width":4000,cellAttributes:{ aligment :'center'},editable: true}             
            ]);
        helper.fetchData(component,event, helper);
    },
 		onSave : function (component, event, helper) {
        helper.saveDataTable(component, event, helper);
    }
        
})