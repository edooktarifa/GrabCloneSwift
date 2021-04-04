//
//  BillerCell.swift
//  OverlayContainerExample
//
//  Created by Edo Oktarifa on 01/04/21.
//

import UIKit

class ContentCategoryCell: UICollectionViewCell {

    @IBOutlet weak var billerImg: UIImageView!
    @IBOutlet weak var billerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupContent(status: Bool){
        billerImg.setLoading(status)
        billerLbl.setLoading(status)
    }
    
    func showDataCategory(data: billerModel){
        billerImg.image = data.billerImage
        billerLbl.text = data.billerName
    }
}
