//
//  MapsViewController.swift
//  OverlayContainerExample
//
//  Created by Edo Oktarifa on 01/04/21.
//

import UIKit
import MapKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var balanceLoading: Bool = true
    var categoryLoading: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutlet()
    }
    
    //MARK: - setupOutlet
    func setupOutlet(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        tableView.register(UINib(nibName: "BalanceCell", bundle: nil), forCellReuseIdentifier: "BalanceCell")
        tableView.tableFooterView = UIView()
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
    }
    
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell", for: indexPath) as! BalanceCell
            cell.setLoadingCell(balanceLoading)
            
            //remove skeletonView
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                cell.setLoadingCell(false)
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.categoryLoading = categoryLoading
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                cell.categoryLoading = false
            }
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension UIView {

    func setCardView(){
        layer.cornerRadius = 5.0
        layer.borderColor  =  UIColor.clear.cgColor
        layer.borderWidth = 1
        layer.shadowOpacity = 1
        layer.shadowColor =  UIColor.darkGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:1, height: 1)
        layer.masksToBounds = false
    }
}
