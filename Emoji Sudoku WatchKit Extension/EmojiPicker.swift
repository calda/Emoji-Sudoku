//
//  EmojiPicker.swift
//  Emoji Sudoku
//
//  Created by Cal on 5/3/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import Foundation
import WatchKit

class EmojiPicker : WKInterfaceController {
    
    @IBOutlet weak var button1: WKInterfaceButton!
    @IBOutlet weak var button2: WKInterfaceButton!
    @IBOutlet weak var button3: WKInterfaceButton!
    @IBOutlet weak var button4: WKInterfaceButton!
    
    var main : InterfaceController?
    
    override func awakeWithContext(context: AnyObject?) {
        main = (context as! InterfaceController)
    }
    
    override func willActivate() {
        super.willActivate()
        
        button1.setTitle(EMOJI_1)
        button2.setTitle(EMOJI_2)
        button3.setTitle(EMOJI_3)
        button4.setTitle(EMOJI_4)
    }
    
    func pressed(emoji: Emoji) {
        println("notification posted")
        main!.cell[main!.selectedCell.0][main!.selectedCell.1].emoji = emoji
        self.dismissController()
    }
    
    @IBAction func pressed1() {
        pressed(Emoji.One)
    }
    
    @IBAction func pressed2() {
        pressed(Emoji.Two)
    }
    
    @IBAction func pressed3() {
        pressed(Emoji.Three)
    }
    
    @IBAction func pressed4() {
        pressed(Emoji.Four)
    }
    
}