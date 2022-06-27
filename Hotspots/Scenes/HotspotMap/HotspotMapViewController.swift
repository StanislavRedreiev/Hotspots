//
//  HotspotMapViewController.swift
//  Hotspots
//
//  Created by Stas Redreiev on 22.06.2022.
//

import UIKit
import MapKit

protocol HotspotMapDisplayLogic: AnyObject {
    func displayLoad(viewModel: HotspotMap.Load.ViewModel)
    func displayStartLoadingActivity(viewModel: HotspotMap.StartLoadingActivity.ViewModel)
    func displayStopLoadingActivity(viewModel: HotspotMap.StopLoadingActivity.ViewModel)
    func displayErrorHappened(viewModel: HotspotMap.ErrorHappened.ViewModel)
}

class HotspotMapViewController: UIViewController, HotspotMapDisplayLogic {
    
    @IBOutlet private var mapView: MKMapView!
    private var loadingActivityAlertController: UIAlertController?
    var interactor: HotspotMapBusinessLogic?
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doLoad()
    }

    // MARK: Do something

    private func doLoad() {
        let request = HotspotMap.Load.Request()
        interactor?.doLoad(request: request)
    }

    private func setupUI() {
        interactor?.mapContainer = mapView
        mapView.delegate = interactor
    }
    
    private func showLoadingActivityAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        loadingActivityAlertController = alertController
        present(alertController, animated: true)
    }
    
    private func hideLoadingActivityAlert() {
        guard let alertController = loadingActivityAlertController, presentedViewController != nil else {
            return
        }
        alertController.dismiss(animated: true)
    }
    
    private func showErrorAlert(title: String, message: String, actionTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismisAction = UIAlertAction(title: actionTitle, style: .cancel, handler: {_ in })
        alertController.addAction(dismisAction)
        present(alertController, animated: true)
    }

    // MARK: Display

    func displayLoad(viewModel: HotspotMap.Load.ViewModel) { }

    func displayStartLoadingActivity(viewModel: HotspotMap.StartLoadingActivity.ViewModel) {
        showLoadingActivityAlert(title: viewModel.alertTitle, message: viewModel.alertMessage)
    }

    func displayStopLoadingActivity(viewModel: HotspotMap.StopLoadingActivity.ViewModel) {
        hideLoadingActivityAlert()
    }
    
    func displayErrorHappened(viewModel: HotspotMap.ErrorHappened.ViewModel) {
        showErrorAlert(title: viewModel.alertTitle, message: viewModel.alertMessage, actionTitle: viewModel.actionTitle)
    }
}

extension MKMapView {
    func annotationView(annotation: MKAnnotation?, reuseIdentifier: String) -> MKAnnotationView {
        let annotationView = self.annotationView(of: HotspotClusterAnnotationView.self, annotation: annotation, reuseIdentifier: reuseIdentifier)
        return annotationView
    }
}
