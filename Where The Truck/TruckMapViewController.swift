//
//  FirstViewController.swift
//  Where The Truck
//
//  Created by Brian Doore on 1/13/15.
//  Copyright (c) 2015 Brian Doore. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TruckMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var trucksArray : [FoodTruck]!
    
    var hasZoomed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        DataSource.sharedInstance.getTruckData()
        LocationService.sharedInstance.locationManager.startUpdatingLocation()
        
        map.showsUserLocation = true
        map.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("truckDataReceived"), name: "truckDataReceived", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("userLocationRecieved"), name: "userLocationRecieved", object: nil)

        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)

    }
    

    
    func truckDataReceived(){
        
        trucksArray = DataSource.sharedInstance.truckArray
        
        populateMapWithTrucks(trucksArray)
        
    }
    
    func userLocationRecieved() {
        
        var zoomLocation : CLLocationCoordinate2D
        zoomLocation = LocationService.sharedInstance.locationManager.location.coordinate
        
        if !(hasZoomed) {
            
            var viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 4000.0, 4000.0)
            
            self.map.setRegion(viewRegion, animated: true)
            
            hasZoomed = true
            
        }
        
        println("update hit on map")
        
    }
    

    
    func populateMapWithTrucks(truckArray : [FoodTruck]) {
        
        for truck : FoodTruck in truckArray {
            
            map.addAnnotation(truck.annotation)
            
        }
        
        
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if(annotation.isKindOfClass(MKUserLocation)) {
            return nil
            }
        
        var annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "CustomAnnotation")
        
        annotationView.canShowCallout = true
        annotationView.image = UIImage(named: "truck.png")
        
        annotationView.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIView
        
        return annotationView
        
        }
    
//    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
//        placeButtonTapped(view.annotation)
//    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
        
//        view.annotation.
        
        var truckArray = DataSource.sharedInstance.truckArray
        
        for truck : FoodTruck in truckArray {
            
            if(view.annotation.isEqual(truck.annotation)){
                self.performSegueWithIdentifier("mapToDetail", sender: truck)
            }
            
        }

        
        
        
        
//        placeButtonTapped(view.annotation)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if( segue.identifier == "mapToDetail") {
            
            if(sender != nil) {
                
                var truck : FoodTruck = sender as FoodTruck
                var detailVC : DetailViewController = segue.destinationViewController as DetailViewController
                detailVC.truck = truck
                detailVC.distanceFromUser = self.getDistance(truck.position.distanceFromLocation(LocationService.sharedInstance.currentLocation))
                
                
            }
            
        }
    }
    
    func getDistance(distance: CLLocationDistance) -> String {
        
        var distanceString: String = ""
        let distanceDouble: Double = distance as Double
        var milesDouble : Double = distanceDouble/1609.344
        
        distanceString = String(format:"%.1f Mi", milesDouble)
        
        println(String(format:"%f Mi", distanceDouble))
        
        return distanceString
        
    }


    
}

//func placeButtonTapped(annotation : MKAnnotation){
//    
//    if (UIApplication.sharedApplication().canOpenURL(NSURL(string: "comgooglemaps://")!)){
//        
//        var url : String = "comgooglemaps-x-callback://?center=\(annotation.coordinate.latitude),\(annotation.coordinate.longitude)&x-success=sourceapp://?resume=true&x-source=kickitGroup"
//        //            var url : String = "comgooglemaps-x-callback://?center=\(self.event!.latitude!),\(self.event!.longitude!)&x-success=sourceapp://?resume=true&x-source=kickitGroup"
//        var nsurl : NSURL = NSURL(string: url)!
//        var opened : Bool = UIApplication.sharedApplication().openURL(nsurl)
//        
//    }
//    else{
//        
//        var lat : CLLocationDegrees = CLLocationDegrees(annotation.coordinate.latitude)
//        var long : CLLocationDegrees = CLLocationDegrees(annotation.coordinate.longitude)
//        var coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
//        
//        var placeMark : MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
//        
//        var destination : MKMapItem = MKMapItem(placemark: placeMark)
//        destination.name = annotation.title
//        
//        if (destination.respondsToSelector(Selector("openInMapsWithLaunchOptions:"))){
//            destination.openInMapsWithLaunchOptions(nil)
//        }
//        
//    }
//    
//    
//}









//    func displayRegionCenteredOnMapItem(from: MKMapItem) {
//
//        var fromLocation: CLLocation = from.placemark.location
//        
//    }



