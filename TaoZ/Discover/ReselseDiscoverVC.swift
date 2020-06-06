//
//  ReselseDiscoverVC.swift
//  TaoZ
//
//  Created by liuxiang on 2020/6/5.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class ReselseDiscoverVC: BaseViewController {

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navBar.title = "发布动态"
        // Do any additional setup after loading the view.
        creatCollection()
        
        navBar.onClickLeftButton = {()in
            let alert = CancleReleseAlert()
            alert.btnblock = {[weak self](index) in
                self?.navigationController?.popViewController(animated: true)
            }
            alert.show()
        }
    }
    
    override func leftButton_action() {
       
    }
    
    private func creatCollection(){
        layout.itemSize = CGSize(width: (ScreenWidth - 45) / 3, height: (ScreenWidth - 45) / 3)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top:0, left: 15, bottom: 0, right: 15)
        layout.headerReferenceSize = CGSize(width: ScreenWidth, height: 140)
        layout.footerReferenceSize = CGSize(width: 0, height: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "ReleseCell", bundle: nil), forCellWithReuseIdentifier: "FollowCellID")
        
        // 注册headerView
        collectionView.register(UINib.init(nibName: "ReleseHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        // 注册footView
      
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }


  

}

extension ReselseDiscoverVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let indentifier = "FollowCellID"
        
        let cell:ReleseCell! = (collectionView.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath) as! ReleseCell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let headerView : ReleseHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID", for: indexPath) as! ReleseHeaderView
            
            return headerView
        }else{
            let footView : UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerID", for: indexPath)
            return footView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
}

    
