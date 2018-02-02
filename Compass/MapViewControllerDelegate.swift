//
//  MapViewControllerDelegate.swift
//  compass
//
//  Created by Dan Taylor on 8/5/17.
//  Copyright © 2017 Favorshot. All rights reserved.
//


import Foundation
import CoreLocation

protocol MapViewControllerDelegate {
  func update(location: CLLocation)
}
