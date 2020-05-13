//
//  LxPlayerControlView.swift
//  TaoZ
//
//  Created by liuxiang on 13/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class LxPlayerControlView: ZFPlayerControlView {
      
    var mobileNetView:MobileView! = MobileView()
    let dispossBag = DisposeBag()
    let vipStatus = BehaviorSubject<Bool>(value: false)
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          setUp()
        vipStatus.asObserver().subscribe { (vipStaus) in
            
        }.disposed(by: rx.disposeBag)
        
          
      }
      
      required init?(coder: NSCoder) {
          super.init(coder: coder)
          setUp()

      }
    
    func setUp() {
        
        addSubview(mobileNetView!)
         mobileNetView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        mobileNetView.isHidden = true
        
    }
   

}

extension LxPlayerControlView{
    
    override func videoPlayer(_ videoPlayer: ZFPlayerController, reachabilityChanged status: ZFReachabilityStatus) {
        switch status {
        case .notReachable:
            //没有网络
           
            self.player?.currentPlayerManager.pause?()
            mobileNetView.isHidden = true
         


            break
        case .reachableViaWiFi:
            //waifi
            self.player?.currentPlayerManager.play?()
            mobileNetView.isHidden = true
         

            break
        default:
            //移动网络
           
            self.player?.currentPlayerManager.pause?()
            mobileNetView.isHidden = false
            if self.player?.isFullScreen ?? false {
                self.player?.enterFullScreen(false, animated: true)
            }
        

            
           
            break
        }
    }
        
    override func videoPlayer(_ videoPlayer: ZFPlayerController, loadStateChanged state: ZFPlayerLoadState) {
        super.videoPlayer(videoPlayer, loadStateChanged: state)
        if state == .stalled {
            //播放完缓冲之后暂停了
            //显示没网状态的
        }
    }
    
}
