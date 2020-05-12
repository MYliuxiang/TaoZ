//
//  TextViewCell.swift
//  TaoZ
//
//  Created by liuxiang on 12/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit
import InputKitSwift

class TextViewCell: UITableViewCell {

    @IBOutlet weak var countLab: UILabel!
    @IBOutlet weak var textView: LimitedTextView!
    let dispossBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.rx.text.orEmpty.asDriver().map{
            "\($0.count)/140"
        }.drive(countLab.rx.text)
        .disposed(by: dispossBag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
