//
//  ViewController.swift
//  panope
//
//  Created by Julia Syi on 12/18/16.
//  Copyright © 2016 ksyi. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, NSURLConnectionDelegate {
        
    let locationManager = CLLocationManager()
    var latitude = 0.00;
    var longitude = 0.00;
    
    var myLocations: [CLLocation] = []
    
    var gMap: GMSMapView?
    
    func sayHello()
    {
        NSLog("Create Marker")
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
         marker.position = (myLocations.last?.coordinate)!
         marker.title = "position"
         marker.snippet = "boop"
         marker.map = gMap
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Setup Location Manager
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
       var timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(sayHello), userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        var userPosition=CLLocationCoordinate2DMake(latitude, longitude)
        
        let camera = GMSCameraPosition.cameraWithTarget(userPosition, zoom: 3.0)
        //let mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
        gMap=GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
        gMap!.myLocationEnabled = true
        gMap!.settings.myLocationButton=true
        view = gMap
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        myLocations.append(locations[0] as CLLocation)
        
        if let location11 = locations.first {
            //print("Found User's location: \(location11)")
            //print("Latitude: \(location11.coordinate.latitude) Longitude: \(location11.coordinate.longitude)")
            latitude = location11.coordinate.latitude
            longitude = location11.coordinate.longitude
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}