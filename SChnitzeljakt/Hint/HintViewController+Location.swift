//
//  File.swift
//  SChnitzeljakt
//
//  Created by Harrison Weinerman on 11/11/18.
//  Copyright © 2018 SChnitzeljakt. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

extension HintViewController: CLLocationManagerDelegate {
    func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        mostRecentLocation = location
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                                       longitude: location.coordinate.longitude),
                                        span: MKCoordinateSpan(latitudeDelta: 0.005,
                                                               longitudeDelta: 0.005))
        self.map.setRegion(region, animated: true)
    }
}
