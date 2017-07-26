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
    
    @IBOutlet weak var imageView: UIImageView!
    
    // タイマー用の時間のための変数
    var timer: Timer!
    var timer_sec: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //timeIntervalごとに呼び出される関数
    //timer_secを+0.1して、timerLavelに反映させるだけの関数
    func updateTimer(timer: Timer) {
        self.timer_sec += 0.1
        self.timerLabel.text = String(format: "%.1f", timer_sec)
    }

    @IBAction func prevButton(_ sender: Any) {
    }
    
    @IBAction func playButton(_ sender: Any) {
        //タイマーの作成、始動
        //timeIntervalについて、更新用関数が0.1secごとに更新される
        //targetについて、更新用関数が定義されるクラスをselfとし、そのselfは「自分自身」なので、自分自身（Timer.schedeleTimer()）の呼び出し元であるViewcontroller.swiftを指定したことになる
        //selectorについて、targetがselfなので、ViewContoroler.swiftに更新用関数が作られる。その名はupdatetimerで、timeintervalごとに呼び出される。
        //userinfoはtimerとして渡したい値
        //repeatは、trueとしているので、0.1びょうごとに呼び出される
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        //停止を押すと、タイマーの時間を0に
        self.timer_sec = 0
        self.timerLabel.text = String(format: "%.1f", self.timer_sec)
        
        if self.timer != nil {
            self.timer.invalidate()
            //現在のタイマーを破棄
            self.timer = nil
        }
    }

    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
}

