//
//  FoodTruck.swift
//  Where The Truck
//
//  Created by Brian Doore on 1/20/15.
//  Copyright (c) 2015 Brian Doore. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotation : MKPointAnnotation {
    
    var truckID : String?
    
    override func isEqual(object: AnyObject?) -> Bool {
        
        if (object != nil && object!.isKindOfClass(MyAnnotation.classForCoder()) && self.truckID != nil){
            var objectIsAnnotation : MyAnnotation = object! as MyAnnotation
            if(self.truckID == objectIsAnnotation.truckID) {
                return true
            }
        }
        
        return false
    }
}



class FoodTruck: NSObject {
    
    var objectID : String
    var name : String
    var truckDescription : String
    var position : CLLocation
    var picture : UIImage?
    var annotation : MyAnnotation
    
    
    init(truckDictionary : PFObject) {
        
//        super.init()
        self.objectID = truckDictionary.objectId
        self.name = truckDictionary["name"] as String
        self.truckDescription = truckDictionary["sub_title"] as String
        var geoPoint : PFGeoPoint = truckDictionary["position"] as PFGeoPoint
        self.position = CLLocation(latitude: geoPoint.latitude as CLLocationDegrees, longitude: geoPoint.longitude as CLLocationDegrees)
        self.annotation = MyAnnotation()
        annotation.coordinate = self.position.coordinate
        annotation.title = self.name
        annotation.subtitle = self.truckDescription
        annotation.truckID = truckDictionary.objectId

    
    }
    
    class func initTrucks(truckArray : [PFObject]) -> [FoodTruck]{
        
        var trucks : [FoodTruck] = []
        
        for truck : PFObject in truckArray{
            var newTruck : FoodTruck = FoodTruck(truckDictionary: truck)
            
            let userImage = truck["picture"] as PFFile
            userImage.getDataInBackgroundWithBlock{ (imageData: NSData!, error : NSError!) -> Void in
                if (error == nil) {
                    println("there is no error")
                    newTruck.picture = UIImage(data: imageData)!
                    NSNotificationCenter.defaultCenter().postNotificationName("pictureUpdated", object: nil)
                }
                else{
                    println(error.localizedDescription)
                }
            }
            
            trucks.append(newTruck)
        }
        
        return trucks
        
    }

}
