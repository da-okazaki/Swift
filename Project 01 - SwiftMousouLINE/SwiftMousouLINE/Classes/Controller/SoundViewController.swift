//
//  SoundViewController.swift
//  SwiftMousouLINE
//
//  Created by 岡崎大地 on 2018/12/23.
//  Copyright © 2018 daichi okazaki. All rights reserved.
//

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK : - Import (インポート)

import AVFoundation
import UIKit

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK : - Implementation (実装)

class SoundViewController: UIViewController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK : - Properties (プロパティ)
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var onCallBackground: UIImageView!
    
    var audioPlayer : AVAudioPlayer!
    var countSecond = 0
    var countMin = 0
    var countHour = 0
    var countDate:String = "0"
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK : - Lifecycle (ライフサイクル)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ① Background not display
        onCallBackground.isHidden = true
        
        // ② Label not display.
        timeLabel.isHidden = true
        
        // ③ Music start. (callMusic.mp3)
        if let url = Bundle.main.url(forResource: "callMusic", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                // プレイヤー作成失敗
                // その場合は、プレイヤーはnilとする
                audioPlayer = nil
            }
        } else {
            // urlがnilなので再生できない
            fatalError("Url is nil.")
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK : - Action (アクション)
    
    @IBAction func startCallButton(_ sender: Any) {
        // ① Background on display.
        onCallBackground.isHidden = false
        
        // ② timeLabel on display.
        timeLabel.isHidden = false
        
        // ③ Timer start.
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCountUp), userInfo: nil, repeats: true)
        
        // ③ Music start. (SILENT_SIREN.mp3)
        playSoundMusic()

    }

    @IBAction func stopCallButton(_ sender: Any) {
        // ① Stop music.
        audioPlayer.stop()
        
        // ② Back to the screen.
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func stopCallButton2(_ sender: Any) {
        // ① Stop music.
        audioPlayer.stop()
        
        // ② Back to the screen.
        dismiss(animated: true, completion: nil)
    }
    
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK : - Method (メソッド)
    
    func playSoundMusic() {
        
        if let url = Bundle.main.url(forResource: "SILENT_SIREN", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                // プレイヤー作成失敗
                // その場合は、プレイヤーはnilとする
                audioPlayer = nil
            }
        } else {
            // urlがnilなので再生できない
            fatalError("Url is nil.")
        }
    }
    
    @objc func timerCountUp() {
        
        countSecond = countSecond + 1
        
        // 60s = 1m
        if countSecond == 60 {
            countSecond = 0
            countMin = countMin + 1
            
            // 60m = 1h
            if countMin == 60 {
                countMin = 0
                countHour = countHour + 1
            }
        }
        
        // 0:00:00 形式
        if countHour > 0 {
            countDate = String(countHour) + ":" + String(format: "%02d", countMin) + ":" + String(format: "%02d", countSecond)
        // 0:00 形式
        } else {
            countDate = String(countMin) + ":" + String(format: "%02d", countSecond)
        }
        timeLabel.text = String(countDate)
    }
}



