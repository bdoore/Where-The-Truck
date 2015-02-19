//
//  DataSource.swift
//  Where The Truck
//
//  Created by Brian Doore on 1/13/15.
//  Copyright (c) 2015 Brian Doore. All rights reserved.
//

import UIKit


class DataSource: NSObject {
    
//    var query : PFQuery!
    
    class var sharedInstance: DataSource {
        
    struct Static {
        static var instance: DataSource?
        static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            //            NSLog("Groups Data source Initializing!!")
            Static.instance = DataSource()
        }
        
        return Static.instance!
    }
    
    var truckArray : [FoodTruck] = []
    var serverURL : String = ""
   
    
    func getTruckData(){
        
        var query : PFQuery = PFUser.query()
        query.whereKey("isActive", equalTo: true)
//        query = PFQuery(className: "foodTruck")
        
        query.findObjectsInBackgroundWithBlock { (objects : [AnyObject]!, error : NSError!) -> Void in
            
            if (error == nil){
                println(objects.description)
                self.truckArray = FoodTruck.initTrucks(objects as [PFObject])
                
                NSNotificationCenter.defaultCenter().postNotificationName("truckDataReceived", object: nil)
            }
            else{
                println("\(error.localizedDescription)")
            }
            
        }
        
//        println(query.valueForKey(truckName))
        
        
        

        
    }
    
}
