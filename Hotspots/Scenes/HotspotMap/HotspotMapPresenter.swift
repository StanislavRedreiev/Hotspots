//
//  HotspotMapPresenter.swift
//  Hotspots
//
//  Created by Stas Redreiev on 22.06.2022.
//

import UIKit

protocol HotspotMapPresentationLogic {
    func presentLoad(response: HotspotMap.Load.Response)
    func presentDisplayLoadingActivity(response: HotspotMap.StartLoadingActivity.Response)
    func presentHideLoadingActivity(response: HotspotMap.StopLoadingActivity.Response)
    func presentErrorHappened(response: HotspotMap.ErrorHappened.Response)
}

final class HotspotMapPresenter: HotspotMapPresentationLogic {
    weak var viewController: HotspotMapDisplayLogic?

    // MARK: Do something

    func presentLoad(response: HotspotMap.Load.Response) {
        let viewModel = HotspotMap.Load.ViewModel()
        viewController?.displayLoad(viewModel: viewModel)
    }

    func presentDisplayLoadingActivity(response: HotspotMap.StartLoadingActivity.Response) {
        let viewModel = HotspotMap.StartLoadingActivity.ViewModel(
            alertTitle: "Hotspots data loading 🚀",
            alertMessage: "Please wait a while until hotspots information will load.")
        viewController?.displayStartLoadingActivity(viewModel: viewModel)
    }

    func presentHideLoadingActivity(response: HotspotMap.StopLoadingActivity.Response) {
        let viewModel = HotspotMap.StopLoadingActivity.ViewModel()
        viewController?.displayStopLoadingActivity(viewModel: viewModel)
    }
    
    func presentErrorHappened(response: HotspotMap.ErrorHappened.Response) {
        let viewModel = HotspotMap.ErrorHappened.ViewModel(
            alertTitle: "Problem during loading 😔",
            alertMessage: "Sorry, the required data could not be loaded.",
            actionTitle: "Ok"
        )
        viewController?.displayErrorHappened(viewModel: viewModel)
    }
}
