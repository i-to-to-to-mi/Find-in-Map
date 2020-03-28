//
//  ViewController.swift
//  MyMap
//
//  Created by itsumi on 2019/12/16.
//  Copyright © 2019 i-to-to. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController ,UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //TextFieldのdelegate通知先をさ設定
        inputText.delegate = self
        
    }


    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var disMap: MKMapView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        close_keybord(1)
        textField.resignFirstResponder()
        
//        入力された文字を取り出す(2)
        if let searchKey = textField.text{
//            入力された文字をデバッグエリアに表示(3)
            print(searchKey)
//            CLGecocoderインスタンスを取得(5)
            let geocoder = CLGeocoder()

//            入力された文字から位置情報を取得(6)
            geocoder.geocodeAddressString(searchKey ,  completionHandler: { (placemarks,error) in
                
//          位置情報が存在する場合は、unwrapPlacemarksに取り出す(7)
                if let unwrapPlacemarks = placemarks {
                    
//                    1件めの情報を取り出す(8)
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
//                       位置情報を取り出す(9)
                        if let location = firstPlacemark.location {

//                            位置情報からけ緯度経度をtargetCoordinateに取り出す(10)
                            let targetCoordinate = location.coordinate

//                            緯度経度をデバッグエリアに表示(11)
                            print(targetCoordinate)
                            
//                            MKPointAnnotationインスタンスを取得し、ピンを生成(12)
                            let pin = MKPointAnnotation()
                            
//                            ピンの置く位置に緯度経度を設定(13)
                            pin.coordinate = targetCoordinate
                            
//                            ピンのタイトルを設定(14)
                            pin.title = searchKey
                            
//                            ピンを地図に置く(15)
                            self.disMap.addAnnotation(pin)
                            
//                            緯度経度を中心にして半径500mの範囲を表示(16)
                            self.disMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0,longitudinalMeters: 500.0)
                            
                    }
                }
                
            }
        })
    }
//        デフォルト操作を行うのでtrueを返す(4)
        return true
    }
    
    @IBAction func changeMapButton(_ sender: Any) {
//        mapTypeプロパティー値をトグル
//        標準　→　航空写真　→　航空写真＋標準
//        → 3D Flyover → 3D Flyover+標準
//        →交通機関
        if disMap.mapType == .standard {
             disMap.mapType = .satellite
        } else if disMap.mapType == .satellite {
            disMap.mapType = .hybrid
        } else if disMap.mapType == .hybrid {
            disMap.mapType = .satelliteFlyover
        } else if disMap.mapType == .satelliteFlyover {
            disMap.mapType = .hybridFlyover
        } else if disMap.mapType == .hybridFlyover {
            disMap.mapType = .mutedStandard
        } else {
            disMap.mapType = .standard
        }
        
        
        
    }
    
}

