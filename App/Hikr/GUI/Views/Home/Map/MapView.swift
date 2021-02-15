//
//  MapView.swift
//  Hikr
//
//  Created by Jan Bjelicic on 15/02/2021.
//

import MapKit
import SwiftUI

struct MapView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = MapViewController
    
    func makeUIViewController(context: Context) -> MapViewController {
        return R.storyboard.home.mapViewControllerID()!
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        
    }
    
}
