//
//  FollowCell.swift
//  TaoZ
//
//  Created by liuxiang on 08/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class FollowCell: UICollectionViewCell {

    @IBOutlet weak var avtorImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addRoundedOrShadow(radius: 5, shadowOpacity: 0.3, shadowColor: .black)
//        avtorImg.addRoundedOrShadow(radius: 5, shadowOpacity: 0.7, shadowColor: .black)
        
     
    }

}
