//
//  CategoryTableViewCell.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit

protocol CategoryProductDelegate {
    func didSelectedCategory(id: Int, name: String)
}

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryCollection: DynamicCollectionView!
    
    var delegate: CategoryProductDelegate?
    
    var viewModel = HomeViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        
        categoryCollection.backgroundColor = .white
        categoryCollection.showsHorizontalScrollIndicator = false
        categoryCollection.showsVerticalScrollIndicator =  false
        categoryCollection.clipsToBounds = true
        
        categoryCollection.register(UINib(nibName: "CategoryItemsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CategoryItemsCollectionViewCell.reusableIndentifer)
        
        self.setupViewModel()
        
    }
    
    fileprivate func setupViewModel() {
        
        self.viewModel.showAlertClosure = {
            let alert = self.viewModel.alertMessage ?? ""
            print(alert)
        }
        
        self.viewModel.updateLoadingStatus = {
            if self.viewModel.isLoading {
                print("LOADING...")
            } else {
                print("DATA READY")
            }
        }
        
        self.viewModel.internetConnectionStatus = {
            print("Internet disconnected")
            // show UI Internet is disconnected
        }
        
        self.viewModel.serverErrorStatus = {
            print("Server Error / Unknown Error")
            // show UI Server is Error
        }
        
        self.viewModel.getProduct {
            self.categoryCollection.reloadData()
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {

        self.layoutIfNeeded()
        let contentSize = self.categoryCollection
            .collectionViewLayout
            .collectionViewContentSize
        return CGSize(width: contentSize.width, height: contentSize.height)
    }
    
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.categoryCount ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryItemsCollectionViewCell.reusableIndentifer, for: indexPath) as? CategoryItemsCollectionViewCell else { return UICollectionViewCell() }
        
        let getCategory = self.viewModel.getCategoryItem(at: indexPath)
        cell.setupData(getCategory)
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let getCategory = self.viewModel.getCategoryItem(at: indexPath) {
            self.delegate?.didSelectedCategory(id: getCategory.id ?? 0, name: getCategory.name ?? "")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width / 3.8, height: 160)
    }
    
}

extension CategoryTableViewCell {
    class var reusableIndentifer: String { return String(describing: self) }
}
