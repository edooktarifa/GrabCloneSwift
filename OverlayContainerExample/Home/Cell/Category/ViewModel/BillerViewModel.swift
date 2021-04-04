//
//  BillerViewModel.swift
//  OverlayContainerExample
//
//  Created by Edo Oktarifa on 02/04/21.
//

import Foundation
import UIKit

class BillerVM: NSObject {
    
//    var billerList: [billerModel] = [
//        billerModel(billerName: <#T##String?#>, billerImage: <#T##UIImageView?#>)
//    ]
    
    func billerData() -> [billerModel]{
        let data = [billerModel(billerName: "Car", billerImage: #imageLiteral(resourceName: "car")),
                    billerModel(billerName: "Bike", billerImage: #imageLiteral(resourceName: "bike")),
                    billerModel(billerName: "Food", billerImage: #imageLiteral(resourceName: "food")),
                    billerModel(billerName: "Delivery", billerImage: #imageLiteral(resourceName: "delivery")),
                    billerModel(billerName: "Rent", billerImage: #imageLiteral(resourceName: "rent")),
                    billerModel(billerName: "Gift Cards", billerImage: #imageLiteral(resourceName: "giftcard")),
                    billerModel(billerName: "Subsription", billerImage: #imageLiteral(resourceName: "subscription")),
                    billerModel(billerName: "More", billerImage: #imageLiteral(resourceName: "car"))]
        return data
    }
}
