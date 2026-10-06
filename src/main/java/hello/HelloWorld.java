package hello;

import org.joda.time.LocalTime;

public class HelloWorld {
    public static void main(String[] args) {
        LocalTime currentTime = new LocalTime();
        System.out.println("The current local time is: " + currentTime);

        Greeter greeter = new Greeter();
        System.out.println(greeter.sayHello());
    }

    /**
     * UNTESTED METHOD FOR SONARQUBE FAILURE DEMONSTRATION
     * Because no unit test calls this method, SonarQube will flag all these lines 
     * and branches in RED, dropping your overall project coverage.
     */
    //public static String determineTimeOfDay(int hour) {
        //if (hour < 0 || hour > 23) {
            //return "Invalid hour provided";
        //} else if (hour >= 5 && hour < 12) {
           // return "Morning";
        //} else if (hour >= 12 && hour < 17) {
            //return "Afternoon";
        //} else if (hour >= 17 && hour < 21) {
            //return "Evening";
        //} else {
            //return "Night";
        //}
    //}
}
