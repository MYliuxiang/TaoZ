//
//  VolumeCongit.swift
//  MayBe
//
//  Created by liuxiang on 22/04/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit
import MediaPlayer


class VolumeCongit: NSObject {

    
    static func changeVolumeToMax() {
                  let volumeBig = MPVolumeView()
                  var slider: UISlider?
                  for view: UIView in volumeBig.subviews {

                      if type(of: view).description() == "MPVolumeSlider" {
                          slider = (view as! UISlider)
                          break
                      }
                  }
                  let systemVolume = slider?.value ?? 0.5
                  if systemVolume < 0.9 {
                      slider?.setValue(0.9, animated: false)
                      slider?.sendActions(for: .touchUpInside)
                  }
              }
              
       
                
     static func volumeBig() {
              let session = AVAudioSession.sharedInstance()
           if session.category != AVAudioSession.Category.playback {
               try! session.setCategory(AVAudioSession.Category.playback)
                  try! session.setActive(true)
              }
          }
    
    
}
