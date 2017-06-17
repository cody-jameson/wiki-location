//
//  ViewController.swift
//  google-maps-2
//
//  Created by Cody Jameson on 6/6/17.
//  Copyright © 2017 CJ. All rights reserved.
//

import UIKit
import GoogleMaps
import Foundation
import GooglePlaces

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
//var locManager = CLLocationManager()
var locationManager: CLLocationManager!
var placesClient: GMSPlacesClient!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadView() {
        
        self.locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()

        //let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate

        /*let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude,
                                              longitude:locValue.longitude,
                                              zoom:14)*/
        let camera = GMSCameraPosition.camera(withLatitude: 47.6062,
                                              longitude: -122.3321,
                                              zoom:18)
        
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        //mapView.settings.showsUserLocation = true
        mapView.settings.myLocationButton = true
        mapView.settings.zoomGestures = true
        mapView.settings.compassButton = true
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        mapView.delegate = self
        
        self.view = mapView
   
    }
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String,
                 name: String, location: CLLocationCoordinate2D) {
        _=wikibase.searchWikipedia(titles: Helper.replaceSpacesWithUnderscore(string: name))
        
        
    }
    
    
    @IBAction func stopButtonClicked(sender: UIButton){
        _=wikibase.stopSpeech()
    }
    
    func collectionView(_ collectionView:UICollectionViewLayout, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: view.frame.width, height:50)
    }
    
    
    
    

}

