trigger SegmentTrigger on ExperisPricing__Opt_Segment__c (before update) {

    if(Trigger.isUpdate){
        for(ExperisPricing__Opt_Segment__c updatedSegment:Trigger.new)
      {
        updatedSegment.ExperisPricing__Valid__c='Override';
      }
        }
}