//
//  ViewController.swift
//  swifttest
//
//  Created by 後藤宗一朗 on 2018/11/05.
//  Copyright © 2018年 後藤宗一朗. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet var tap: UITapGestureRecognizer!
    
    @IBAction func tapGes(_ sender: UITapGestureRecognizer) {
        // 座標
        let location = sender.location(in: self.view)
        print("tapPoint=\(location)")
        // 行の場所
        let position = textView.closestPosition(to: location)
        print("tapPosition=\(position)")
        if position != nil {
            // 範囲洗濯
            let range = textView.tokenizer.rangeEnclosingPosition(position!, with: UITextGranularity.line, inDirection: 1)
            if range != nil
            {
                // 抽出
                let word = textView.text(in: range!)
                print("tapped word : ",word)
            }
        }

    }
}

