//
//  VictoryScreen.swift
//  Emoji Sudoku
//
//  Created by Cal on 5/3/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import Foundation
import WatchKit

class VictoryScreen : WKInterfaceController {
    
    @IBOutlet weak var timeLabel: WKInterfaceLabel!
    @IBOutlet weak var emojisLabel: WKInterfaceLabel!
    
    var main : InterfaceController?
    
    override func awakeWithContext(context: AnyObject?) {
        main = (context as! InterfaceController)
        
        let startTime = main!.startTime!
        let elapsed = NSDate().timeIntervalSinceDate(startTime)
        let durationSeconds = Int(elapsed)
        
        let printMinutes : Int = durationSeconds / 60
        let printSeconds : Int = durationSeconds % 60
        timeLabel.setText("You Won in\n\(printMinutes) min \(printSeconds) sec")
    }
    
    override func willActivate() {
        let emojiText = Emoji.One.getString() + Emoji.Two.getString() + Emoji.Three.getString() + Emoji.Four.getString()
        emojisLabel.setText(emojiText)
    }
    
    @IBAction func playAgain() {
        main!.restart()
        main!.dismissController()
    }
    
    @IBAction func customize() {
        self.presentControllerWithName("customize", context: self)
    }
}