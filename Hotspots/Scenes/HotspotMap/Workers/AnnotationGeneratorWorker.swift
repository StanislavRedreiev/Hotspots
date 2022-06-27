//
//  AnnotationGeneratorWorker.swift
//  Hotspots
//
//  Created by Stas Redreiev on 26.06.2022.
//

import Foundation
import MapKit

protocol AnnotationGeneratorWorkerLogic {
    func generateAnnotations(basedOnHotspots hotspots: [HotspotMap.Hotspot]) -> [MKAnnotation]
}

class AnnotationGeneratorWorker: AnnotationGeneratorWorkerLogic {
    func generateAnnotations(basedOnHotspots hotspots: [HotspotMap.Hotspot]) -> [MKAnnotation] {
        let annotations: [MKAnnotation] = hotspots.map({ hotspot in
            let annotation = MKPointAnnotation()
            annotation.coordinate = hotspot.location.coordinate2D
            return annotation
        })
        return annotations
    }
}
