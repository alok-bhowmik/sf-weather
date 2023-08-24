public class ScheduleContactMonthly {
    
     public void execute(SchedulableContext sc){
         ScheduleContacts scheduleCon =  new ScheduleContacts();
        database.executeBatch(scheduleCon);
     }

}