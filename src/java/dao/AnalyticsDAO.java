/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Events;
import entity.EventsLog;
import entity.Orders;
import entity.OrdersLog;
import entity.Tasks;
import entity.TasksLog;
import entity.User;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Hashtable;
import java.util.List;
import java.util.Set;

/**
 *
 * @author HP
 */
public class AnalyticsDAO {

    //Return total number of events, tasks, orders
    public static int returnTotalNumOfTasks() {
        List<Tasks> listOfTasks = TasksDAO.retrieveTasks();
        if (listOfTasks != null) {
            return listOfTasks.size();
        } else {
            return 0;
        }
    }

    public static int returnTotalNumOfEvents() {
        List<Events> listOfEvents = EventsDAO.retrieveEvents();
        if (listOfEvents != null) {
            return listOfEvents.size();
        } else {
            return 0;
        }
    }

    public static int returnTotalNumOfOrders() {
        List<Orders> listOfOrders = OrdersDAO.retrieveOrders();
        if (listOfOrders != null) {
            return listOfOrders.size();
        } else {
            return 0;
        }
    }

    //Return number of priority events
    public static int returnNumOfPriorityEvents(String priorityLevel) {
        List<Events> listOfEvents = EventsDAO.filterEvents("eventPriority", priorityLevel);
        if (listOfEvents != null) {
            return listOfEvents.size();
        } else {
            return 0;
        }
    }

    //Return number of priority orders
    public static int returnNumOfPriorityOrders(String priorityLevel) {
        List<Orders> listOfOrders = OrdersDAO.filterOrders("priority", priorityLevel);
        if (listOfOrders != null) {
            return listOfOrders.size();
        } else {
            return 0;
        }
    }

    //Return number of priority tasks
    public static int returnNumOfPriorityTasks(String priorityLevel) {
        List<Tasks> listOfTasks = TasksDAO.filterTasks("priority", priorityLevel);
        if (listOfTasks != null) {
            return listOfTasks.size();
        } else {
            return 0;
        }
    }

    /**
     * *
     * Everything for orders, since they are the only one we are sure would be
     * good Completed=> progress status = 100% medium progress= 40% < progress
     * <100% poor progress <= 40% ***
     */
    //Return number of completed events
    public static int returnNumOfCompleteOrders() {
        List<Orders> listOfOrders = OrdersDAO.filterOrders("orderStatus", "100");
        if (listOfOrders != null) {
            return listOfOrders.size();
        } else {
            return 0;
        }
    }

    //Return number of medium progress events
    public static int returnNumOfMediumProgressOrders(String lb, String ub) {
        List<Orders> listOfOrders = OrdersDAO.filterOrdersBetween("orderStatus", lb, ub);
        if (listOfOrders != null) {
            return listOfOrders.size();
        } else {
            return 0;
        }
    }

    //Return number of poor progress events
    public static int returnNumOfPoorProgressOrders() {
        List<Orders> listOfOrders = OrdersDAO.filterOrdersBetween("orderStatus", "0", "49");
        if (listOfOrders != null) {
            return listOfOrders.size() - AnalyticsDAO.returnNumOfCompleteOrders(); //problem: "10" is also considered in "100"
        } else {
            return 0;
        }
    }

    /**
     * *
     *
     * Return the number of items within these two days *
     */
    public static int returnOrdersBetweenTheDates(Date date1, Date date2) {
        List<Orders> listOfOrders = OrdersDAO.filterOrdersBetweenDates(date1, date2);
        if (listOfOrders != null) {
            return listOfOrders.size(); //problem: "10" is also considered in "100"
        } else {
            return 0;
        }
    }

    /**
     * *
     * Return the tasks of each user *
     */
    public static Hashtable<String, List<Tasks>> returnTheTasksOfEachUser() {
        Hashtable<String, User> listOfUsers = LoginDAO.retrieveUsers();
        Hashtable<String, List<Tasks>> taskOfEachUser = new Hashtable<>();
        Set<String> keys = listOfUsers.keySet();
        for (String key : keys) {
            User theUser = listOfUsers.get(key);
            String email = theUser.getEmail();
            List<Tasks> taskList = TasksDAO.retrieveTasksOfUser(email);
            taskOfEachUser.put(email, taskList);
        }

        return taskOfEachUser;
    }

