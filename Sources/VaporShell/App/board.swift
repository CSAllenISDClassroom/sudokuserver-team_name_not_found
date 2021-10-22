// Program by Garrett Fundis, Enzo Norton-Mitchell, William Jackson, Samuel Steele





/*

 Task 1: Printing layout correctly
   // Subs-square visual seapartions of a 9x9 into 3

 Task 2: Valitdation
   // Row iteration: 1 - 9 only
   // Column iteration: 1 - 9 only
   // 3x3 subsquare: 1- 9 only

*/

/*

 For Loops & Control Flows
  https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html
  https://www.avanderlee.com/swift/loops-swift/
  https://learnappmaking.com/swift-where-how-to/

 Collections
  https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html

 Set Documentation
  https://developer.apple.com/documentation/swift/set

*/

import Foundation
//codermerlin.com/wiki/index.php/W3911_Sudoku_Server
struct Position: Codable {
    let boxIndex: Int
    let cellIndex: Int
}

struct Cell: Codable {
    let position: Position
    let value: Int?
}
struct Row: Codable {
    let cells: [Cell]

    init(cellIndex: Int) {
        var cells = [Cell]()
        for boxIndex in 0 ..< 9 {
            cells.append(Cell(position: Position(boxIndex:boxIndex, cellIndex:cellIndex), value: boxIndex+1)) //it kinda works but we need to make a valid board
        }
        self.cells = cells
    }
}

struct Board: Codable {
    let board: [Row]

    init() {
        var board = [Row]()
        for cellIndex in 0 ..< 9 {
            board.append(Row(cellIndex:cellIndex))
        }
        self.board = board
    }
}
//end sponsorship

/* old code, use for reference i guess
public class Board {

    struct Constants {
        static let one: Character =   "1"
        static let two: Character =   "2"
        static let three: Character = "3"
        static let four: Character =  "4"
        static let five: Character =  "5"
        static let six:  Character =  "6"
        static let seven: Character = "7"
        static let eight: Character = "8"
        static let nine: Character =  "9"
    }

    public var tiles: [[Character]] = [[Character]]()


    public func isArrayValid(_ numbers: [Int]) -> Bool {
        // Only unqiue and valid #s
        return hasValidNumbers(numbers) && onlyUniqueNumbers(numbers)
    }

    // TODO handle processing character number
    func hasValidNumbers(_ numbers: [Int]) -> Bool {
        // Assuming tiles is populated

        // Loop through every number in "row" checking to see if it is oneToNine“
        for value in numbers where isValid(value) != true {
            return false // If not return false
        }
        return true
    }

    func onlyUniqueNumbers(_ numbers: [Int]) -> Bool {
        // Assuming tiles is populated
        // Row iteration: 1 - 9 only - for
        var alreadySeen = Set<Int>()

        // Check 1.5: Make sure there are no repeating nubers
        for value in numbers {
            if alreadySeen.contains(value) {
                // Value is not unqiue / a value repeated in the row
                return false
            }
            else {
                // Value is unquie up this point in the array
                alreadySeen.insert(value)
            }
        }
        return true
    }


    // Check 1: Make sure its within the range (1 - 9)
    func isValid(_ number: Int) -> Bool {
        return number >= 1 && number <= 9
    }

    init() {
        //creates a valid sudoku board
        let offsets = [0, 3, 6, 1, 4, 7, 2, 5, 8]
        for y in 0 ..< 9 {
            tiles.append([Character]())
            for x in 0 ..< 9 {
                var tileValue = x + 1 + offsets[y]
                while tileValue > 9 {
                    tileValue -= 9
                }
                tiles[y].append(Character("\(tileValue)"))
            }
        }

       //randomize the board
        var characters : [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        characters.shuffle()
        for y in 0 ..< tiles.count {
            for x in 0 ..< tiles[y].count {
                //if Int.random(in:1...10) > 7 {
                switch tiles[y][x] {
                case "1":
                    tiles[y][x] = characters[0]
                case "2":
                    tiles[y][x] = characters[1]
                case "3":
                    tiles[y][x] = characters[2]
                case "4":
                    tiles[y][x] = characters[3]
                case "5":
                    tiles[y][x] = characters[4]
                case "6":
                    tiles[y][x] = characters[5]
                case "7":
                    tiles[y][x] = characters[6]
                case "8":
                    tiles[y][x] = characters[7]
                case "9":
                    tiles[y][x] = characters[8]
                default:
                    fatalError("invalid character found in Board")
                }
            }
            // else {
            //   tiles[y][x] = " "
            //}
        }
        
    } 
}
*/


/*let falseBoard = Board()
falseBoard.tiles = [[Board.Constants.two, Board.Constants.four, Board.Constants.six, Board.Constants.eight]]

testBoard(falseBoard)
*/
//test

//testBoard(board)
 





//In Progress (In the process of creating a random array using the randomElement()! that works with tiles.)

//randomize the board

/*
 var characters : [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"] 
        guard characters.count > 0 else {
            return
        }
        let randomNumber = characters.randomNumber()!
        for y in 0 ..< tiles.count {
            for x in 0 ..< tiles[y].count {
                //if Int.random(in:1...10) > 7 {
                switch tiles[y][x] {
                case "1":
                    tiles[y][x] = randomNumber[0]
                case "2":
                    tiles[y][x] = randomNumber[1]
                case "3":
                    tiles[y][x] = randomNumber[2]
                case "4":
                    tiles[y][x] = randomNumber[3]
                case "5":
                    tiles[y][x] = randomNumber[4]
                case "6":
                    tiles[y][x] = randomNumber[5]
                case "7":
                    tiles[y][x] = randomNumber[6]
                case "8":
                    tiles[y][x] = randomNumber[7]
                case "9":
                    tiles[y][x] = randomNumber[8]
                default:
                    fatalError("invalid character found in Board")
                }
            }
            // else {
            //   tiles[y][x] = " "
            //}
        }
    }

*/
