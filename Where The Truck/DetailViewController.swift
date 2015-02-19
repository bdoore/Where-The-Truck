//
//  DetailViewController.swift
//  Where The Truck
//
//  Created by Brian Doore on 2/10/15.
//  Copyright (c) 2015 Brian Doore. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    var truck : FoodTruck!
    
    var distanceFromUser : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(truck != nil) {
            
            imageView.image = truck.picture
            nameLabel.text = truck.name
            descriptionLabel.text = truck.truckDescription
            distanceLabel.text = distanceFromUser
            mapView.showsUserLocation = true

            
            var viewRegion = MKCoordinateRegionMakeWithDistance(truck.position.coordinate, 750.0, 750.0)
            self.mapView.setRegion(viewRegion, animated: true)
            mapView.addAnnotation(truck.annotation)
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func navigatePressed(sender: AnyObject) {
        
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string: "comgooglemaps://")!)){
            
            var url : String = "comgooglemaps-x-callback://?center=\(truck.position.coordinate.latitude),\(truck.position.coordinate.longitude)&x-success=sourceapp://?resume=true&x-source=kickitGroup"
            var nsurl : NSURL = NSURL(string: url)!
            var opened : Bool = UIApplication.sharedApplication().openURL(nsurl)
            
        }
        else{
            
            var lat : CLLocationDegrees = CLLocationDegrees(truck.position.coordinate.latitude)
            var long : CLLocationDegrees = CLLocationDegrees(truck.position.coordinate.longitude)
            var coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            var placeMark : MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
            
            var destination : MKMapItem = MKMapItem(placemark: placeMark)
            destination.name = truck.name
            
            if (destination.respondsToSelector(Selector("openInMapsWithLaunchOptions:"))){
                destination.openInMapsWithLaunchOptions(nil)
            }
            
        }
        
        

        
        
    }


    @IBAction func backPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
