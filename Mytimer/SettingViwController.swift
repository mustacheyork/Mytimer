//
//  SettingViwController.swift
//  Mytimer
//
//  Created by 浅野未央 on 2017/06/03.
//  Copyright © 2017年 mio. All rights reserved.
//

import UIKit

class SettingViwController: UIViewController ,UIPickerViewDataSource ,UIPickerViewDelegate {

  let settingArrey : [Int] = [10,20,30,40,50,60]
  
  let settingKey = "timer_value"
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      timerSettingPicker.delegate = self
      timerSettingPicker.dataSource = self
      
      let settings = UserDefaults.standard
      let timerValue = settings.integer(forKey: settingKey)
      
      //40だったら４０戻る
      for row in 0..<settingArrey.count{
        if settingArrey[row] == timerValue {
          timerSettingPicker.selectRow(row, inComponent:0 ,animated:true)
        }
      }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  @IBOutlet weak var timerSettingPicker: UIPickerView!

  @IBAction func decButtonAction(_ sender: Any) {
   
    _ = navigationController?.popViewController(animated: true)
    
  }
  func numberOfComponents(in pickerView: UIPickerView) -> Int{
    return 1
    
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return settingArrey.count
  }
//見えてるとこしか呼ばれない
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return String(settingArrey[row])
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
  {
    let settings = UserDefaults.standard
    settings.setValue(settingArrey[row], forKey: settingKey)
    settings.synchronize()
  }
  }
  
  //synchonize
  




