public with sharing class OrderCreationTriggerHandler {
    public static void afterInsert(List<Order__c> orders) {
        Decimal amount = 0;
            Decimal discount=0;
            Decimal delivery = 0;

       List<Contact> conList = new List<Contact>();
       List<Order__c> ordersToUpdate = new List<Order__c>();
        List<Order__c> orderList=[SELECT Id,EDT__c,Items__c,Dishes__c, CreatedDate,Distance__c,Customer__c,Customer__r.Type__c,Customer__r.CostEarned__c, Customer__r.Number_of_Orders__c,Delivery_Patner__r.CostEarned__c,Delivery_Charges__c,Total_Amount__c FROM Order__c WHERE Id IN :orders];
        
       for(Order__c order:orderList){
         List<String> dishes =order.Dishes__c.split(';');
         
           if(order.Customer__r.Type__c=='Prime'){
                    delivery=0;
                    discount=0.12;
               
                   }
                  else if (order.Distance__c>15 && order.Distance__c<25){
                    delivery=40;
                  
                   }
                  else if(order.Distance__c<15){
                           delivery=80;
                  }
                       
                           amount=order.Total_Amount__c;
                           if(discount>0){
                            amount=amount-(amount*discount);
                           }
                     
                           Contact con =[SELECT Id,LastModifiedDate,CreatedDate, Name,Earned_Points__c,Number_of_Orders__c FROM Contact WHERE Id=:order.Customer__c];
                           System.debug('con'+con);
                           if(con.Number_of_Orders__c==null){
                               con.Number_of_Orders__c=0;
                           }
                             con.Earned_Points__c=(amount/2)+(con.Number_of_Orders__c/2);
                            System.debug('ConAfterUpdate'+con.Earned_Points__c);
                            Contact dp = [Select CostEarned__c , Name FROM Contact WHERE Id = :order.Delivery_Patner__c];
                            System.debug('dp'+dp);
                            if(dp.CostEarned__c==null){
                                dp.CostEarned__c=0;
                            }
                            System.debug(amount);
                            dp.CostEarned__c=(2/3)*(amount+80);
                           
                             dp.CostEarned__c=2*(amount+80)/3;
                           
                            Integer timeValue = 0;
                            List<Menu__c> menuList=[SELECT Id,Name,Prices__c,Preparation_Time__c FROM Menu__c WHERE Dishes__c IN :dishes];
                            for(Menu__c men : menuList){
                                    timeValue+=Integer.valueOf(men.Preparation_Time__c);
                            }
                            System.debug('timeValue before '+timeValue);
                            System.debug('dpAfterUpdate'+dp.CostEarned__c);
                            Time createdTime = order.CreatedDate.Time();
                            System.debug('createdTime'+createdTime);
                            timeValue=Integer.valueOf(timeValue+order.Distance__c);
                            System.debug('timeValue'+timeValue);
                            Time actualTime = createdTime.addMinutes(timeValue);


                            


                           order.EDT__c=actualTime;
                            order.Delivery_Charges__c=delivery;
                            order.Total_Amount__c=amount+delivery;
                            ordersToUpdate.add(order);
                            conList.add(con);
                            conList.add(dp);
           
       }
        update conList;
        update ordersToUpdate;
        System.debug('ordersToUpdate'+ordersToUpdate);
        System.debug('conList'+conList);
    }
    public static void afterInsertUpdate(List<Order__c> orders){
        Set<id> ids = new Set<id>();
        for(Order__c order : orders){
            ids.add(order.Customer__c);
        }
        List<contact> conList = new List<contact>();
        List<Contact> tobeUpdated = new List<Contact>();
        conList=[SELECT id,Number_of_Orders__c,(select id from orders__r)from Contact where id in :ids];
        for(Contact con : conList){
            con.Number_of_Orders__c=con.orders__r.size();
            tobeUpdated.add(con);
        }
        update tobeUpdated;

    }
    
       
    }
    

