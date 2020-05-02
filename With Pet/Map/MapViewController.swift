//
//  MapViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/30.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit
import GoogleMaps
class MapViewController:UIViewController, CLLocationManagerDelegate {
    
    var mapView: GMSMapView!
    var myMarker = GMSMarker()
    let locationManager = CLLocationManager()
    
    override func loadView() {
        mapView = GMSMapView()
        view = mapView
    }
 
    
     override func viewDidLoad() {
        
       super.viewDidLoad()
               
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
               locationManager.delegate = self
               
               // 사용할때만 위치정보를 사용한다는 팝업이 발생
               locationManager.requestWhenInUseAuthorization()
               
               // 항상 위치정보를 사용한다는 판업이 발생
               locationManager.requestAlwaysAuthorization()
               
               locationManager.startUpdatingLocation()
               
               move(at: locationManager.location?.coordinate)
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        // 사용할때만 위치정보를 사용한다는 팝업이 발생
        locationManager.requestWhenInUseAuthorization()
        
        // 항상 위치정보를 사용한다는 판업이 발생
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
        
        move(at: locationManager.location?.coordinate)
    }

 

    func move(at coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else {
            return
        }
        
        print("move = \(coordinate)")
        
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 14.0)
        mapView.camera = camera
        
        myMarker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        myMarker.title = "My Position"
        myMarker.snippet = "Known"
        myMarker.map = mapView
    }

 

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else {
            return
        }
        
        move(at: firstLocation.coordinate)
    }
}
