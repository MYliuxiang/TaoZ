//
//  LxBrowser.swift
//  TaoZ
//
//  Created by liuxiang on 09/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class LxBrowser: SKPhotoBrowser {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       

       
    
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        let wcanScrollerIndex = 2
                       
                       if scrollView.contentOffset.x >= CGFloat(wcanScrollerIndex) * scrollView.width {
                           //不能滑动了
               //            scrollView.contentOffset.x = CGFloat(wcanScrollerIndex) * scrollView.width
                           scrollView.setContentOffset(CGPoint(x: CGFloat(wcanScrollerIndex) * scrollView.width , y: 0), animated: false)
                           scrollView.contentSize = CGSize(width: CGFloat(wcanScrollerIndex + 1) * scrollView.width , height: scrollView.height)


                       }
        
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