    public static List<String> returnLatestNotifications() {
        List<String> latestNotifications = new ArrayList<String>();

        EventsLogDAO eventsLogManager = new EventsLogDAO();
        List<EventsLog> listOfEventsLog = eventsLogManager.retrieveEventsLog();

        OrdersLogDAO ordersLogManager = new OrdersLogDAO();
        List<OrdersLog> listOfOrdersLog = ordersLogManager.retrieveOrdersLog();

        TasksLogDAO tasksLogManager = new TasksLogDAO();
        List<TasksLog> listOftasksLog = tasksLogManager.retrieveTasksLog();

        Collections.reverse(listOfOrdersLog);
        Collections.reverse(listOfEventsLog);
        Collections.reverse(listOftasksLog);

        int numEventslog = listOfEventsLog.size()-1;
        int numOrderslog = listOfOrdersLog.size()-1;
        int numTaskslog = listOfEventsLog.size()-1;

        if (listOfEventsLog.size() > 3) {
            numEventslog = Math.min(listOfEventsLog.size(), 3);
        }

        if (listOfOrdersLog.size() > 3) {
            numOrderslog = Math.min(listOfOrdersLog.size(), 3);
        }

        if (listOftasksLog.size() > 3) {
            numTaskslog = Math.min(listOftasksLog.size(), 3);
        }

        for (int i = 0; i <numEventslog; i++) {
            EventsLog eventlog = listOfEventsLog.get(i);
            String theMessage = eventlog.getEventName() + " was " + eventlog.getActionType() + "ed by " + eventlog.getUsername();
            latestNotifications.add(theMessage);
        }
        for (int i = 0; i <numOrderslog; i++) {
            OrdersLog orderlog = listOfOrdersLog.get(i);
            String theMessage = orderlog.getOrderNumber() + " was " + orderlog.getActionType() + "ed by " + orderlog.getUsername();
            latestNotifications.add(theMessage);
        }
        for (int i = 0; i <numTaskslog; i++) {
            TasksLog tasklog = listOftasksLog.get(i);
            String theMessage = "Task " + tasklog.getTaskID() + " was " + tasklog.getActionType() + "ed by " + tasklog.getUsername();
            latestNotifications.add(theMessage);
        }

        return latestNotifications;
    }
        
    public static List<List<Events>> returnNumberOfEventsXDaysFromNow(int numOfDays) {
        // Populating a list of the possible event
        ArrayList<Integer> possibleDays = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            possibleDays.add(k);
        }

