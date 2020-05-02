//
//  MainMapViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/05/02.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseFirestore

class MainMapViewController: UIViewController, CLLocationManagerDelegate {
    
    // 맵 키트 연결
    @IBOutlet weak var myMap: MKMapView!
    let locationManager = CLLocationManager()
    
    
    @IBOutlet weak var LocationInfo1: UILabel!
    @IBOutlet weak var LocationInfo2: UILabel!
    
    
    var db:Firestore!
    
    
    //  let latitude = 37.548947;  let longitude = 126.913521 // 합정
    //  let latitude = 37.497934;  let longitude = 127.027549 // 강남
    var send1=1.0
    var send2=1.0

    // 선택 장소 개수
    var selectPlaceCnt = 0
    
    @IBAction func userNow(_ sender: Any) {
        
        self.LocationInfo1.text = ""
        self.LocationInfo2.text = ""
        
        locationManager.startUpdatingLocation()
        
    }
    
    
    @IBAction func mapo(_ sender: Any) {
        placeLoad(select: "cafe_mapo")
    }
    

    
    
    @IBAction func gangnam(_ sender: Any) {
        placeLoad(select: "cafe_gangnam")
     
    }
    

    override func viewDidLoad() {

            super.viewDidLoad()

            //위치정보 레이블은 동백으로 둡니다.

            LocationInfo1.text = " "

            LocationInfo2.text = " "

            //상수 locationManager의 델리게이트를 self로 설정합니다.

            locationManager.delegate = self

            //정확도를 최고로 설정합니다.

            locationManager.desiredAccuracy = kCLLocationAccuracyBest

            //위치 데이터를 추적하기 위해 사용자에게 승인을 요구합니다.

            locationManager.requestWhenInUseAuthorization()

            //위치 업데이트를 시작합니다.

            locationManager.startUpdatingLocation()

            //위치보기 값을 true로 설정합니다.

            myMap.showsUserLocation = true
        
        
        
        

        }



        override func didReceiveMemoryWarning() {

            super.didReceiveMemoryWarning()

        }



    //    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue : CLLocationDegrees, delta span :Double) {

    //        //위도 값과 경도 값을 매개변수로 하여 CLLocationCoordinate2DMake 함수를 호출하고, 리턴값을 pLocation로 받습니다.

    //        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)

    //        //범위 값을 매개변수로 하여 MKCoordinateSpanMake함수를 호출하고, 리턴 값을 spanValue로 받습니다.

    //        let spanValue = MKCoordinateSpanMake(span, span)

    //        //pLocation와 spanValue를 매개변수로 하여 MKCoordinateRegionMake 함수를 호출하고, 리턴 값을 pRegion으로 받습니다.

    //        let pRegion = MKCoordinateRegionMake(pLocation, spanValue)

    //        //pRegion을 매개변수로하여 myMap.setRegion 함수를 호출합니다.

    //        myMap.setRegion(pRegion, animated: true)

    //    }

