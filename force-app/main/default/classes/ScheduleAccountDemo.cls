public class ScheduleAccountDemo implements Schedulable{
     public void execute(SchedulableContext sc){
         ConsumerAccountMonthly con =  new ConsumerAccountMonthly();
        database.executeBatch(con);
    }

}