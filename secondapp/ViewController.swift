//
//  ViewController.swift
//  secondapp
//
//  Created by oliver on 2018/11/11.
//  Copyright © 2018 oliver wong. All rights reserved.
//

import UIKit
import GameKit
import AVFoundation


class ViewController: UIViewController {
    
    
    var answer=GKRandomSource.sharedRandom().nextInt(upperBound: 100)+1
    
    var maxnumber=100
    var minnumber=1
    var overgame=false
    var audioPlayerstart:AVAudioPlayer?
    var audioPayerend:AVAudioPlayer?
    
    @IBOutlet weak var messagelabel: UILabel!
    
    @IBOutlet weak var inputtextfield: UITextField!
    
    @IBOutlet weak var background: UIImageView!
    
    

    
    @IBAction func makeaguess(_ sender: UIButton) {
        
        if overgame==false{
                        let inputText=inputtextfield.text!
            inputtextfield.text=""
            let inputNumber=Int(inputText)
            if inputNumber==nil{
                messagelabel.text="輸入錯誤"
            }else{
                if inputNumber!>maxnumber{
                    messagelabel.text="數字太大,數字範圍\(minnumber)~\(maxnumber)"
                }else if inputNumber!<minnumber{
                    messagelabel.text="數字太小,數字範圍\(minnumber)~\(maxnumber)"
                }else if inputNumber!==answer{
                    messagelabel.text="恭喜答對了,請按下Guess繼續遊戲"
                    overgame=true
                    background.image=UIImage(named: "Finish")
                    audioPlayerstart?.stop()
                    audioPayerend?.currentTime=41.0
                    audioPayerend?.play()
                }else{
                    if inputNumber!>answer{
                        maxnumber=inputNumber!
                    }else{
                        minnumber=inputNumber!
                    }
                    messagelabel.text="請再試一次,數字範圍\(minnumber)~\(maxnumber)"
                }
                
            }
            
        }else{
            maxnumber=100
            minnumber=1
            answer=GKRandomSource.sharedRandom().nextInt(upperBound: 100)+1
            messagelabel.text="請輸入一個數字,介於1~100之間"
            overgame=false
            background.image=UIImage(named: "BG")
            audioPayerend?.stop()
            audioPlayerstart?.currentTime=0.0
            audioPlayerstart?.play()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //讓鍵盤跳出來
        inputtextfield.becomeFirstResponder()
        if let pathstart=Bundle.main.path(forResource: "Right", ofType: "mp3"){
            let urlstart=URL(fileURLWithPath: pathstart)
            do{
                audioPlayerstart = try AVAudioPlayer(contentsOf: urlstart)
                audioPlayerstart?.numberOfLoops = -1
            }catch{
                
            }
            
        }
        if let pathend=Bundle.main.path(forResource: "End", ofType: "mp3"){
            let urlend=URL(fileURLWithPath: pathend)
            do{
                audioPayerend = try AVAudioPlayer(contentsOf: urlend)
                audioPayerend?.currentTime=41.0
                
                
            }catch{
                
            }
        }
        audioPlayerstart?.play()
        
    }


}

