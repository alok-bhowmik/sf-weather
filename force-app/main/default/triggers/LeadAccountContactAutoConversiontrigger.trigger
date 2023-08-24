trigger LeadAccountContactAutoConversiontrigger on Lead (after insert) {
  LeadAccountContactAutoConversionHandler.LeadAccountContactAutoConversionMethod(trigger.new);
}