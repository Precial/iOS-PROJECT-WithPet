//
//  MapSelectViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/05/02.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit
import GoogleMaps
class MapSelectViewController: UIViewController, CLLocationManagerDelegate {
    
    var loc1=1.0
    var loc2=2.0
    

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
        
        
// 현재 위치
        let latitude = loc1; let longitude = loc2 // 현재 위치
        
     //   let latitude = 37.548947;  let longitude = 126.913521 // 합정
    //  let latitude = 37.497934;  let longitude = 127.027549 // 강남
        
        
        //지도 위치 설정
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 14.0)
        
        
        
        mapView.camera = camera
        
        // 핀 설정
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
