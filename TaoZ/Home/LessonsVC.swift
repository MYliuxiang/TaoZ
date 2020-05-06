//
//  LessonsVC.swift
//  MayBe
//
//  Created by liuxiang on 09/04/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit


class LessonsVC: BaseViewController {
    
    var cellStatus:Int = 0
    lazy var titleLab:UILabel = UILabel()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.contentInset = UIEdgeInsets.init(top: 82, left: 0, bottom: 0, right: 0)
        setNavBar()
        
        var data = "123456".data(using: .utf8)!
        

        
        
       let buff = data.withUnsafeMutableBytes { (bytes: UnsafeMutablePointer<UInt8>) -> Void in
             //通过指针移动来取值（赋值也是可以的）
        
//        var ss = UnsafeMutablePointer<Int8>(mu)

            let bytesStart = bytes
                           
//            }
          
        }
        print(buff)
        let ctring = "123456".cString(using: .utf8)
//        encoudec_date(UnsafeMutablePointer<Int8>!, <#T##cb: EncodecPcmCallback!##EncodecPcmCallback!##(UnsafeMutablePointer<Int8>?, Int32, Int32, Int32) -> Void#>)
        
//        encoudec_date(ctring) { (pcmBuffer, length, SampleRate, FormatSize) in
//
//
//
//
//        }
        let cs = ("us" as NSString).utf8String
        
        let bb = UnsafeMutablePointer<Int8>(mutating: cs)
        let cc = String(cString: bb!)
        print(cc)
        SVProgressHUD.show()
        
        let ss = UnsafeMutablePointer<Int8>.allocate(capacity: 10)
        
//        print(buffer ?? UnsafeMutablePointer<Int8>.init(bitPattern: 10) ?? <#default value#>)
//
//        encoudec_date(bb) { (pcmBuffer, length, SampleRate, FormatSize) in
//            let dd = String(cString: pcmBuffer!)
//
////            let data = Data(pcmBuffer)
//            let data = NSData(bytes: pcmBuffer, length: Int(length))
//            print(data)
//            
//        }
    
 
     
    }
    
    private func setNavBar(){
        titleLab.font = UIFont.customName("Bold", size: 24)
       
        titleLab.text = "Say greetings"
        navBar.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(navBar).offset(20)
            make.height.equalTo(82)
            make.bottom.equalTo(navBar)
        }
        
        navBar.height = 82 + YMKDvice.statusBarHeight()
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "搜索icon"), for: .normal)
        navBar.addSubview(btn1)
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "小视图icon"), for: .normal)
        navBar.addSubview(btn2)
        
        btn1.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 28, height: 28))
            make.centerY.equalTo(titleLab)
            make.right.equalTo(navBar).offset(-20)
        }
        
        btn2.snp.makeConstraints { (make) in
                  make.size.equalTo(CGSize(width: 28, height: 28))
                  make.centerY.equalTo(titleLab)
            make.right.equalTo(btn1.snp_leftMargin).offset(-27)
              }
        
        
        
    }
    



}


extension LessonsVC: UITableViewDataSource, UITableViewDelegate {
    
      func numberOfSections(in tableView: UITableView) -> Int {
        return 4
        }
           
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
       }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
            if cellStatus == 0{
                let indentifier = "CellBigID"
                var cell:LessonsBigCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? LessonsBigCell
                if cell == nil {
                              
                    cell = Bundle.main.loadNibNamed("LessonsBigCell", owner: nil, options: nil)?.last as? LessonsBigCell
                    cell.selectionStyle = .none
                          
                }
                
                return cell
                
            }else{
                
                let indentifier = "CellSmallID"
                var cell:LessonsSmallCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? LessonsSmallCell
                if cell == nil {
                              
                    cell = Bundle.main.loadNibNamed("LessonsSmallCell", owner: nil, options: nil)?.last as? LessonsSmallCell
                    cell.selectionStyle = .none
                          
                }
                
                return cell
            }
           
            
        }
    
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           
            if section == 0 {
                return 0.1
            }else{
                
                return 56
            }
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           if section == 0 {
               return UIView.init()
           }else{
               
            let view = UIView.init()
            view.height = 56
            
            let lab1 = UILabel.init()
            lab1.font = UIFont.customName("Bold", size: 24)
            lab1.text = "Say job"
            view.addSubview(lab1)
             
            lab1.snp.makeConstraints { (make) in
                make.left.equalTo(view).offset(20)
                make.height.equalTo(24)
                make.bottom.equalTo(view).offset(-12)
            }
             
               
               return view
           }
       }
        
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView.init()
        }
        
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 0.1
        }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cellStatus == 0 {
            return 187
        }else{
            return 85;
        }
        
    }
       
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
        
        
    }
    
   
}

