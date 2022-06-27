//
//  HotspotMapSceneBuilder.swift
//  Hotspots
//
//  Created by Stas Redreiev on 22.06.2022.
//

import UIKit

public protocol SceneBuilder {
    func build() -> UIViewController
}

public final class HotspotMapSceneBuilder: NSObject, SceneBuilder {
    public func build() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "HotspotMap", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: HotspotMapViewController.className) as? HotspotMapViewController else {
            assertionFailure("Couldn't found view controller with identifier \(HotspotMapViewController.className)")
            return UIViewController()
        }

        let interactor = HotspotMapInteractor()
        let presenter = HotspotMapPresenter()

        let router = HotspotMapRouter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.router = router
        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
