//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 松永知典 on 2017/07/26.
//  Copyright © 2017年 kazunori.matsunaga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var playpauseButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func onTapImage(_ sender: Any) {
        // セグエを使用して画面を遷移
        performSegue(withIdentifier: "result", sender: nil)
        
        playpauseButton.setTitle("再生", for: .normal)
        backButton.isEnabled = true
        goButton.isEnabled = true
    }
    
    // タイマー用の時間のための変数
    var timer: Timer!
    var timer_sec: Int = 0
    
    var temp = 0 //一時的に数値を格納する変数
    var counter: Int = 0 //写真のインデックス番号
    let second: Int = 2 // 次の写真を表示するまでの秒数
    
    //写真3枚を格納する配列
    let photograph = [UIImage(named: "IMG_5961"),UIImage(named: "IMG_6757"),UIImage(named: "IMG_6267")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //最初は0枚目を表示しておく
        imageView.image = photograph[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //timeIntervalごとに呼び出される関数
    //timer_secを+0.1して、timerLavelに反映させるだけの関数
    func updateTimer(timer: Timer) {
        self.timer_sec += 1
        self.timerLabel.text = String(format: "%d", timer_sec)
        
        if(timer_sec >= 0) {
            temp = timer_sec % second
            if( temp == 0 ) {
                if(counter < 2) {
                    counter += 1
                    imageView.image = photograph[counter]
                }else{
                    counter = 0
                    imageView.image = photograph[counter]
                }
            }
        }
    }

    @IBAction func playButton(_ sender: Any) {
        //タイマーの作成、始動
        //timeIntervalについて、更新用関数が1secごとに更新される
        //targetについて、更新用関数が定義されるクラスをselfとし、そのselfは「自分自身」なので、自分自身（Timer.schedeleTimer()）の呼び出し元であるViewcontroller.swiftを指定したことになる
        //selectorについて、targetがselfなので、ViewContoroler.swiftに更新用関数が作られる。その名はupdatetimerで、timeintervalごとに呼び出される。
        //userinfoはtimerとして渡したい値
        //repeatは、trueとしているので、1びょうごとに呼び出される
        if self.timer == nil {
            //再生する
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            playpauseButton.setTitle("停止", for: .normal)
            backButton.isEnabled = false
            goButton.isEnabled = false
        }else{
            //停止する
            self.timer.invalidate()
            //現在のタイマーを破棄
            self.timer = nil
            playpauseButton.setTitle("再生", for: .normal)
            backButton.isEnabled = true
            goButton.isEnabled = true
        }
    }

    @IBAction func prevButton(_ sender: Any) {
        //停止を押すと、タイマーの時間を0に
        self.timer_sec = 0
        self.timerLabel.text = String(format: "%d", self.timer_sec)
        
        if self.timer != nil {
            self.timer.invalidate()
            //現在のタイマーを破棄
            self.timer = nil
        }
        
        if(counter > 0) {
            counter -= 1
            imageView.image = photograph[counter]
        }else{
            counter = 2
            imageView.image = photograph[counter]
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        //停止を押すと、タイマーの時間を0に
        self.timer_sec = 0
        self.timerLabel.text = String(format: "%d", self.timer_sec)
        
        if self.timer != nil {
            self.timer.invalidate()
            //現在のタイマーを破棄
            self.timer = nil
        }
        
        if(counter < 2) {
            counter += 1
            imageView.image = photograph[counter]
        }else{
            counter = 0
            imageView.image = photograph[counter]
        }
    }
    
    //@IBAction func pauseButton(_ sender: Any) {
        //停止を押すと、タイマーの時間を0に
      //  self.timer_sec = 0
        //self.timerLabel.text = String(format: "%d", self.timer_sec)
        
       // if self.timer != nil {
         //   self.timer.invalidate()
            //現在のタイマーを破棄
           // self.timer = nil
       // }
   // }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //停止を押すと、タイマーの時間を0に
        self.timer_sec = 0
        self.timerLabel.text = String(format: "%d", self.timer_sec)
        
        if self.timer != nil {
            self.timer.invalidate()
            //現在のタイマーを破棄
            self.timer = nil
        }

        // segueから遷移先のResultViewControllerを取得する
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        // 遷移先のResultViewControllerで宣言しているindexに値を代入して渡す
        resultViewController.index = counter
    }

    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
}

