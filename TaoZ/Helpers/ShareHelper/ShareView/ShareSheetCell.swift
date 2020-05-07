//
//  ShareSheetCell.swift
//  YJKApp
//
//  Created by YJK on 2020/3/11.
//  Copyright © 2020 lijiang. All rights reserved.
//

import UIKit

class ShareSheetCell: UICollectionViewCell {


    var collectionView: UICollectionView!
    
    var bottomLine: UIView!
    
    var sheetCellClicked: ((ShareSheetCell, Int) -> Void)?
    
    var layout:UICollectionViewFlowLayout?
    
    var shareItems: [ShareItem]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        layout = UICollectionViewFlowLayout()
        layout?.minimumLineSpacing = 0
        layout?.minimumInteritemSpacing = 0
        layout?.scrollDirection = .horizontal
        layout?.itemSize = CGSize(width: maxShareItemsCount > maxlineShowCount ? self.frame.width / maxlineShowCount : self.frame.width / maxShareItemsCount, height: kSheetCellHeight)
        
        collectionView = UICollectionView(frame: self.contentView.bounds, collectionViewLayout: layout!)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ShareItemCell.self, forCellWithReuseIdentifier: "cell")
        self.contentView.addSubview(collectionView)
        
        bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(hex6: 0xf2f2f2)
        bottomLine.frame = CGRect(x: 0, y: self.bounds.height,
                                  width: self.bounds.width, height: 1)
        self.contentView.addSubview(bottomLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ShareSheetCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (shareItems?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShareItemCell
        cell.indexPath = indexPath
        cell.shareItem = shareItems?[indexPath.row]
        cell.cellClicked = { (shareCell) in
            self.sheetCellClicked?(self, indexPath.row)
        }
        return cell
    }
    
    
}
