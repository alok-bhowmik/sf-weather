public class scheduleclass implements Schedulable {
    
     public void execute(SchedulableContext sc){
         Demo con =  new Demo();
        database.executeBatch(con);
     }


}