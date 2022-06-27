//
//  HotspotLocationsWorker.swift
//  Hotspots
//
//  Created by Stas Redreiev on 22.06.2022.

import UIKit

protocol HotspotLocationsWorkerLogic {
    var delegate: HotspotLocationWorkerDelegate? { get set }
    func fetchHotspotLocations()
}
protocol HotspotLocationWorkerDelegate: NSObject {
    func hotspotLocationWorker(_ worker: HotspotLocationsWorkerLogic, didFetchHotspots hotspots: [HotspotMap.Hotspot])
    func hotspotLocationWorker(_ worker: HotspotLocationsWorkerLogic, didFinishWithError error: Error)
}

final class HotspotLocationsWorker: HotspotLocationsWorkerLogic {
    
    private lazy var hotspotsStorage: HotspotsStorable = {
        let storage = HotspotsStorage()
        storage.delegate = self
        return storage
    }()
    
    weak var delegate: HotspotLocationWorkerDelegate?
    
    func fetchHotspotLocations() {
        hotspotsStorage.fetchHotspots()
    }
    
}

extension HotspotLocationsWorker: HotspotsStorageDelegate {
    
    func hotspotsStorage(_ storage: HotspotsStorage, didReceiveHotspots hotspots: [HotspotMap.Hotspot]) {
        delegate?.hotspotLocationWorker(self, didFetchHotspots: hotspots)
    }
    
    func hotspotsStorage(_ storage: HotspotsStorage, didFinishWithError error: Error) {
        delegate?.hotspotLocationWorker(self, didFinishWithError: error)
    }
}

