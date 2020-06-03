//
//  DiscoverCell.swift
//  TaoZ
//
//  Created by liuxiang on 08/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class DiscoverCell: UITableViewCell {
    
    @IBOutlet weak var contentL: UILabel!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var zanL: UILabel!
    @IBOutlet weak var onLineV: UIView!
    
    @IBOutlet weak var commentL: UILabel!
    @IBOutlet weak var colloecL: UILabel!
    @IBOutlet weak var commentB: UIButton!
    @IBOutlet weak var collecB: UIButton!
    @IBOutlet weak var zanB: UIButton!
    @IBOutlet weak var vipI: UIImageView!
    @IBOutlet weak var peopleB: UIButton!
    @IBOutlet weak var viewL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var avtorImg: UIImageView!
    let containView = ContainerView()
    
     var model:DiscoverModel = DiscoverModel()
        {
           didSet{

        }
       
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.addSubview(containView)
        avtorImg.layer.cornerRadius = 20
        avtorImg.layer.masksToBounds = true
        
        callBtn.layer.cornerRadius = 15
        callBtn.layer.masksToBounds = true
        
        peopleB.layer.cornerRadius = 7
        peopleB.layer.masksToBounds = true
        
        onLineV.layer.cornerRadius = 6.5
        onLineV.layer.masksToBounds = true
        onLineV.layer.borderColor = UIColor.white.cgColor
        onLineV.layer.borderWidth = 2
        
               
    }
    
    func tz_configCell(model:DiscoverModel){
        
        avtorImg.kf.setImage(urlString: model.userinfo?.avatar ?? "")
        nameL.text = model.userinfo?.nickname ?? ""
        if model.userinfo?.is_model == 0 {
            peopleB.isHidden = true
        }else{
            peopleB.isHidden = false
        }
        
        if model.userinfo?.expiry_date == nil {
                   vipI.isHidden = true
               }else{
                   vipI.isHidden = false
               }
        
        if model.userinfo?.is_online == 0 {
            onLineV.isHidden = true
        }else{
                  
            onLineV.isHidden = false
        }
        
     
        
        viewL.text = "\((model.views ?? "0").getTZCountStr())次观看"
        commentL.text = (model.feedback_count ?? "0").getTZCountStr()
        zanL.text = (model.click_count ?? "0").getTZCountStr()
        colloecL.text = (model.collect_count ?? "0").getTZCountStr()
        
        if model.is_click == 0{
            zanB.isSelected = false
        }else{
            zanB.isSelected = true
        }
        
        if model.is_collect == 0{
                  
            collecB.isSelected = false
               
        }else{
                
            collecB.isSelected = true
               
        }
        
        timeL.text = model.createtime!.yuwandarenTimeRegulation()
                
        containView.tz_model = model
        
        
        
        if model.content?.count == 0{
            containView.snp.makeConstraints{(make) in
                            
                      make.top.equalTo(avtorImg.snp.bottom).offset(10)
                      make.left.equalTo(avtorImg.snp.right).offset(10)
                  }
            
        }else{
            contentL.text = model.content
            containView.snp.makeConstraints{(make) in
                            
                      make.top.equalTo(contentL.snp.bottom).offset(10)
                      make.left.equalTo(avtorImg.snp.right).offset(10)
                  }
        }
               
//        containView.snp.makeConstraints{(make) in
//                  
//            make.top.equalTo(avtorImg.snp.bottom).offset(10)
//            make.left.equalTo(avtorImg.snp.right).offset(10)
//        }
        containView.tz_picPathStringsArray = model.imgArray
        
        
        self.callBtn.snp.makeConstraints {
            $0.top.equalTo(containView.snp.bottom).offset(10)
            $0.right.equalTo(contentView).offset(-15)
            $0.height.equalTo(27)
            $0.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
        }
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
