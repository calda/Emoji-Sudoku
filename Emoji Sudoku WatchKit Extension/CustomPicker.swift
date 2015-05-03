//
//  CustomPicker.swift
//  Emoji Sudoku
//
//  Created by Cal on 5/3/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import Foundation
import WatchKit

class CustomPicker: WKInterfaceController {
    
    var main : CustomMain?
    let emojiMap = [
        ["😎", "❤️", "🔥", "🎉"],
        ["✌️", "💩", "😈", "😇"],
        ["💯", "🇺🇸", "😍", "❄️"],
        ["😂", "😏", "🍕", "👯"],
        ["💀", "👾", "🐔", "🌚"],
        ["🍆", "🌎", "🍑", "💔"],
        ["🚙", "🔮", "🙌", "😘"],
    ]
    
    override func awakeWithContext(context: AnyObject?) {
        main = (context as! CustomMain)
        super.awakeWithContext(context)
    }
    
    func processTap(col: Int, _ row: Int) {
        let selectedEmoji = emojiMap[col][row]
        
        let otherEmojis = [EMOJI_1, EMOJI_2, EMOJI_3, EMOJI_4]
        var isNewToSet = true
        for other in otherEmojis {
            if other == selectedEmoji {
                isNewToSet = false
            }
        }
        
        if isNewToSet {
            if main!.selectedEmoji! == .One {
                EMOJI_1 = selectedEmoji
            } else if main!.selectedEmoji! == .Two {
                EMOJI_2 = selectedEmoji
            } else if main!.selectedEmoji! == .Three {
                EMOJI_3 = selectedEmoji
            } else if main!.selectedEmoji! == .Four {
                EMOJI_4 = selectedEmoji
            }
        }
        
        main!.dismissController()
        
    }
    
    @IBAction func pressed00() {
        processTap(0, 0)
    }
    
    @IBAction func pressed01() {
        processTap(0, 1)
    }
    
    @IBAction func pressed02() {
        processTap(0, 2)
    }
    
    @IBAction func pressed03() {
        processTap(0, 3)
    }
    
    @IBAction func pressed10() {
        processTap(1, 0)
    }
    
    @IBAction func pressed11() {
        processTap(1, 1)
    }
    
    @IBAction func pressed12() {
        processTap(1, 2)
    }
    
    @IBAction func pressed13() {
        processTap(1, 3)
    }
    
    @IBAction func pressed20() {
        processTap(2, 0)
    }
    
    @IBAction func pressed21() {
        processTap(2, 1)
    }
    
    @IBAction func pressed22() {
        processTap(2, 2)
    }
    
    @IBAction func pressed23() {
        processTap(2, 3)
    }
    
    @IBAction func pressed30() {
        processTap(3, 0)
    }
    
    @IBAction func pressed31() {
        processTap(3, 1)
    }
    
    @IBAction func pressed32() {
        processTap(3, 2)
    }
    
    @IBAction func pressed33() {
        processTap(3, 3)
    }
    
    @IBAction func pressed40() {
        processTap(4, 0)
    }
    
    @IBAction func pressed41() {
        processTap(4, 1)
    }
    
    @IBAction func pressed42() {
        processTap(4, 2)
    }
    
    @IBAction func pressed43() {
        processTap(4, 3)
    }
    
    @IBAction func pressed50() {
        processTap(5, 0)
    }
    
    @IBAction func pressed51() {
        processTap(5, 1)
    }
    
    @IBAction func pressed52() {
        processTap(5, 2)
    }
    
    @IBAction func pressed53() {
        processTap(5, 3)
    }
    
    @IBAction func pressed60() {
        processTap(6, 0)
    }
    
    @IBAction func pressed61() {
        processTap(6, 1)
    }
    
    @IBAction func pressed62() {
        processTap(6, 2)
    }
    
    @IBAction func pressed63() {
        processTap(6, 3)
    }
    
}
