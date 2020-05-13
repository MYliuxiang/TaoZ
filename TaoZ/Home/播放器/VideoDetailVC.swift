//
//  VideoDetailVC.swift
//  TaoZ
//
//  Created by liuxiang on 13/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class VideoDetailVC: BaseViewController {
    
    
   lazy var containerView:UIImageView = {
        let conView = UIImageView()
        conView.frame = CGRect(x: 0, y: YMKDvice.statusBarHeight(), width: ScreenWidth, height: ScreenWidth / 375 * 210)
        return conView
    }()
    var player:ZFPlayerController?
    
    
    var controlView:LxPlayerControlView = {
        let conVie = LxPlayerControlView()
        conVie.fastViewAnimated = true
        conVie.autoHiddenTimeInterval = 5
        conVie.autoFadeTimeInterval = 0
        conVie.prepareShowLoading = true
        conVie.prepareShowControlView = true
        conVie.bottomPgrogress.minimumTrackTintColor = color_theme
        return conVie
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.isHidden = true
        // Do any additional setup after loading the view.
        view.addSubview(containerView)
        
        setUI()
    }
    
    func setUI(){
        self.player = ZFPlayerController.player(withPlayerManager: ZFAVPlayerManager(), containerView: containerView)
        player?.controlView = controlView
        player?.pauseWhenAppResignActive = false
        player?.playerDidToEnd = { asset in
            
        }
        player?.orientationWillChange = {[weak self] (player,isFullScreen) in
            AppDelegate.app.allowOrentitaionRotation = isFullScreen
            self?.setNeedsStatusBarAppearanceUpdate()
            if !isFullScreen {
                       /// 解决导航栏上移问题
                self?.navigationController?.navigationBar.zf_height = YMKDvice.navBarHeight();
                   }
        }
        player?.assetURL = URL(string: "https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4")!
        player?.isWWANAutoPlay = true
        
        
        
    }
    
    

    
    func preferredStatusBarStyle() -> UIStatusBarStyle{
        if (player?.isFullScreen)! {
            return .lightContent
        }
        return .default
    }
    
    func prefersStatusBarHidden() -> Bool{
        return (player?.isStatusBarHidden)!
    }
       
    func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation{
        return .slide
    }

    func shouldAutorotate() -> Bool{
        return (player?.shouldAutoPlay)!
    }
    
    
    func supportedInterfaceOrientations() ->UIInterfaceOrientationMask{
        if (player?.isFullScreen)! && player?.orientationObserver.fullScreenMode == ZFFullScreenMode.landscape{
            return .landscape
        }
        return .portrait
    }

   

   



 

}
