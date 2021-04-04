//
//  UIView+Constraint.swift
//  OverlayContainerExample
//
//  Created by Edo Oktarifa on 01/04/21.
//

import Foundation
import UIKit

extension UIView {
    func pinToSuperview(with insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        if edges.contains(.top) {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top).isActive = true
        }
        if edges.contains(.bottom) {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom).isActive = true
        }
        if edges.contains(.left) {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left).isActive = true
        }
        if edges.contains(.right) {
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right).isActive = true
        }
    }
}

//extension UIView {
//
//  // OUTPUT 1
//    func dropShadow() {
//            layer.masksToBounds = false
//            layer.shadowColor = UIColor.black.cgColor
//            layer.shadowOpacity = 0.5
//            layer.shadowOffset = CGSize(width: -1, height: 1)
//            layer.shadowRadius = 1
//            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//            layer.shouldRasterize = true
//            layer.rasterizationScale = UIScreen.main.scale
//        }
//}
