//
//  MapViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/30.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit
import GoogleMaps
class MapViewController: UIViewController {



            
            // You don't need to modify the default init(nibName:bundle:) method.
            override func viewDidLoad() {
                super.viewDidLoad()
            }
            override func loadView() {
                // Create a GMSCameraPosition that tells the map to display the
                // coordinate -33.86,151.20 at zoom level 6.
                let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
                let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //        mapView.isMyLocationEnabled = true
                view = mapView
                
                // Creates a marker in the center of the map.
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
                marker.title = "Sydney"
                marker.snippet = "Australia"
                marker.map = mapView
            }
}
    

