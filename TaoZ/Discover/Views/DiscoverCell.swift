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
       
    }
    
    func tz_configCell(model:DiscoverModel){
        
        containView.tz_model = model
        containView.backgroundColor = .red
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
