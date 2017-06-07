//
//  ViewController.swift
//  Mytimer
//
//  Created by 浅野未央 on 2017/06/03.
//  Copyright © 2017年 mio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var timer : Timer?
  
  var count = 0
  //　int型
		
  let settingKey = "timer_value"
		
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let settings = UserDefaults.standard
    //起動時のデフォルト（初期値；設定値がない場合を登録）
    settings.register(defaults: [settingKey:10])
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBOutlet weak var conuntDuwnLabel: UILabel!
  
  @IBAction func settingBottonAction(_ sender: Any) {
    
    if let nowTimer = timer {
      //アンラップ
      
      if nowTimer.isValid == true{
        nowTimer.invalidate()
      }
      
    }
    //矢印の動作
   performSegue(withIdentifier: "goSetting", sender: nil)
  }
  
  @IBAction func startButtonAction(_ sender: Any) {
    
    //連打した場合のイレギュラー処理
    if let nowTimer = timer {
    if nowTimer.isValid == true{
      
        return
      }
    }
    
    timer = Timer.scheduledTimer(timeInterval: 1.0,
                                 target: self,
                                 selector: #selector(self.tiamerImterrupt(_:)),
                                 userInfo: nil,
                                 repeats: true)
                                   //アラートはflse

  }
  
  @IBAction func stopButtonAction(_ sender: Any) {
    if let nowTimer = timer {
      
      if nowTimer.isValid == true{
        
        nowTimer.invalidate()
        
      }
    }
    
  }
  
  func displayUpdate() -> Int {
    
    let settings = UserDefaults.standard
    
    let timerValue = settings.integer(forKey: settingKey)
    
    let remainCount = timerValue - count
    
    conuntDuwnLabel.text = "残り\(remainCount)秒"
    
    return remainCount
    
    
  }
  func  tiamerImterrupt(_ timer:Timer) {
    
    count += 1
    
    if displayUpdate() <= 0 {
      
      count = 0
      
      timer.invalidate()
      
      let alertController = UIAlertController(title: "終了", message: "タイマー終了です", preferredStyle: .alert)
      
      let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      
      alertController.addAction(defaultAction)
      
      present(alertController, animated: true, completion: nil)
      
    }
    
  }
  override func viewDidAppear(_ animated: Bool) {
   count = 0
    
    _ = displayUpdate()
  }
  
}

