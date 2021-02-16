//
//  MapDelegate.swift
//  Hikr
//
//  Created by Jan Bjelicic on 15/02/2021.
//

import UIKit
import MapKit
import HikrNetworking

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnDemo: CircleButton!
    @IBOutlet weak var btnCurrentLocation: CircleButton!
    
    private var viewModel: MapViewModel!
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
        viewModel = MapViewModel()
    }
    
    private func setupMap() {
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    // MARK: - Buttons
    @IBAction func btnDemoOnClick(_ sender: Any) {
        guard let gpxPath = Bundle.main.path(forResource: "Sljeme", ofType: "gpx") else { return }
        guard let xmlData = FileManager.default.contents(atPath: gpxPath) else { return }
        DispatchQueue.global().async {
            let parser = GPXParser()
            parser.parse(xmlData: xmlData)
        }
    }
    
    @IBAction func btnCurrentLocationOnClick(_ sender: Any) {
        if viewModel.didUserEnableLocation() {
            zoom(to: mapView.userLocation.coordinate)
            toggleCurrentLocationImage(true)
        } else {
            router.presentNoLocationPermissionAlert()
        }
    }
    
    private func toggleCurrentLocationImage(_ isCurrentLocation: Bool) {
        btnCurrentLocation.imageView?.image = UIImage(systemName: isCurrentLocation ? "location.fill" : "location")
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    private func zoom(to coordinate: CLLocationCoordinate2D) {
        let latitudeDelta = 0.005, longitudeDelta = 0.005
        let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        toggleCurrentLocationImage(false)
    }
    
}
