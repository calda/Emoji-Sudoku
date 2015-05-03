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
    
    func pressed(emoji: String) {
        println("notification posted")
        main!.selectedCell!.setTitle(emoji)
        self.dismissController()
    }
    
    @IBAction func pressed1() {
        pressed(EMOJI_1)
    }
    
    @IBAction func pressed2() {
        pressed(EMOJI_2)
    }
    
    @IBAction func pressed3() {
        pressed(EMOJI_3)
    }
    
    @IBAction func pressed4() {
        pressed(EMOJI_4)
    }
    
}