//
//  HotspotAnnotationView.swift
//  Hotspots
//
//  Created by Stas Redreiev on 26.06.2022.
//

import UIKit

class HotspotClusterAnnotationView: ClusterAnnotationView {
    override func configure() {
        super.configure()

        guard let annotation = annotation as? ClusterAnnotation else { return }
        let count = annotation.annotations.count
        let diameter = radius(for: count) * 2
        self.frame.size = CGSize(width: diameter, height: diameter)
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.backgroundColor = UIColor.purple.cgColor
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 1.5
        
        countLabel.attributedText = labelAttributedText(for: count)
    }
    
    /** Generate attributed text for common label of cluster. */
    private func labelAttributedText(for count: Int) -> NSAttributedString {
        let fullString = NSMutableAttributedString(string: "\(count) ")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "wifi_icon.png")
        
        let imagePart = NSAttributedString(attachment: imageAttachment)
        fullString.append(imagePart)
        return fullString
    }

    /** Get size of cluster icon based on items count in cluster. */
    private func radius(for count: Int) -> CGFloat {
        if count < 10 {
            return 18
        } else if count < 50 {
            return 25
        } else if count < 100 {
            return 30
        } else {
            return 35
        }
    }
}
