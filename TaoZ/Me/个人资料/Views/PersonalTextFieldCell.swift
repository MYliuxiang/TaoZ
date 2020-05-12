//
//  PersonalTextFieldCell.swift
//  TaoZ
//
//  Created by liuxiang on 12/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class PersonalTextFieldCell: UITableViewCell {

    @IBOutlet weak var accImg: UIImageView!
    @IBOutlet weak var textField: LimitedTextField!
    @IBOutlet weak var titleLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
