//
//  BalanceCell.swift
//  OverlayContainerExample
//
//  Created by Edo Oktarifa on 02/04/21.
//

import UIKit
import SkeletonView

class BalanceCell: UITableViewCell {

    @IBOutlet weak var contentViews: UIView!
    @IBOutlet weak var saldoAmoutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentViews.layer.cornerRadius = 10
        self.selectionStyle = .none
        contentViews.setCardView()
        contentViews.backgroundColor = .white
    }
    
    func setLoadingCell(_ status: Bool){
        self.saldoAmoutLabel.setLoading(status)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension UIView {
     func dropShadow(radius: CGFloat, offsetX: CGFloat, offsetY: CGFloat, color: UIColor) {
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        layer.shadowOpacity = 1 // setting this property to 1 makes full relation on color's opacity
        layer.shadowColor = color.cgColor
    }
}

