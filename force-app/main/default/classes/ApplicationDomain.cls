/**
 * Application level domain class that allows for customizing fflib domain class behaviour
 **/
public inherited sharing abstract class ApplicationDomain extends fflib_SObjectDomain {
    public ApplicationDomain(List<SObject> records){
        super(records);
        Configuration.disableTriggerCRUDSecurity();
    }
}