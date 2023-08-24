/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-21-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class DataLoaderToolHandler {

    @AuraEnabled
    public static List<All_Object__c> getObjectsFromCustomSettings(){
        try {
            return[SELECT Id, Name from All_Object__c ORDER BY Name ASC ];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

      
        @AuraEnabled
        public static List<SObject> insertObjectRecord (List<Object> objToInsert, String objectname, Boolean inserting){
          
           Type t = Type.forName('List<' + objectname +'>');
           System.debug('t -->'+t);
           String q='Select Id';
            List<SObject> castRecords = (List<SObject>)t.newInstance();
        
           
            for(Object obj : objToInsert) {
                Map<Object, Object> mapName = (Map<Object, Object>)(obj);
               
                Type t2 = Type.forName( objectname );
                System.debug('t2 -->'+t2);
                SObject castRecord = (SObject)t2.newInstance();
                System.debug('castRecord -->'+castRecord);

                q+=mapName.keySet();
                for(Object k : mapName.keySet()) {
                    System.debug('Inside K-->'+k);
                    castRecord.put((String)k, mapName.get(k));
    
                }
                castRecords.add(castRecord);
                System.debug('castRecord Add-->'+castRecord);
                System.debug('castRecord Add in map-->'+castRecords);
                q+= 'from'+ objectname+ '';
                System.debug('q ->'+ q);
                System.debug('q---->'+q);
                System.debug('castRecords'+castRecords);
            }

        Integer  first=q.indexOf('{');
        System.debug('first--->'+first);              
        Integer second = q.indexOf('{', first + 1);
        System.debug('second--->'+second);
        if(second!=-1)
        {
        q=q.substring(0,(q.indexOf('{', first + 1)));    
        System.debug('q--->'+q);        
        }
        System.debug('q--->'+q);
        q=q.replace('{',' ');
        q=q.replace('}',' ');
        System.debug('q--->'+q);
    
    //    List<SObject> Query = Database.query(q);
    //     System.debug('Query--->'+Query);
    //     System.debug('ObjRecords'+castRecords);
    
            if(inserting==true){
            upsert castRecords ;
                System.debug('Inserted Sucessfully -->');
                System.debug('ObjRecords==>'+castRecords);
            }           
        
        System.debug('ObjRecords==>'+castRecords);
        
        
        return castRecords;
        
            // if(inserting==true){
            //    insert castRecords;
            //    return castRecords;
               
            // }
          
           
          
          
        }

        @AuraEnabled
        public static List<SObject> updateData(List<Object> data,string objectname){
            System.debug('data -->'+data);
            System.debug('objectname -->'+objectname);
           
            Type  ObjectType = Type.forName('List<' + objectname +'>');
            System.debug('ObjectType -->'+ObjectType);
            List<SObject> ObjRecords = (List<SObject>)ObjectType.newInstance();
            System.debug('ObjRecords -->'+ObjRecords);
            for(Object obj : data) 
            {
                Map<Object, Object> mapName = (Map<Object, Object>)(obj);
                System.debug('mapName -->'+mapName);
                System.debug('mapName -->'+mapName.size());
                Type ObjType = Type.forName( objectname );
                System.debug('ObjType -->'+ObjType);
                SObject ObjRecord = (SObject)ObjType.newInstance();
                
                System.debug('ObjRecord -->'+ObjRecord);
                for(Object k : mapName.keySet())
                {
                  System.debug('k -->'+k);            
                   ObjRecord.put((String)k, mapName.get(k));
                   System.debug('ObjRecord.put((String)k, mapName.get(k)); -->'+ObjRecord.put((String)k, mapName.get(k)));
               }
               ObjRecords.add(ObjRecord);
            }
            System.debug('ObjRecords'+ObjRecords);
    
            update ObjRecords;
    
          
             return ObjRecords;
        }

        @AuraEnabled(cacheable=true)    
        public static List<FieldDefinition> getAllFields(string objectname){
         string query = 'select DeveloperName,QualifiedApiName from FieldDefinition where EntityDefinition.QualifiedApiName = :objectname ORDER BY DeveloperName ASC';
             list<FieldDefinition> lstObject = Database.query(query);
             system.debug('lstObject==> '+lstObject);
             return lstObject;
        }
}