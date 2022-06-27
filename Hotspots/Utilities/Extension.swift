//
//  Extensions.swift
//  Hotspots
//
//  Created by Stas Redreiev on 22.06.2022.
//

import Foundation
import MapKit

public extension Array {
    subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

extension MKMapView {
    func annotationView<T: MKAnnotationView>(of type: T.Type, annotation: MKAnnotation?, reuseIdentifier: String) -> T {
        guard let annotationView = dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? T else {
            return type.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }
        annotationView.annotation = annotation
        return annotationView
    }
}

extension HotspotMap.Hotspot.Location {
    var coordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

enum InternalError: Error {
    case unknownError
    case notFound
    case invalidResponse
    case readFileError
 }
