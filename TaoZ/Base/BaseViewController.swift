//
//  BaseViewController.swift
//  GDDZ
//
//  Created by ykm on 2019/1/9.
//  Copyright © 2019 ymk. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    lazy var navBar:WRCustomNavigationBar = WRCustomNavigationBar.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: YMKDvice.navBarHeight()))
    
    var rightButton:UIButton?
    var onClickRightButton:(()->Void)?
    let dispossBag = DisposeBag()

//    lazy var appNoNetView:AppNoNetView = AppNoNetView(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
    

    lazy var bottomView : UIView = {
        let bottomView = UIView(frame: CGRect(x: 0, y: ScreenHeight - YMKDvice.bottomOffset(), width: ScreenWidth, height: YMKDvice.bottomOffset()))
        bottomView.backgroundColor = UIColor.clear
          return bottomView
      }()
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
      // Do any additional setup after loading the view.
        UIViewController.attemptRotationToDeviceOrientation()
        navigationController?.navigationBar.isHidden = true
        automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.bottomView)
        self.view.backgroundColor = UIColor.colorWithHexStr("#F7F7F7")
        setupNavBar()
        add_noNetView()

        self.tabBarController?.tabBar.isTranslucent = true;
        
    }
    
    fileprivate func setupNavBar()
    {
        //自定义导航栏
        view.addSubview(navBar)
        // 设置自定义导航栏背景图片
        // 设置自定义导航栏背景颜色
        navBar.barBackgroundColor = .white
        navBar.wr_setBottomLineHidden(true)
        
        
        
        let blurEffect = UIBlurEffect.init(style: .extraLight)
        let effectView = UIVisualEffectView.init(effect: blurEffect)
        navBar.insertSubview(effectView, at: 0)

        effectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
            
//let effectView =[[UIVisualEffectView alloc]initWithEffect:blurEffect];

        
        // 设置自定义导航栏标题颜色
        navBar.titleLabelFont = UIFont.systemFont(ofSize: 18)
        navBar.titleLabelColor = .black
        // 设置自定义导航栏左右按钮字体颜色
        navBar.wr_setTintColor(.black)
//        navBar.wr_setBottomLineHidden(hidden: true)
        
        if self.navigationController?.children.count != 1 {
//            navBar.wr_setLeftButton(with: UIImage.init(named: "back")!)
            navBar.onClickLeftButton = {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    func add_rightButton(titleString:String,textColor:UIColor,backgroundColor:UIColor,font:UIFont,radius:CGFloat) {
        
        self.add_rightButton(titleString: titleString, textColor: textColor, backgroundColor: backgroundColor, font: font, radius: radius, btnWidth: 50, btnHeight: 26)
    }
    
    func add_rightButton(titleString:String,textColor:UIColor,backgroundColor:UIColor,font:UIFont,radius:CGFloat,btnWidth:CGFloat,btnHeight:CGFloat) {
        
        self.add_rightButton(titleString: titleString, imageString: "", style: .none, space: 0, textColor: textColor, backgroundColor: backgroundColor, font: font, radius: radius, btnWidth: btnWidth, btnHeight: btnHeight)
    }
        
    func add_rightButton(titleString:String,imageString:String,style:ButtonEdgeInsetsStyle,space:CGFloat,textColor:UIColor,backgroundColor:UIColor,font:UIFont,radius:CGFloat,btnWidth:CGFloat,btnHeight:CGFloat) {
        
        rightButton = UIButton(type: .custom)
        rightButton?.frame = CGRect(x: navBar.width - btnWidth - 15, y: YMKDvice.statusBarHeight() + (44 - btnHeight) / 2.0 , width: btnWidth, height: btnHeight)
        rightButton?.layer.cornerRadius = radius
        rightButton?.backgroundColor = backgroundColor
        rightButton?.setTitleColor(textColor, for: .normal)
        rightButton?.setTitle(titleString, for: .normal)
        rightButton?.titleLabel?.font = font
        rightButton?.setImage(UIImage(named: imageString), for: .normal)
        rightButton?.addTarget(self, action: #selector(rightButton_action), for: .touchDown)
        rightButton?.layoutButtonWithEdgeInsetsStyle(style:style, space: space)
        self.navBar.addSubview(rightButton!)
    }
    
    @objc func rightButton_action() {
        if onClickRightButton != nil {
            onClickRightButton!()
        }
    }
    
    //添加无网视图
    func add_noNetView() {
//        appNoNetView.isHidden = true
//        keywindow.addSubview(appNoNetView)
    }

    
    // *************************** 屏幕旋转 ****************
    override var shouldAutorotate : Bool
    {
        return false
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return false
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return UIStatusBarStyle.default
    }
    
    
    func setBackgroundImage(imageName:String) {
        let background = UIImageView.init(frame: screenFrame)
        background.clipsToBounds = true
        background.contentMode = .scaleAspectFill
        background.image = UIImage.init(named: imageName)
        self.view.addSubview(background)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
