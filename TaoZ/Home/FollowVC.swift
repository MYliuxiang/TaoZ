//
//  FollowVC.swift
//  TaoZ
//
//  Created by liuxiang on 07/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class FollowVC: BaseViewController {

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.isHidden = true
        // Do any additional setup after loading the view.
        
       
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        creatCollection()
    }
    
    private func creatCollection(){
        layout.itemSize = CGSize(width: 62, height: 106)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = (ScreenWidth - 30 - 186) / 4
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top:0, left: (ScreenWidth - 30 - 186) / 4, bottom: 0, right: (ScreenWidth - 30 - 186) / 4)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "FollowCell", bundle: nil), forCellWithReuseIdentifier: "FollowCellID")
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
    


}

extension FollowVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let indentifier = "FollowCellID"
        
        let cell:FollowCell! = (collectionView.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath) as! FollowCell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
   
}


extension FollowVC: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }

   
    func listScrollView() -> UIScrollView {
        return self.tableView
    }

}

extension FollowVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //说明是图片
        if indexPath.row % 2 == 0 {
            let indentifier = "PhotoCellID"
            var cell:PhotoCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? PhotoCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed("PhotoCell", owner: nil, options: nil)?.last as? PhotoCell
                cell.selectionStyle = .none
                
            }
            return cell
        }else{
            
            let indentifier = "VideoCellID"
            var cell:VideoCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? VideoCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed("VideoCell", owner: nil, options: nil)?.last as? VideoCell
                cell.selectionStyle = .none
                
            }
            return cell
        }
        
        
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
        
        print("点击了")
        
    }
}

