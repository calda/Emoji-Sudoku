//
//  EmojiPicker.swift
//  Emoji Sudoku
//
//  Created by Cal on 5/3/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import Foundation
import WatchKit

class CustomMain : WKInterfaceController {
    
    @IBOutlet weak var button1: WKInterfaceButton!
    @IBOutlet weak var button2: WKInterfaceButton!
    @IBOutlet weak var button3: WKInterfaceButton!
    @IBOutlet weak var button4: WKInterfaceButton!
    
    var selectedEmoji : Emoji?
    
    override func willActivate() {
        super.willActivate()
        
        button1.setTitle(EMOJI_1)
        button2.setTitle(EMOJI_2)
        button3.setTitle(EMOJI_3)
        button4.setTitle(EMOJI_4)
    }
    
    func pressed(emoji: Emoji) {
        selectedEmoji = emoji
        self.presentControllerWithName("customPicker", context: self)
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