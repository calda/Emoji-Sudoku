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

enum Emoji {
    case One, Two, Three, Four
    
    func getString() -> String {
        switch(self) {
            case .One: return EMOJI_1
            case .Two: return EMOJI_2
            case .Three: return EMOJI_3
            case .Four: return EMOJI_4
        }
    }
    
    func getID() -> Int {
        switch(self) {
        case .One: return 1
        case .Two: return 2
        case .Three: return 3
        case .Four: return 4
        }
    }
    
    static func getEmojiConstant(string: String) -> Emoji {
        switch(string) {
            case EMOJI_1: return .One
            case EMOJI_2: return .Two
            case EMOJI_3: return .Three
            default: return .Four
        }
    }
    
    func inArrayOnce(array: [Emoji?]) -> Bool {
        var count = 0
        for emoji in array {
            if let emoji = emoji {
                if emoji == self {
                    count++
                }
            }
        }
        return count == 1
    }
}

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
    var cell : [[SudokuCell]] = [
        [SudokuCell(1), SudokuCell(1), SudokuCell(2), SudokuCell(2)],
        [SudokuCell(1), SudokuCell(1), SudokuCell(2), SudokuCell(2)],
        [SudokuCell(3), SudokuCell(3), SudokuCell(4), SudokuCell(4)],
        [SudokuCell(3), SudokuCell(3), SudokuCell(4), SudokuCell(4)]]
    
    var selectedCell = (0, 0)
    var startTime : NSDate?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    func processTap(col: Int, _ row: Int) {
        println("(\(col), \(row))")
        selectedCell = (col, row)
        if cell[col][row].revealed {
            cell[col][row].pingNoOnButton(buttonMap[col][row]!)
            return
        }
        cell[col][row].setSelectedOnButton(buttonMap[col][row]!)
        self.presentControllerWithName("picker", context: self)
    }
    
    override func willActivate() {
        if buttonMap[0][0] == nil {
            //sometimes you just really have to embrace WatchKit
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
            populateWithSolution()
            
            //pull custom emoji data from iCloud
            let store = NSUbiquitousKeyValueStore.defaultStore()
            store.synchronize()
            if store.stringForKey("EMOJI_1") == nil {
                store.setString("😎", forKey: "EMOJI_1")
                store.setString("❤️", forKey: "EMOJI_2")
                store.setString("🔥", forKey: "EMOJI_3")
                store.setString("🎉", forKey: "EMOJI_4")
            }
            else {
                EMOJI_1 = store.stringForKey("EMOJI_1")!
                EMOJI_2 = store.stringForKey("EMOJI_2")!
                EMOJI_3 = store.stringForKey("EMOJI_3")!
                EMOJI_4 = store.stringForKey("EMOJI_4")!
            }
        }
        
        for row in 0...3 {
            for col in 0...3 {
                cell[row][col].renderOnButton(buttonMap[row][col]!)
            }
        }
        
        if validateGrid() {
            //set all green
            for row in 0...3 {
                for col in 0...3 {
                    cell[row][col].setVictoryOnButton(buttonMap[row][col]!)
                }
            }
            
            //wait a sec and then show victory screen
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), {
                self.presentControllerWithName("victory", context: self)
            })
        }

        super.willActivate()
    }
    
    
    func populateWithSolution() {
        startTime = NSDate()
        
        func randomEmojiExcluding(exclude: [SudokuCell]) -> Emoji {
            var allEmoji : [Emoji] = [.One, .Two, .Three, .Four]
            for cell in exclude {
                for i in 0..<allEmoji.count {
                    if allEmoji[i] == cell.solutionEmoji! {
                        allEmoji.removeAtIndex(i)
                        break
                    }
                }
            }
            if allEmoji.count == 1 {
                return allEmoji[0]
            }
            
            let random = Int(arc4random_uniform(UInt32(allEmoji.count - 1)))
            return allEmoji[random]
        }
        
        func doFor(cell: SudokuCell, #exclude: [SudokuCell]) -> Emoji {
            let random = randomEmojiExcluding(exclude)
            cell.solutionEmoji = random
            return random
        }
        
        //populate
        
        doFor(cell[0][0], exclude: [])
        doFor(cell[0][1], exclude: [cell[0][0]])
        doFor(cell[1][0], exclude: [cell[0][0], cell[0][1]])
        doFor(cell[1][1], exclude: [cell[0][0], cell[0][1], cell[1][0]])
        
        doFor(cell[0][2], exclude: [cell[0][0], cell[0][1]])
        doFor(cell[0][3], exclude: [cell[0][0], cell[0][1], cell[0][2]])
        doFor(cell[1][2], exclude: [cell[1][0], cell[1][1]])
        doFor(cell[1][3], exclude: [cell[1][0], cell[1][1], cell[1][2]])
        
        doFor(cell[2][0], exclude: [cell[0][0], cell[1][0]])
        doFor(cell[3][0], exclude: [cell[0][0], cell[1][0], cell[2][0]])
        doFor(cell[2][1], exclude: [cell[0][1], cell[1][1]])
        doFor(cell[3][1], exclude: [cell[0][1], cell[1][1], cell[2][1]])
        
        doFor(cell[2][2], exclude: [cell[2][0], cell[2][1], cell[0][2], cell[1][2]])
        doFor(cell[3][3], exclude: [cell[3][0], cell[3][1], cell[0][3], cell[1][3]])
        doFor(cell[2][3], exclude: [cell[2][0], cell[2][1], cell[2][2]])
        doFor(cell[3][2], exclude: [cell[3][0], cell[3][1], cell[3][3]])
        
        //reveal six random cells
        
        var allCells : [SudokuCell] = []
        for row in 0...3 {
            for col in 0...3 {
                allCells.append(cell[col][row])
            }
        }
        
        for _ in 0...5 {
            let reveal = Int(arc4random_uniform(UInt32(allCells.count - 1)))
            allCells[reveal].revealed = true
            allCells[reveal].emoji = allCells[reveal].solutionEmoji
            allCells.removeAtIndex(reveal)
        }
        
        if !validateSolution() {
            restart()
        }
        
    }
    
    
    func validateGrid() -> Bool {
        //validate columns
        for col in 0...3 {
            
            var colGroup : [Emoji?] = []
            for row in 0...3 {
                colGroup.append(cell[col][row].emoji)
            }
            if !groupIsValid(colGroup) {
                return false
            }
            
        }
        
        //validate rows
        for row in 0...3 {
            
            var rowGroup : [Emoji?] = []
            for col in 0...3 {
                rowGroup.append(cell[col][row].emoji)
            }
            if !groupIsValid(rowGroup) {
                return false
            }
            
        }
        
        //validate quads
        let cornerCells : [(Int, Int)] = [(0, 0), (0, 2), (2, 0), (2, 2)]
        for cornerCell in cornerCells {
            
            var quadCells : [Emoji?] = []
            for x in 0...1 {
                for y in 0...1 {
                    let col = cornerCell.0 + x
                    let row = cornerCell.1 + y
                    quadCells.append(cell[col][row].emoji)
                }
            }
            if !groupIsValid(quadCells) {
                return false
            }
        }
        
        return true
    }
    
    //duplicated because I'm lazy OOPS
    func validateSolution() -> Bool {
        //validate columns
        for col in 0...3 {
            
            var colGroup : [Emoji?] = []
            for row in 0...3 {
                colGroup.append(cell[col][row].solutionEmoji)
            }
            if !groupIsValid(colGroup) {
                return false
            }
            
        }
        
        //validate rows
        for row in 0...3 {
            
            var rowGroup : [Emoji?] = []
            for col in 0...3 {
                rowGroup.append(cell[col][row].solutionEmoji)
            }
            if !groupIsValid(rowGroup) {
                return false
            }
            
        }
        
        //validate quads
        let cornerCells : [(Int, Int)] = [(0, 0), (0, 2), (2, 0), (2, 2)]
        for cornerCell in cornerCells {
            
            var quadCells : [Emoji?] = []
            for x in 0...1 {
                for y in 0...1 {
                    let col = cornerCell.0 + x
                    let row = cornerCell.1 + y
                    quadCells.append(cell[col][row].solutionEmoji)
                }
            }
            if !groupIsValid(quadCells) {
                return false
            }
        }
        
        return true
    }
    
    
    func groupIsValid(group: [Emoji?]) -> Bool {
        if group.count != 4 { return false }
        let one = Emoji.One.inArrayOnce(group)
        let two = Emoji.Two.inArrayOnce(group)
        let three = Emoji.Three.inArrayOnce(group)
        let four = Emoji.Four.inArrayOnce(group)
        return one && two && three && four
    }
    
    
    @IBAction func restart() {
        cell = [
        [SudokuCell(1), SudokuCell(1), SudokuCell(2), SudokuCell(2)],
        [SudokuCell(1), SudokuCell(1), SudokuCell(2), SudokuCell(2)],
        [SudokuCell(3), SudokuCell(3), SudokuCell(4), SudokuCell(4)],
        [SudokuCell(3), SudokuCell(3), SudokuCell(4), SudokuCell(4)]]
        
        populateWithSolution()
        
        for row in 0...3 {
            for col in 0...3 {
                cell[row][col].renderOnButton(buttonMap[row][col]!)
            }
        }
        
    }
    
    @IBAction func presentCustomizeController() {
        self.presentControllerWithName("customize", context: self)
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
























