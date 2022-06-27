//
//  HotspotMapInteractor.swift
//  Hotspots
//
//  Created by Stas Redreiev on 22.06.2022.
//

import UIKit
import MapKit

protocol HotspotMapBusinessLogic: MKMapViewDelegate {
    func doLoad(request: HotspotMap.Load.Request)
    var mapContainer: MKMapView? { get set }
}

final class HotspotMapInteractor: NSObject, HotspotMapBusinessLogic {
    var presenter: HotspotMapPresentationLogic?
    var router: RemoveAccountRoutingLogic?
    
    var mapContainer: MKMapView?
    private var clusterManager: ClusterManager
    private var hotspotLocationsWorker: HotspotLocationsWorkerLogic
    private var annotationGeneratorWorker: AnnotationGeneratorWorkerLogic

    override init() {
        clusterManager = ClusterManager()
        hotspotLocationsWorker = HotspotLocationsWorker()
        annotationGeneratorWorker = AnnotationGeneratorWorker()
        
        super.init()
    }

    // MARK: Do something

    func doLoad(request: HotspotMap.Load.Request) {
        let response = HotspotMap.Load.Response()
        presenter?.presentLoad(response: response)
        
        hotspotLocationsWorker.delegate = self
        hotspotLocationsWorker.fetchHotspotLocations()
        
        presenter?.presentStartLoadingActivity(response: HotspotMap.StartLoadingActivity.Response())
    }
    
    // MARK: Setup
    
    private func setupClusterManager() {
        clusterManager.delegate = self
        clusterManager.maxZoomLevel = 17
        clusterManager.minCountForClustering = 3
        clusterManager.clusterPosition = .average
    }
}

extension HotspotMapInteractor: HotspotLocationWorkerDelegate {
    func hotspotLocationWorker(_ worker: HotspotLocationsWorkerLogic, didFetchHotspots hotspots: [HotspotMap.Hotspot]) {
        let annotations = annotationGeneratorWorker.generateAnnotations(basedOnHotspots: hotspots)
        clusterManager.add(annotations)
        
        guard let map = mapContainer else { return }
        clusterManager.reload(mapView: map)
    }
    
    func hotspotLocationWorker(_ worker: HotspotLocationsWorkerLogic, didFinishWithError error: Error) {
        presenter?.presentStopLoadingActivity(response: HotspotMap.StopLoadingActivity.Response())
        presenter?.presentErrorHappened(response: HotspotMap.ErrorHappened.Response())
    }
}

extension HotspotMapInteractor: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        clusterManager.reload(mapView: mapView, completion: { _ in })
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let response = HotspotMap.StopLoadingActivity.Response()
        presenter?.presentStopLoadingActivity(response: response)
        
        if let annotation = annotation as? ClusterAnnotation {
            let identifier = "Cluster"
            return mapView.annotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            let identifier = "Pin"
            let annotationView = mapView.annotationView(of: MKAnnotationView.self, annotation: annotation, reuseIdentifier: identifier)
            annotationView.image = UIImage(named: "pin_icon")
            return annotationView
        }
    }
}

extension HotspotMapInteractor: ClusterManagerDelegate { }
