//
//  VipCell.swift
//  TaoZ
//
//  Created by liuxiang on 2020/6/5.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class VipCell: UITableViewCell {

    @IBOutlet weak var tStatusB: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
        
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x:1,y:1)
        layer.colors = [UIColor.colorWithHex(hexColor: 0xFEE086).cgColor,UIColor.colorWithHex(hexColor: 0xFFAA00).cgColor]
        layer.locations = [0.0,0.6,1.0]
        layer.frame = tStatusB.layer.bounds;
        tStatusB.layer.insertSublayer(layer, at: 0)
        
        tStatusB.layer.cornerRadius = 9
        tStatusB.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
