//
//  SkeletonViewHelper.swift
//  OverlayContainerExample
//
//  Created by Edo Oktarifa on 04/04/21.
//

import Foundation
import UIKit

extension UIImageView {
    func setLoading(_ status: Bool){
        self.isSkeletonable = true
        if status {
            self.showAnimatedGradientSkeleton(transition: .crossDissolve(0.25))
        } else {
            self.hideSkeleton(transition: .crossDissolve(0.25))
        }
    }
}

extension UILabel {
    func setLoading(_ status: Bool){
        self.linesCornerRadius = 6
        self.isSkeletonable = true
        
        if status {
            self.showAnimatedGradientSkeleton(transition: .crossDissolve(0.25))
        } else {
            self.hideSkeleton(transition: .crossDissolve(0.25))
        }
    }
}

