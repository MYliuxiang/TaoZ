//
//  PersonalVC.swift
//  TaoZ
//
//  Created by liuxiang on 12/05/2020.
//  Copyright © 2020 liuxiang. All rights reserved.
//

import UIKit

class PersonalVC: BaseViewController, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var titles:[Any] = [["头像"],["昵称","桃汁ID","性别","生日","城市"],["个性签名",""]]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navBar.title = "个人资料"
        bottomView.backgroundColor = .clear
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: ScreenWidth - 44 - 10 , y: YMKDvice.statusBarHeight(), width: 44, height: 44)
        btn.setTitle("保存", for: .normal)
        btn.setTitleColor(color_theme, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        navBar.addSubview(btn)
        btn.addTarget(self, action: #selector(saveAC), for: .touchUpInside)
        
        
    }
    
    @objc func saveAC(){
        
        
    }

  

}

extension PersonalVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = titles[section] as! Array<Any>
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //说明是图片
        if indexPath.section == 0 {
            let indentifier = "CellImgID"
            var cell:PersonalImgCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? PersonalImgCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed("PersonalImgCell", owner: nil, options: nil)?.last as? PersonalImgCell
                cell.selectionStyle = .none
                   
            }
            let array = titles[indexPath.section] as! Array<Any>
            cell.titleLab.text = array[indexPath.row] as? String
            return cell
            
        }else if indexPath.section == 1{
            if indexPath.row == 0 {
                let indentifier = "CellTextID"
                var cell:PersonalTextFieldCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? PersonalTextFieldCell
                if cell == nil {
                    cell = Bundle.main.loadNibNamed("PersonalTextFieldCell", owner: nil, options: nil)?.last as? PersonalTextFieldCell
                    cell.selectionStyle = .none
                                  
                }
                           
                let array = titles[indexPath.section] as! Array<Any>
                cell.titleLab.text = array[indexPath.row] as? String
                return cell
            }else{
                let indentifier = "CellID"
                var cell:PersonalCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? PersonalCell
                if cell == nil {
                    cell = Bundle.main.loadNibNamed("PersonalCell", owner: nil, options: nil)?.last as? PersonalCell
                    cell.selectionStyle = .none
                }
                
                if indexPath.row == 1 {
                    cell.accImg.isHidden = true
                }else{
                    cell.accImg.isHidden = false
                }
                           
                let array = titles[indexPath.section] as! Array<Any>
                cell.titleLab.text = array[indexPath.row] as? String
                return cell
            }
          
        }else{
            if indexPath.row == 0 {
                let indentifier = "CelllabelID"
                var cell:LabelCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? LabelCell
                if cell == nil {
                    cell = Bundle.main.loadNibNamed("LabelCell", owner: nil, options: nil)?.last as? LabelCell
                    cell.selectionStyle = .none
                }
                           
                let array = titles[indexPath.section] as! Array<Any>
                cell.titleLab.text = array[indexPath.row] as? String
                return cell

            }else{
                let indentifier = "CellViewID"
                var cell:TextViewCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? TextViewCell
                if cell == nil {
                    cell = Bundle.main.loadNibNamed("TextViewCell", owner: nil, options: nil)?.last as? TextViewCell
                    cell.selectionStyle = .none
                }
                           
                return cell

            }
        }
                
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.colorWithHexStr("#f7f7f7")
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 75
        }else if indexPath.section == 1{
            
            return 52
        }else{
            if indexPath.row == 0 {
                return 52
            }else{
                return 130
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0{
            showBottomAlert()

        }else if indexPath.section == 1{
            
            if indexPath.row == 2 {
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                         
                let takingPictures = UIAlertAction(title:"男", style: .default)
                           {
                               action in
                               
                           }
                           let localPhoto=UIAlertAction(title:"女", style: .default)
                           {
                               action in
                               
                           }
                           alertController.addAction(takingPictures)
                           alertController.addAction(localPhoto)
//                           self.present(alertController, animated:true, completion:nil)
                self.present(alertController, animated: true) {
                    alertController.tapGesAlert()
                }
                
                return
            }
            if indexPath.row == 3 {
                
                // 出生年月日
                let datePickerView = BRDatePickerView()
                let pickStyle = BRPickerStyle()
                pickStyle.topCornerRadius = 10
                pickStyle.cancelTextColor = UIColor.colorWithHexStr("#007AFF")
                pickStyle.doneTextColor = UIColor.colorWithHexStr("#007AFF")
                datePickerView.pickerStyle = pickStyle
                datePickerView.pickerMode = .YMD
                            
                datePickerView.title = "请选择年月日"
                datePickerView.selectDate = NSDate.br_setYear(1992, month: 10, day: 12)
                datePickerView.minDate = NSDate.br_setYear(1948, month: 1, day: 1)
                datePickerView.maxDate = NSDate() as Date
                datePickerView.isAutoSelect = true
                datePickerView.isShowToday = false
                datePickerView.isShowWeek = false
                            //datePickerView.showUnitType = BRShowUnitTypeNone;
                datePickerView.resultBlock = {(selectDate,selectValue) in
//                    self.birthdaySelectDate = selectDate;
//                    self.infoModel.birthdayStr = selectValue;
//                    textField.text = selectValue;
                }
                          
                            
                            
                datePickerView.show()
                
                return

            }
            
            if indexPath.row == 4{
                
                // 地区
                let addressPickerView = BRAddressPickerView();
                addressPickerView.pickerMode = .area
                let pickStyle = BRPickerStyle()
                pickStyle.topCornerRadius = 10
                pickStyle.cancelTextColor = UIColor.colorWithHexStr("#007AFF")
                pickStyle.doneTextColor = UIColor.colorWithHexStr("#007AFF")
                addressPickerView.pickerStyle = pickStyle
                addressPickerView.title = "请选择地区"
                //addressPickerView.selectValues = [self.infoModel.addressStr componentsSeparatedByString:@" "];
//                addressPickerView.selectIndexs = self.addressSelectIndexs;
                addressPickerView.isAutoSelect = true
                addressPickerView.resultBlock = {(province,city,area) in
//                    self.addressSelectIndexs = @[@(province.index), @(city.index), @(area.index)];
//                    self.infoModel.addressStr = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
//                    textField.text = self.infoModel.addressStr;
                }
               
                addressPickerView.show()
                
                
                
                return
            }

        }
        
    }
    
    func showBottomAlert(){
        
        let alertController=UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cancel = UIAlertAction(title:"取消", style: .cancel, handler: nil)
        let takingPictures = UIAlertAction(title:"拍照", style: .default)
        {
            action in
            self.goCamera()
            
        }
        let localPhoto=UIAlertAction(title:"我的相册", style: .default)
        {
            action in
            self.goImage()
            
        }
        alertController.addAction(cancel)
        alertController.addAction(takingPictures)
        alertController.addAction(localPhoto)
        self.present(alertController, animated:true, completion:nil)
        
    }
    
    func goCamera(){
                    
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            //在需要的地方present出来
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            
            print("不支持拍照")
            
        }

    }
    
    func goImage(){

        
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = .photoLibrary
        //在需要的地方present出来
        self.present(photoPicker, animated: true, completion: nil)
        
    }
    
    
}

extension PersonalVC:UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {


        print("获得照片============= \(info)")
        
        let image : UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage

        //显示设置的照片

        self.dismiss(animated: true, completion: nil)
    }
}

