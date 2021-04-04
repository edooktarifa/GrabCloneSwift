//
//  CategoryCell.swift
//  OverlayContainerExample
//
//  Created by Edo Oktarifa on 01/04/21.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var billerCollectionView: UICollectionView!
    
    fileprivate var viewModel = BillerVM()
    var categoryLoading : Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollection()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: -setupCollection
    func setupCollection(){
        billerCollectionView.register(UINib(nibName: "ContentCategoryCell", bundle: nil), forCellWithReuseIdentifier: "ContentCategoryCell")
        billerCollectionView.delegate = self
        billerCollectionView.dataSource = self
        
    }
}

extension CategoryCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.billerData().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCategoryCell", for: indexPath) as! ContentCategoryCell
        
        cell.setupContent(status: categoryLoading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            cell.setupContent(status: false)
            cell.showDataCategory(data: self.viewModel.billerData()[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5, height: collectionView.frame.height / 2)
    }
}
