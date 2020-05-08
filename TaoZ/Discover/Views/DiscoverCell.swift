//
//  DiscoverCell.swift
//  TaoZ
//
//  Created by liuxiang on 08/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class DiscoverCell: UITableViewCell {
    
    @IBOutlet weak var callBtn: UIButton!
    
    @IBOutlet weak var avtorImg: UIImageView!
    let containView = ContainerView()
    
     var model:DiscoverModel = DiscoverModel()
        {
           didSet{

            containView.sd_layout().topSpaceToView(avtorImg, 10)
            callBtn.sd_layout()?.topEqualToView(containView)
               
            setupAutoHeight(withBottomView: callBtn, bottomMargin: 10)
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
               
        containView.snp.makeConstraints{[weak self](make) in
                  
            make.top.equalTo(avtorImg.snp.bottom).offset(10)
            make.left.equalTo(avtorImg.snp.right).offset(10)
        }
        
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
