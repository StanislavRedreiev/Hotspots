//
//  HotspotsStorage.swift
//  Hotspots
//
//  Created by Stas Redreiev on 22.06.2022.
//

import Foundation

protocol HotspotsStorable: AnyObject {
    
    var delegate: HotspotsStorageDelegate? { get set }
    /** Fetch actual list of hotspots. */
    func fetchHotspots()
}

protocol HotspotsStorageDelegate: AnyObject {
    func hotspotsStorage(_ storage: HotspotsStorage, didReceiveHotspots hotspots: [HotspotMap.Hotspot])
    func hotspotsStorage(_ storage: HotspotsStorage, didFinishWithError error: Error)
}

class HotspotsStorage: HotspotsStorable {
    
    private let defaultStorageFileName = "hotspots"
    private let defaultStorageFileExtension = "hsl"
    
    weak var delegate: HotspotsStorageDelegate?
    
    func fetchHotspots() {
        
        // Fetch needed hotspots data from local file.
        guard let rawContentData = readContentFrom(file: defaultStorageFileName, fileType: defaultStorageFileExtension) else {
            delegate?.hotspotsStorage(self, didFinishWithError: InternalError.readFileError)
            return
        }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let list = self.generateHotspots(by: rawContentData)
            DispatchQueue.main.async {
                self.delegate?.hotspotsStorage(self, didReceiveHotspots: list)
            }
        }
    }

    // MARK: - Handle response data
    
    /** Generate hotspots list based on raw data ingormation. */
    private func generateHotspots(by rawData: String) -> [HotspotMap.Hotspot] {
        var result: [HotspotMap.Hotspot] = []
        let rows = rawData.components(separatedBy: "\n")
        for row in rows {
            guard let hotspot = createHotspot(by: row) else {
                continue
            }
            result.append(hotspot)
        }
        return result
    }
    
    /** Try to parse raw data using specific rules, create and fill out hotspot object. */
    private func createHotspot(by data: String) -> HotspotMap.Hotspot? {
        let plannedNumberOfComponentsInRow = 4
        let components = data.components(separatedBy: ",")
        
        // Custom parse of hotspot data.
        // Ignore component with index 0, because it is unneeded and unused information.
        guard components.count == plannedNumberOfComponentsInRow,
              let hotspotId = components[safe: 1],
              let latitudeRawValue = components[safe: 2],
              let longitudeRawValue = components[safe: 3],
              let hotspotLatitude = Double(latitudeRawValue),
              let hotspotLongitude = Double(longitudeRawValue)
        else {
            return nil
        }
        let hotspotLocation = HotspotMap.Hotspot.Location(
            latitude: hotspotLatitude,
            longitude: hotspotLongitude
        )
        let hotspot = HotspotMap.Hotspot(id: hotspotId, location: hotspotLocation)
        return hotspot
    }
    
    private func readContentFrom(file fileName:String, fileType: String) -> String? {
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType) else {
            return nil
        }
        do {
            let contents = try String(contentsOfFile: filepath, encoding: .utf8)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
}



