//
//  HotspotMap.swift
//  Hotspots
//
//  Created by Stas Redreiev on 22.06.2022.
//

import UIKit

enum HotspotMap {
    
    // MARK: Models
    
    struct Hotspot {
        
        struct Location {
            let latitude: Double
            let longitude: Double
        }
        /** Hotspot's local identifier. */
        let id: String
        let location: Location
    }

    // MARK: Use cases

    enum Load {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }

    enum StartLoadingActivity {
        struct Request {}
        struct Response {}
        struct ViewModel {
            let alertTitle: String
            let alertMessage: String
        }
    }

    enum StopLoadingActivity {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
    
    enum ErrorHappened {
        struct Request {}
        struct Response {}
        struct ViewModel {
            let alertTitle: String
            let alertMessage: String
            let actionTitle: String
        }
    }
}