        // Populating the NewEventList with empty lists of events from 1 to numOfDays
        List<List<Events>> newEventList = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            List<Events> initialEventList = new ArrayList<>();
            newEventList.add(initialEventList);
        }

        //Looking at all the events and keeping only specific ones.
        List<Events> EventList = EventsDAO.retrieveEvents();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Events event : EventList) {
            Date eventDate = event.getEventDate();
            int diffOfDays = (int) ((today.getTime() - eventDate.getTime()) / (1000 * 60 * 60 * 24));
            if (possibleDays.contains(diffOfDays) && !"100".equals(event.getEventProcessStatus())) {
                newEventList.get(numOfDays - diffOfDays).add(event);
            }
        }
        return newEventList;
    }

    public static List<List<Events>> returnNumberOfEventsDueXDays(int numOfDays) {
        // Populating a list of the possible events
        ArrayList<Integer> possibleDays = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            possibleDays.add(k);
        }

        // Populating the NewEventList with empty lists of events from 1 to numOfDays
        List<List<Events>> newEventList = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            List<Events> initialEventList = new ArrayList<>();
            newEventList.add(initialEventList);
        }

        //Looking at all the events and keeping only specific ones.
        List<Events> EventList = EventsDAO.retrieveEvents();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Events event : EventList) {
            Date eventDeadline = event.getEventDeadline();
            int diffOfDays = (int) ((eventDeadline.getTime() - today.getTime()) / (1000 * 60 * 60 * 24));
            if (possibleDays.contains(diffOfDays) && !"100".equals(event.getEventProcessStatus())) {
                newEventList.get(diffOfDays).add(event);
            }
        }
        return newEventList;
    }

    public static List<List<Orders>> returnNumberOfOrdersXDaysFromNow(int numOfDays) {
        // Populating a list of the possible orders
        ArrayList<Integer> possibleDays = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            possibleDays.add(k);
        }

        // Populating the NewOrderList with empty lists of orders from 1 to numOfDays
        List<List<Orders>> newOrderList = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            List<Orders> initialOrderList = new ArrayList<>();
            newOrderList.add(initialOrderList);
        }

        //Looking at all the orders and keeping only specific ones.
        List<Orders> OrderList = OrdersDAO.retrieveOrders();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Orders order : OrderList) {
            Date orderDate = order.getShippingDate();
            int diffOfDays = (int) ((today.getTime() - orderDate.getTime()) / (1000 * 60 * 60 * 24));
            if (possibleDays.contains(diffOfDays) && !"100".equals(order.getOrderStatus())) {
                newOrderList.get(numOfDays - diffOfDays).add(order);
            }
        }
        return newOrderList;
    }

    public static List<List<Orders>> returnNumberOfOrdersDueXDays(int numOfDays) {
        // Populating a list of the possible orders
        ArrayList<Integer> possibleDays = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            possibleDays.add(k);
        }

        // Populating the NewOrderList with empty lists of orders from 1 to numOfDays
        List<List<Orders>> newOrderList = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            List<Orders> initialOrderList = new ArrayList<>();
            newOrderList.add(initialOrderList);
        }

        //Looking at all the orders and keeping only specific ones.
        List<Orders> OrderList = OrdersDAO.retrieveOrders();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Orders order : OrderList) {
            Date orderDeadline = order.getShippingDate();
            int diffOfDays = (int) ((orderDeadline.getTime() - today.getTime()) / (1000 * 60 * 60 * 24));
            if (possibleDays.contains(diffOfDays) && !"100".equals(order.getOrderStatus())) {
                newOrderList.get(diffOfDays).add(order);
            }
        }
        return newOrderList;
    }

    public static List<List<Tasks>> returnNumberOfTasksXDaysFromNow(int numOfDays) {
        // Populating a list of the possible task
        ArrayList<Integer> possibleDays = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            possibleDays.add(k);
        }

        // Populating the NewTaskList with empty lists of tasks from 1 to numOfDays
        List<List<Tasks>> newTaskList = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            List<Tasks> initialTaskList = new ArrayList<>();
            newTaskList.add(initialTaskList);
        }

        //Looking at all the tasks and keeping only specific ones.
        List<Tasks> TaskList = TasksDAO.retrieveTasks();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Tasks task : TaskList) {
            Date taskDate = task.getTaskDate();
            int diffOfDays = (int) ((today.getTime() - taskDate.getTime()) / (1000 * 60 * 60 * 24));
            if (possibleDays.contains(diffOfDays) && !"100".equals(task.getTaskProcessStatus())) {
                newTaskList.get(numOfDays - diffOfDays).add(task);
            }
        }
        return newTaskList;
    }

    public static List<List<Tasks>> returnNumberOfTasksDueXDays(int numOfDays) {
        // Populating a list of the possible task
        ArrayList<Integer> possibleDays = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            possibleDays.add(k);
        }

        // Populating the NewTaskList with empty lists of tasks from 1 to numOfDays
        List<List<Tasks>> newTaskList = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            List<Tasks> initialTaskList = new ArrayList<>();
            newTaskList.add(initialTaskList);
        }

        //Looking at all the tasks and keeping only specific ones.
        List<Tasks> TaskList = TasksDAO.retrieveTasks();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Tasks task : TaskList) {
            Date taskDeadline = task.getTaskDeadline();
            int diffOfDays = (int) ((taskDeadline.getTime() - today.getTime()) / (1000 * 60 * 60 * 24));
            if (possibleDays.contains(diffOfDays) && !"100".equals(task.getTaskProcessStatus())) {
                newTaskList.get(diffOfDays).add(task);
            }
        }
        return newTaskList;
    }   
    
    
    public static List<Events> returnEventsOverdueMoreThan14Days() {
        List<Events> newEventList = new ArrayList<>();

        //Looking at all the events and keeping only specific ones.
        List<Events> EventList = EventsDAO.retrieveEvents();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Events event : EventList) {
            Date eventDate = event.getEventDeadline();
            int diffOfDays = (int) ((today.getTime() - eventDate.getTime()) / (1000 * 60 * 60 * 24));
            if (diffOfDays >= 14 && !"100".equals(event.getEventProcessStatus())) {
                newEventList.add(event);
            }
        }
        return newEventList;
    }

    public static List<Orders> returnOrdersOverdueMoreThan14Days() {
        List<Orders> newOrderList = new ArrayList<>();

        //Looking at all the orders and keeping only specific ones.
        List<Orders> OrderList = OrdersDAO.retrieveOrders();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Orders order : OrderList) {
            Date orderDate = order.getShippingDate();
            int diffOfDays = (int) ((today.getTime() - orderDate.getTime()) / (1000 * 60 * 60 * 24));
            if (diffOfDays >= 14 && !"100".equals(order.getOrderStatus())) {
                newOrderList.add(order);
            }
        }
        return newOrderList;
    }
    
    public static List<Tasks> returnTasksOverdueMoreThan14Days() {
        List<Tasks> newTaskList = new ArrayList<>();

        //Looking at all the tasks and keeping only specific ones.
        List<Tasks> TaskList = TasksDAO.retrieveTasks();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Tasks task : TaskList) {
            Date taskDate = task.getTaskDeadline();
            int diffOfDays = (int) ((today.getTime() - taskDate.getTime()) / (1000 * 60 * 60 * 24));
            if (diffOfDays >= 14 && !"100".equals(task.getTaskProcessStatus())) {
                newTaskList.add(task);
            }
        }
        return newTaskList;
    }
    
        public static List<Orders> returnAllOverDueOrders() {
        List<Orders> newOrderList = new ArrayList<>();
        List<Orders> OrderList = OrdersDAO.retrieveOrders();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Orders order : OrderList) {
            if (!"100".equals(order.getOrderStatus()) && today.after(order.getShippingDate())) {
                newOrderList.add(order);
            }
        }
        return newOrderList;
    }

    public static List<Tasks> returnAllOverDueTasks() {
        List<Tasks> newTaskList = new ArrayList<>();
        List<Tasks> TaskList = TasksDAO.retrieveTasks();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Tasks task : TaskList) {
            if (!"100".equals(task.getTaskProcessStatus()) && today.after(task.getTaskDeadline())) {
                newTaskList.add(task);
            }
        }
        return newTaskList;
    }
    
    public static List<Events> returnAllOverDueEvents() {
        List<Events> newEventList = new ArrayList<>();
        List<Events> EventList = EventsDAO.retrieveEvents();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Events event : EventList) {
            if (!"100".equals(event.getEventProcessStatus()) && today.after(event.getEventDeadline())) {
                newEventList.add(event);
            }
        }
        return newEventList;
    }
    
    public static List<List<Orders>> returnOrdersOverdueXDays(int numOfDays) {
        // Populating a list of the possible orders - here you use 14 days as a basis
        ArrayList<Integer> possibleDays = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            possibleDays.add(k);
        }

        // Populating the NewOrderList with empty lists of orders from 1 to numOfDays
        List<List<Orders>> newOrderList = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            List<Orders> initialOrderList = new ArrayList<>();
            newOrderList.add(initialOrderList);
        }

        //Looking at all the orders and keeping only specific ones.
        List<Orders> OrderList = OrdersDAO.retrieveOrders();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Orders order : OrderList) {
            Date orderDeadline = order.getShippingDate();
            int diffOfDays = (int) ((today.getTime() - orderDeadline.getTime()) / (1000 * 60 * 60 * 24));
            if (possibleDays.contains(diffOfDays) && !"100".equals(order.getOrderStatus())) {
                newOrderList.get(diffOfDays).add(order);
            }
        }
        return newOrderList;
    }
    
    public static List<List<Tasks>> returnTasksOverdueXDays(int numOfDays) {
        // Populating a list of the possible tasks - here you use 14 days as a basis
        ArrayList<Integer> possibleDays = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            possibleDays.add(k);
        }

        // Populating the NewTaskList with empty lists of tasks from 1 to numOfDays
        List<List<Tasks>> newTaskList = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            List<Tasks> initialTaskList = new ArrayList<>();
            newTaskList.add(initialTaskList);
        }

        //Looking at all the tasks and keeping only specific ones.
        List<Tasks> TaskList = TasksDAO.retrieveTasks();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Tasks task : TaskList) {
            Date taskDeadline = task.getTaskDeadline();
            int diffOfDays = (int) ((today.getTime() - taskDeadline.getTime()) / (1000 * 60 * 60 * 24));
            if (possibleDays.contains(diffOfDays) && !"100".equals(task.getTaskProcessStatus())) {
                newTaskList.get(diffOfDays).add(task);
            }
        }
        return newTaskList;
    }
    
    public static List<List<Events>> returnEventsOverdueXDays(int numOfDays) {
        // Populating a list of the possible events - here you use 14 days as a basis
        ArrayList<Integer> possibleDays = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            possibleDays.add(k);
        }

        // Populating the NewEventList with empty lists of events from 1 to numOfDays
        List<List<Events>> newEventList = new ArrayList<>();
        for (int k = 0; k <= numOfDays; k++) {
            List<Events> initialEventList = new ArrayList<>();
            newEventList.add(initialEventList);
        }

        //Looking at all the events and keeping only specific ones.
        List<Events> EventList = EventsDAO.retrieveEvents();
        Date today = new Date(Calendar.getInstance().getTime().getTime());
        for (Events event : EventList) {
            Date eventDeadline = event.getEventDeadline();
            int diffOfDays = (int) ((today.getTime() - eventDeadline.getTime()) / (1000 * 60 * 60 * 24));
            if (possibleDays.contains(diffOfDays) && !"100".equals(event.getEventProcessStatus())) {
                newEventList.get(diffOfDays).add(event);
            }
        }
        return newEventList;
    }
}
