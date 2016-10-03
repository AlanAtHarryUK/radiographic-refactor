//
//  ViewController.swift
//  Where Am I
//
//  Created by dev on 13/01/2016.
//  Copyright © 2016 harryltd. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBookUI

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var collectData: Bool = true
    
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var longitude: UILabel!
    
    @IBOutlet weak var course: UILabel!
    
    @IBOutlet weak var speed: UILabel!
    
    @IBOutlet weak var altitude: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    //@IBAction func getLocation(sender: AnyObject) {
    //
    //}
    
    @IBAction func stopCollection(sender: AnyObject) {
        
        // 
        // set collecting flag to false to stop location data collection
        // set to true to collect data and restart collection
        if (collectData) {
            
            collectData = false
            
        } else {
            collectData = true

            self.locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var fAddr: String = ""
        
        //print(locations)
        
        let curLocation:CLLocation = locations[0]
        
        self.latitude.text = String(curLocation.coordinate.latitude)
        
        self.longitude.text = String(curLocation.coordinate.longitude)
        
        self.course.text = String(curLocation.course)
        
        self.speed.text = String(curLocation.speed)
        
        self.altitude.text = String(curLocation.altitude)
        
        CLGeocoder().reverseGeocodeLocation(curLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                print(error)
                
            } else {
                
                if let p = placemarks?[0] {
                    
                    fAddr = ABCreateStringWithAddressDictionary(p.addressDictionary!, true)
                                        
                    self.address.text = fAddr
                    
                    if (self.collectData == false) {

                        self.locationManager.stopUpdatingLocation()     // stop collector if requested
                    }
                    
                }
                
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

