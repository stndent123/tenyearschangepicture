//
//  ViewController.swift
//  tenyearschangepicture
//
//  Created by joseph on 2020/3/11.
//  Copyright © 2020 joseph. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    //三個物件的Outlet連線
    @IBOutlet weak var hollyPotterImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var yearSlider: UISlider!
    //宣告hollyPotterImageView中的圖片代表常數
    let dateFormatter = DateFormatter()
    let yearimage = ["2001","2003","2005","2007","2009",]
    //宣告變數
    var dateString:String = ""
    var timer:Timer?
    var yearcount = 0
    var slidervalue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    //建立dateFormatter
        time()
        datePicker.locale = Locale(identifier: "zh-Tw")
        dateFormatter.dateFormat="yyyy"
    }
    //比對陣列內的哈利波特圖片
    func compare(){
        if yearcount >= yearimage.count{
            yearcount = 0
            chooseImage(num2:yearcount)
            hollyPotterImageView.image = UIImage(named: yearimage[yearcount])
        }else{
            chooseImage(num2:yearcount)
            hollyPotterImageView.image = UIImage(named: yearimage[yearcount])
        }
        //slider跟著動
        yearSlider.value = Float(yearcount)
        yearcount += 1
    }
    
    //讓APP隔一段時間動作 每秒執行一次compare
    func time(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){(timer)in self.compare()}
    }
    
    @IBAction func changeImageDatePicker(_ sender: UIDatePicker) {
        let ImageDate = datePicker.date
        let dateComponents = Calendar.current.dateComponents(in:TimeZone.current, from: ImageDate)
        let year = dateComponents.year!
        
        hollyPotterImageView.image = UIImage(named: "\(year)")
        
     }
    @IBAction func changeValueSlider(_ sender: UISlider) {
       //slider的值四捨五入
        sender.value.round()
        slidervalue = Int(sender.value)
        datePicker.date = dateFormatter.date(from: yearimage[slidervalue])!
        hollyPotterImageView.image = UIImage(named: yearimage[slidervalue])
        
        }
    @IBAction func autoPlaySwitch(_ sender: UISwitch) {
        if sender.isOn{
            
            time()
            yearcount = slidervalue
            yearSlider.value = Float(yearcount)
        }else{
            timer?.invalidate()
        }
    }
    //使用Switch做選擇圖片的連續值判斷
    func chooseImage(num2:Int){
        switch num2 {
        case 0:
            dateString = "2001"
        case 1:
            dateString = "2003"
        case 2:
            dateString = "2005"
        case 3:
            dateString = "2007"
        default:
            dateString = "2009"
        }
        //修改datepicker顯示日期為dateString內的日期
        let date = dateFormatter.date(from: dateString)
        datePicker.date = date!
    }
   //關閉APP畫面即停止timer,以防止在背景持續執行
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
}

