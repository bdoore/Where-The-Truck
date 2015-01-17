//
//  DataSource.swift
//  Where The Truck
//
//  Created by Brian Doore on 1/13/15.
//  Copyright (c) 2015 Brian Doore. All rights reserved.
//

import UIKit
//import Alamofire
import Alamofire

class DataSource: NSObject {
    
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
    
    var serverURL : String = ""
   
    
    func getTruckData(){
        
        
        
//        let manager = AFHTTPRequestOperationManager()
//        
//        var params : [String : AnyObject] = ["group_id" : DataSource.sharedInstance.selectedGroup!.groupID, "group_members" : arrayToSend, "auth_token" : authToken()!, "user_id" : userID()!]
//        
//        manager.requestSerializer = AFJSONRequestSerializer() as AFJSONRequestSerializer
//        manager.POST(serverURL+"groups/add_members.json",
//            parameters: params,
//            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
////                self.navigationItem.rightBarButtonItem?.enabled = true
////                self.activityIndicator.stopAnimating()
//                
//                println("JSON: " + responseObject.description)
//                if (responseObject.isKindOfClass(NSDictionary)){
//                    var obj : NSDictionary = responseObject as NSDictionary
//                    var created : Bool = obj.objectForKey("group_created") as Bool
//                    if (created){
//                        
////                        GroupsDataSource.sharedInstance.parseDataFromStateDictionary(obj.objectForKey("state") as NSDictionary)
//
//                        
//                    }
//                }else if(responseObject.isKindOfClass(NSArray)){
//                    
//                }
//            },
//            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
//                
//                
//                println("Error: " + error.localizedDescription)
//        })
        
    }
    
}
