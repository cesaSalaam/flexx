//
//  ViewController.swift
//  FlexxRide
//
//  Created by Cesa Salaam on 3/31/17.
//  Copyright © 2017 Cesa Salaam. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapVIEW: GMSMapView!
    let manager = CLLocationManager()
    var status = true
    var location = CLLocation()
    
    @IBOutlet weak var StatusBtn: UIBarButtonItem!
    @IBAction func statusClicked(_ sender: Any) {
        try! FIRAuth.auth()!.signOut()
        status = !status
        POST(status)
        if status == false{
        StatusBtn.title = "TURN ON"
        }else{
            StatusBtn.title = "TURN Off"
        }
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 38.96351774, longitude:-77.01957901, zoom: 15.0)
        let mView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mView
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        
        //let camera = GMSCameraPosition.camera(withLatitude: 38.96351774, longitude:-77.01957901, zoom: 15.0)
        //let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //mapVIEW = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude:location.coordinate.longitude )
//        marker.title = "You"
//        marker.map = mapVIEW
    }
    
    func POST(_ open: Bool){
        let scriptURL = "https://flexx2we34re6.herokuapp.com/api/update/driver/status?"
        var urlWithParams = ""
        if open == false{
            urlWithParams = scriptURL + "id=driver234&open=false&lat=\(location.coordinate.latitude)&long=\(location.coordinate.longitude)"}else{
        urlWithParams = scriptURL + "id=driver234&open=true&lat=\(location.coordinate.latitude)&long=\(location.coordinate.longitude)"
        }
        let myUrl = NSURL(string: urlWithParams)
        let request = NSMutableURLRequest(url: myUrl! as URL)
        
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            print(data!)
            
            
        }
        
        task.resume()
    }
    
    
    func ratingButtonTapped() {
        print("Button pressed")
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 16, y: 598, width: 343, height: 49))
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(ratingButtonTapped), for: .touchUpInside)
        view.addSubview(button)
        
        self.StatusBtn.title = "TURN OFF"
        
        manager.delegate = self
        manager.requestLocation()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let Flocation = locations.first {
            print("Found user's location: \(Flocation)")
            location = locations.first!
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}


