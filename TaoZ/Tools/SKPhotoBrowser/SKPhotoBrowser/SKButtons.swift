//
//  SKButtons.swift
//  SKPhotoBrowser
//
//  Created by 鈴木 啓司 on 2016/08/09.
//  Copyright © 2016年 suzuki_keishi. All rights reserved.
//

import Foundation

// helpers which often used
private let bundle = Bundle(for: SKPhotoBrowser.self)

class SKButton: UIButton {
    internal var showFrame: CGRect!
    internal var hideFrame: CGRect!
    
    fileprivate var insets: UIEdgeInsets {
        if UI_USER_INTERFACE_IDIOM() == .phone {
            return UIEdgeInsets(top: 15.25, left: 15.25, bottom: 15.25, right: 15.25)
        } else {
            return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }
    }
    fileprivate let sksize: CGSize = CGSize(width: 44, height: 44)
    fileprivate var skmarginX: CGFloat = 0
    fileprivate var skmarginY: CGFloat = 0
    fileprivate var extraskmarginY: CGFloat = SKMesurement.isPhoneX ? 10 : 0
    
    func setup(_ imageName: String) {
        backgroundColor = .clear
        imageEdgeInsets = insets
        translatesAutoresizingMaskIntoConstraints = true
        autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin]
        
        let image = UIImage(named: "SKPhotoBrowser.bundle/images/\(imageName)", in: bundle, compatibleWith: nil) ?? UIImage()
        setImage(image, for: .normal)
    }
  
    func setFramesksize(_ sksize: CGSize? = nil) {
        guard let sksize = sksize else { return }
        
        let newRect = CGRect(x: skmarginX, y: skmarginY, width: sksize.width, height: sksize.height)
        frame = newRect
        showFrame = newRect
        hideFrame = CGRect(x: skmarginX, y: -skmarginY, width: sksize.width, height: sksize.height)
    }
    
    func updateFrame(_ framesksize: CGSize) { }
}

class SKImageButton: SKButton {
    fileprivate var imageName: String { return "" }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(imageName)
        showFrame = CGRect(x: skmarginX, y: skmarginY, width: sksize.width, height: sksize.height)
        hideFrame = CGRect(x: skmarginX, y: -skmarginY, width: sksize.width, height: sksize.height)
    }
}

class SKCloseButton: SKImageButton {
    override var imageName: String { return "btn_common_close_wh" }
    override var skmarginX: CGFloat {
        get {
            return SKPhotoBrowserOptions.swapCloseAndDeleteButtons
                ? SKMesurement.screenWidth - SKButtonOptions.closeButtonPadding.x - self.sksize.width
                : SKButtonOptions.closeButtonPadding.x
        }
        set { super.skmarginX = newValue }
    }
    override var skmarginY: CGFloat {
        get { return SKButtonOptions.closeButtonPadding.y + extraskmarginY }
        set { super.skmarginY = newValue }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(imageName)
        showFrame = CGRect(x: skmarginX, y: skmarginY, width: sksize.width, height: sksize.height)
        hideFrame = CGRect(x: skmarginX, y: -skmarginY, width: sksize.width, height: sksize.height)
    }
}

class SKDeleteButton: SKImageButton {
    override var imageName: String { return "btn_common_delete_wh" }
    override var skmarginX: CGFloat {
        get {
            return SKPhotoBrowserOptions.swapCloseAndDeleteButtons
                ? SKButtonOptions.deleteButtonPadding.x
                : SKMesurement.screenWidth - SKButtonOptions.deleteButtonPadding.x - self.sksize.width
        }
        set { super.skmarginX = newValue }
    }
    override var skmarginY: CGFloat {
        get { return SKButtonOptions.deleteButtonPadding.y + extraskmarginY }
        set { super.skmarginY = newValue }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(imageName)
        showFrame = CGRect(x: skmarginX, y: skmarginY, width: sksize.width, height: sksize.height)
        hideFrame = CGRect(x: skmarginX, y: -skmarginY, width: sksize.width, height: sksize.height)
    }
}
