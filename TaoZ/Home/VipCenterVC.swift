//
//  VipCenterVC.swift
//  TaoZ
//
//  Created by liuxiang on 2020/6/5.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class VipCenterVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var hview1: UIView!
    @IBOutlet var footerView: UIView!
    @IBOutlet var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navBar.title = "会员中心"
        self.footerView.height = 100
        self.headerView.height = 77 + 90
        tableView.tableHeaderView = self.headerView
        tableView.tableFooterView = self.footerView
        self.hview1.addRoundedOrShadow(radius: 3, shadowOpacity: 0.5, shadowColor: .black)
        creatCollection()
    }
    
    private func creatCollection(){
        layout.itemSize = CGSize(width: 125, height: 60)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.init(top:15, left: 16, bottom: 15, right: 16)
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        layout.footerReferenceSize = CGSize(width: 0, height: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "VipHCell", bundle: nil), forCellWithReuseIdentifier: "FollowCellID")
       
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }


}

extension VipCenterVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let indentifier = "VideoCellID"
        var cell:VipCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? VipCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("VipCell", owner: nil, options: nil)?.last as? VipCell
            cell.selectionStyle = .none
            
        }
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        return view
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}

extension VipCenterVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let indentifier = "FollowCellID"
        
        let cell:VipHCell! = (collectionView.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath) as! VipHCell)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
}
