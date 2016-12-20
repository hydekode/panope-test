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
    var myMarkers: [CLLocationCoordinate2D] = []
    
    var gMap: GMSMapView?
    
    var currentPoint: CLLocationCoordinate2D?
    var lastPoint: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Location Manager
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
       var timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(setMarker), userInfo: nil, repeats: true)

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
        lastPoint=myLocations[0].coordinate
        
        if let location11 = locations.first {
            //print("Found User's location: \(location11)")
            //print("Latitude: \(location11.coordinate.latitude) Longitude: \(location11.coordinate.longitude)")
            latitude = location11.coordinate.latitude
            longitude = location11.coordinate.longitude
        }
    }
    
    func setMarker()
    {
        currentPoint=myLocations.last?.coordinate
        NSLog("Create Marker")
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = currentPoint!
        marker.title = "position"
        marker.snippet = "boop"
        marker.map = gMap
        
        //print("APPENDING :", currentPoint!)
        myMarkers.append(currentPoint!)
        
        if(myMarkers.count>1){
            drawRouteLine()
        }
    }
    
    func drawRouteLine()
    {
        NSLog("Drawing Line")
        let path = GMSMutablePath()
        
        //print(myMarkers.last)
        //print(myMarkers[myMarkers.count-1])
        
        path.addCoordinate(myMarkers.last!)
        path.addCoordinate(myMarkers[myMarkers.count-2])
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth=5.0
        polyline.geodesic=true
        polyline.map=gMap
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}