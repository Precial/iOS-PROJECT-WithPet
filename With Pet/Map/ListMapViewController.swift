//
//  ListMapViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/05/04.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import MapKit


class ListMapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    let nameList = ["펫고펫", "오늘의 펫", "도그앤캣","펫스타그램","펫킷"]
    let adressList = ["서울시 강남구","서울시 서초구", "서울시 관악구","서울시 마포구","서울시 구로구"]
 
    var nameIn : [String] = []
    var adressIn : [String] = []
    var imgNameIn : [String] = []
    
    
    var name: String?
    var adress: String?
    var imgName: String?
    var detailRespone: String?
    
    
    // 맵 키트 연결
    @IBOutlet weak var myMap: MKMapView!
    let locationManager = CLLocationManager()
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터 줄꺼에요
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? CafeDetailViewController
            if let index = sender as? Int {

                vc?.name = nameIn[index]
                vc?.adress = adressIn[index]
                vc?.imgName = imgNameIn[index]
                vc?.detailRespone = respone
                }
        }
    }
    
    
    
    
    
    
    var db:Firestore!
    
    var respone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("-----넘어옴------")
        print(nameIn)
        print(adressIn)
        
        print(respone)
        cafeLoad(input: respone)
        
        
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
    

 
    func cafeLoad(input:String){
        db = Firestore.firestore()
    
        print("======***********==============")
        
        db.collection(input).getDocuments(){ (querySnapshot, err) in
                                  if let err = err {
                                  print("Error getting documents: \(err)")
                                  } else {
                                      
                                   let cnt = querySnapshot!.documents.count
                                   print("카페 개수 :::: \(cnt)")
                                 
                                  
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
                                    
                                    
                                    
                                       
                                //    self.nameIn.append("\(name)")
                                //    self.adressIn.append("\(which)")
                                       
                                       
                                   }
                              //      print("*********\(self.nameIn)")
                               //     print("*********\(self.adressIn)")
                                    
                                       }
                                  }

    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameIn.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
            
        }
        
        
        
                /* 이미지 불러와서 매핑 후 배열에 저장 */
        print("!!!!!! 테스트 값은 \(self.imgNameIn[indexPath.row])")
                // Create a reference to the file you want to download
        let islandRef = Storage.storage().reference().child("Cafe_Image").child(respone).child("\(imgNameIn[indexPath.row]).jpg")
        
        
              
        
                // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                islandRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
                if let error = error {
                // Uh-oh, an error occurred!
                print("error")
                } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
        
        
                    cell.imgView.image = image
                    }
                }
        
    
       // let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
        //cell.imageView.image = img
        cell.nameLabel.text = nameIn[indexPath.row]
        cell.adressLabel.text = adressIn[indexPath.row]
        return cell
     }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("--> \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    
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
        })

        //마지막으로 위치가 업데이트되는 것을 멈추게 합니다.

        locationManager.stopUpdatingLocation()

    }
    
    

}


class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
     
     
     
     
 }
