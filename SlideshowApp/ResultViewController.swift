//
//  ResultViewController.swift
//  SlideshowApp
//
//  Created by 松永知典 on 2017/07/26.
//  Copyright © 2017年 kazunori.matsunaga. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var ExpandImageView: UIImageView!
    
    // 受け取るためのプロパティ（変数）を宣言しておく
    var index:Int = 0
    
    //写真3枚を格納する配列
    let photo = [UIImage(named: "IMG_5961"),UIImage(named: "IMG_6757"),UIImage(named: "IMG_6267")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ExpandImageView.image = photo[index]

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

}
