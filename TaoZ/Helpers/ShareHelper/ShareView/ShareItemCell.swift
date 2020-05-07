//
//  ShareItemCell.swift
//  YJKApp
//
//  Created by YJK on 2020/3/11.
//  Copyright © 2020 lijiang. All rights reserved.
//

import UIKit

class ShareItemCell: UICollectionViewCell {
    /// 按钮
    var iconButton: UIButton
    /// 文字
    var titleLable: UILabel
    
    var cellClicked: ((ShareItemCell) -> Void)?
    
    var indexPath:IndexPath?
    
    var shareItem: ShareItem! {
        didSet {
            setupInfo()
            self.startAnimation(delayTime: TimeInterval(Double((indexPath?.row ?? 0) + 1) * 0.03))
        }
    }
    
    override init(frame: CGRect) {
       
        titleLable = UILabel()
        iconButton = UIButton(type: .custom)
        super.init(frame: frame)
        
        titleLable.numberOfLines = 2
        titleLable.font = UIFont.systemFont(ofSize: 11)
        titleLable.textColor = UIColor.darkGray
        titleLable.textAlignment = .center
        contentView.addSubview(titleLable)
                
        iconButton.addTarget(self, action: #selector(iconButtonClick), for: .touchUpInside)
        contentView.addSubview(iconButton)
        
    }
    
    func setupInfo() {
        titleLable.text = shareItem.title
        iconButton.setImage(shareItem.icon, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
       
        let contentWidth = self.frame.width
        let contentHeight = self.frame.height
        let iconButtonSize = shareItem.icon.size
        let size = titleLable.sizeThatFits(CGSize(width: contentWidth, height: CGFloat.greatestFiniteMagnitude))
        iconButton.frame = CGRect(x: (contentWidth-iconButtonSize.width)/2, 
                                  y: (contentHeight - iconButtonSize.height - ceil(size.height) - 8)/2,
                                  width: iconButtonSize.width, 
                                  height: iconButtonSize.height)
   
        titleLable.frame = CGRect(x: 0, y: iconButton.bottom + 8,
                                  width: contentWidth, height: ceil(size.height))
    }
    
    // MARK: Action
    @objc func iconButtonClick() {
        if let shareItem = shareItem, let selectionHandler = shareItem.selectionHandler {
            selectionHandler(shareItem)
        }
        
        if let cellClicked = cellClicked {
            cellClicked(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation(delayTime:TimeInterval) {
        let originalFrame = self.frame
        self.frame = CGRect.init(origin: CGPoint.init(x: originalFrame.minX, y: 35), size: originalFrame.size)
        UIView.animate(withDuration: 0.9, delay: delayTime, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            self.frame = originalFrame
        }) { finished in
        }
    }
}