        func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue : CLLocationDegrees, delta span :Double)->CLLocationCoordinate2D {

            //위도 값과 경도 값을 매개변수로 하여 CLLocationCoordinate2DMake 함수를 호출하고, 리턴값을 pLocation로 받습니다.

            let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)

            //범위 값을 매개변수로 하여 MKCoordinateSpanMake함수를 호출하고, 리턴 값을 spanValue로 받습니다.

            let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)

            //pLocation와 spanValue를 매개변수로 하여 MKCoordinateRegionMake 함수를 호출하고, 리턴 값을 pRegion으로 받습니다.

            let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)

            //pRegion을 매개변수로하여 myMap.setRegion 함수를 호출합니다.

            myMap.setRegion(pRegion, animated: true)

            return pLocation

        }

        

        func setAnnotation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span : Double, title strTitle: String, subtitle strSubtitle:String) {

            //핀을 설치하기 위해 MKPointAnnotation 함수를 호출하여 리턴 값을 annotation으로 받습니다.

            let annotation = MKPointAnnotation()

            //annotation의 coordinate 값을 goLocation함수로부터 CLLocationCoordinate2DMake형태로 받아야 하는데, 이를 위해서는 goLocation 함수를 수정해야 합니다.

            annotation.coordinate = goLocation(latitude: latitudeValue, longitude: longitudeValue, delta: span)

            annotation.title = strTitle

            annotation.subtitle = strSubtitle

            myMap.addAnnotation(annotation)
            

        }

        

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

            //위치가 업데이트되면 먼저 마지막 위치 값을 찿아냅니다.

            let pLocation = locations.last

            //마지막 위치의 위도와 경도 값을 가지고 앞에서 만든 goLocation함수를 호출 합니다.이때 delta를 0.01로 하였으니 1의 값보다 지도를 100배로 확대해서 보여 줄 것입니다.

            goLocation(latitude: (pLocation?.coordinate.latitude)!, longitude: (pLocation?.coordinate.longitude)!, delta: 0.01)

            

            CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {

                (placemarks, error) -> Void in

                //placemarks 값의 첫 부분만 pm 상수로 대입합니다.

                let pm = placemarks!.first

                //pm 상수에서 나라 값을 country 상수에 대입합니다.

                let country = pm!.country

                //문자열 address에 country 상수의 값을 대입합니다.

                var address:String = country!

                //pm 상수에서 지역 값이 존재하면 address 문자열에 추가합니다.

                if pm!.locality != nil {

                    address += " "

                    address += pm!.locality!

                }

                if pm!.thoroughfare != nil {

                    address += " "

                    address += pm!.thoroughfare!

                }

                //레이블에 "현재위치" 텍스트를 표시합니다.

                self.LocationInfo1.text = "현재위치"

                //레이블에 address문자열의 값을 표시합니다.

                self.LocationInfo2.text = address

            })

            //마지막으로 위치가 업데이트되는 것을 멈추게 합니다.

            locationManager.stopUpdatingLocation()

        }
    
    func placeLoad(select:String){
        db = Firestore.firestore()
                
                db.collection(select).getDocuments(){ (querySnapshot, err) in
                           if let err = err {
                           print("Error getting documents: \(err)")
                           } else {
                               
                            let cnt = querySnapshot!.documents.count
                            print("카페 개수 :::: \(cnt)")
                            self.selectPlaceCnt = cnt
                           
                            for document in querySnapshot!.documents {
                                
                                let info = document.data()
                                 print("카페 정보 :::: \(info)")
                                
                                guard let name = info["name"] else {return}
                                guard let loc1 = info["loc1"] else {return}
                                 guard let loc2 = info["loc2"] else {return}
                                 guard let which = info["which"] else {return}
                                
                                print(name)
                                print(loc1)
                                print(loc2)
                                print(which)
                                print("----------------")
                                
                                let tempName = "\(name)"
                                let tempWhich = "\(which)"
                                var tempLoc1 = 1.0
                                var tempLoc2 = 1.0
                                
                                tempLoc1 = loc1 as! Double
                                tempLoc2 = loc2 as! Double
                                
                                
                                self.setAnnotation(latitude: tempLoc1, longitude: tempLoc2, delta: 0.01, title: tempName, subtitle: tempWhich)
                                
                                
                            }
                                }
                           }
                
                /* setAnnotation 추가로 핀 여러개 추가 마지막 부분이 중심부 */
        //        setAnnotation(latitude: 37.548571, longitude: 126.913822, delta: 0.01, title: "대학교", subtitle: "서울특별시 관악구 관악로 1")
        //         setAnnotation(latitude: 37.551727, longitude: 126.904438, delta: 0.01, title: "장수램프", subtitle: "서울특별시 관악구 관악로 1")
        //        setAnnotation(latitude: send1, longitude: send2, delta: 0.01, title: "서울대학교", subtitle: "서울특별시 관악구 관악로 1")
                              self.LocationInfo1.text = "보고 계신 위치"

                              self.LocationInfo2.text = "\(selectPlaceCnt) 곳"
        
    }

      

        

    }
