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

    @IBOutlet weak var dropZone: UIView!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet var pan: UIPanGestureRecognizer!
    
    @IBOutlet var tap: UITapGestureRecognizer!
    
    @IBOutlet weak var label: UILabel!
 
    
    var startPoint:CGPoint!
    var endPoint:CGPoint!
    
    @IBAction func panGes(_ sender: UIPanGestureRecognizer) {
        let state = sender.state
        if state == .began {
            // タップ開始座標
            let tapLocation = sender.location(in: textView)
            print("tapPoint=\(tapLocation)")
            // 行の場所
            let position = textView.closestPosition(to: tapLocation)
            print("tapPosition=\(position)")
            if position != nil {
                // 範囲選択
                let range = textView.tokenizer.rangeEnclosingPosition(position!, with: UITextGranularity.line, inDirection: 1)
                if range != nil
                {
                    // 抽出
                    let word = textView.text(in: range!)
                    print("tapped line : \(word)")
                    if ((word?.range(of: ":")) != nil) {
                        let array = word?.components(separatedBy: ":")
                        print("tapped word : ",array![0])
                        label.text = (array?[0])
                    } else {
                        sender.isEnabled = false
                        sender.isEnabled = true
                        self.label.isHidden = true
                    }
                }
            }
            // label の開始位置の中心座標
            startPoint = sender.location(in: self.view)
            label.center = startPoint
            print("startPoint=\(startPoint)")
        
           // ラベルを可視化
            self.label.isHidden = false
  
        }
        // ドラッグ中
        if state == .changed {
            // 移動距離
            let translation = sender.translation(in: self.view)
            print("state=\(state.rawValue) translation=\(translation)")
            //ドラッグした部品の座標に移動量を加算する。
            label.center = sender.location(in: self.view)
        }
  
        if state == .ended {
            endPoint = sender.view!.center
            print("lastPoint=\(endPoint)")
            let dropZoneRect = dropZone.frame
            if dropZoneRect.contains(label.center) {
                print("drag -> OK")
            }else {
                print("drag -> NO")
            }
            self.label.isHidden = true
        }
        let strx = "sender.view!.center.x"
        let stry = "sender.view!.center.y"
        print("%@", strx);
        print("%@", stry);


    }
}

