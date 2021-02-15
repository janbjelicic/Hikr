//
//  MapDelegate.swift
//  Hikr
//
//  Created by Jan Bjelicic on 15/02/2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnCurrentLocation: UIButton!
    
    private lazy var viewModel: MapViewModel = MapViewModel()
    private var router: MapRouter!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupMap()
    }
    
    // MARK: - Setup
    private func initialSetup() {
        router = MapRouter(self)
    }
    
    private func setupMap() {
        mapView.delegate = self
    }
    
    // MARK: - Buttons
    @IBAction func btnCurrentLocationOnClick(_ sender: Any) {
        router.presentNoLocationPermissionAlert()
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
}
