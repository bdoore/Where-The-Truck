//
//  SecondViewController.swift
//  Where The Truck
//
//  Created by Brian Doore on 1/13/15.
//  Copyright (c) 2015 Brian Doore. All rights reserved.
//

import UIKit

class TruckListViewController: UITableViewController {
    
    var userLocation : CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        
        DataSource.sharedInstance.getTruckData()
        LocationService.sharedInstance.locationManager.startUpdatingLocation()
        
//        if(LocationService.sharedInstance.currentLocation != nil) {
//            
//            userLocation = LocationService.sharedInstance.currentLocation
//
//        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("truckDataReceived"), name: "truckDataReceived", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("userLocationRecieved"), name: "userLocationRecieved", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("truckDataReceived"), name: "pictureUpdated", object: nil)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func truckDataReceived(){
        
        self.tableView.reloadData()
        
    }
    
    func userLocationRecieved() {
        
        userLocation = LocationService.sharedInstance.locationManager.location
        self.tableView.reloadData()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if( segue.identifier == "listToDetail") {
            
            if(sender != nil) {
                
                var truck : FoodTruck = sender as FoodTruck
                var detailVC : DetailViewController = segue.destinationViewController as DetailViewController
                detailVC.truck = truck
                detailVC.distanceFromUser = self.getDistance(truck.position.distanceFromLocation(userLocation))

            
            }
            
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var  cell = tableView.dequeueReusableCellWithIdentifier("truck", forIndexPath: indexPath) as UITableViewCell
        
        var truckImageView : UIImageView = cell.viewWithTag(1) as UIImageView
        var truckNameLabel : UILabel = cell.viewWithTag(2) as UILabel
        var truckDistanceLabel : UILabel = cell.viewWithTag(3) as UILabel
        var truckDescriptionLabel : UILabel = cell.viewWithTag(4) as UILabel
        
        var truck : FoodTruck = DataSource.sharedInstance.truckArray[indexPath.row]
        
        truckNameLabel.text = truck.name
        truckDescriptionLabel.text = truck.truckDescription
        truckDistanceLabel.text = self.getDistance(truck.position.distanceFromLocation(userLocation))
        truckImageView.image = truck.picture
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var truck : FoodTruck = DataSource.sharedInstance.truckArray[indexPath.row]
        
        println("this is truck: \(truck.name)")
        
        performSegueWithIdentifier("listToDetail", sender: truck)
        
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataSource.sharedInstance.truckArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
        if(keyPath == "currentLocation") {
            
            userLocation = LocationService.sharedInstance.currentLocation
            println("Location Got Yo!")

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

