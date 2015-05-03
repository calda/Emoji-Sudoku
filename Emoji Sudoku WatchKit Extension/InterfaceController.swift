//
//  InterfaceController.swift
//  Emoji Sudoku WatchKit Extension
//
//  Created by Cal on 5/2/15.
//  Copyright (c) 2015 Cal Stephens. All rights reserved.
//

import WatchKit
import Foundation

var EMOJI_1 = "😎"
var EMOJI_2 = "❤️"
var EMOJI_3 = "🔥"
var EMOJI_4 = "🎉"

class InterfaceController: WKInterfaceController {
    
    // MARK: buttons
    @IBOutlet weak var b00: WKInterfaceButton!
    @IBOutlet weak var b01: WKInterfaceButton!
    @IBOutlet weak var b02: WKInterfaceButton!
    @IBOutlet weak var b03: WKInterfaceButton!
    @IBOutlet weak var b10: WKInterfaceButton!
    @IBOutlet weak var b11: WKInterfaceButton!
    @IBOutlet weak var b12: WKInterfaceButton!
    @IBOutlet weak var b13: WKInterfaceButton!
    @IBOutlet weak var b20: WKInterfaceButton!
    @IBOutlet weak var b21: WKInterfaceButton!
    @IBOutlet weak var b22: WKInterfaceButton!
    @IBOutlet weak var b23: WKInterfaceButton!
    @IBOutlet weak var b30: WKInterfaceButton!
    @IBOutlet weak var b31: WKInterfaceButton!
    @IBOutlet weak var b32: WKInterfaceButton!
    @IBOutlet weak var b33: WKInterfaceButton!
    
    var buttonMap : [[WKInterfaceButton?]] = [[nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, nil, nil], [nil, nil, nil, nil]]
    var sudokuCells : [[String]] = [["", "", "", ""], ["", "", "", ""], ["", "", "", ""], ["", "", "", ""]]
    
    var selectedCell = (0, 0)
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    func processTap(col: Int, _ row: Int) {
        println("(\(col), \(row))")
        selectedCell = (col, row)
        self.presentControllerWithName("picker", context: self)
    }
    
    override func willActivate() {
        buttonMap[0][0] = b00
        buttonMap[0][1] = b01
        buttonMap[0][2] = b02
        buttonMap[0][3] = b03
        buttonMap[1][0] = b10
        buttonMap[1][1] = b11
        buttonMap[1][2] = b12
        buttonMap[1][3] = b13
        buttonMap[2][0] = b20
        buttonMap[2][1] = b21
        buttonMap[2][2] = b22
        buttonMap[2][3] = b23
        buttonMap[3][0] = b30
        buttonMap[3][1] = b31
        buttonMap[3][2] = b32
        buttonMap[3][3] = b33
        //sometimes you just really have to embrace WatchKit
        
        super.willActivate()
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
    
}
























