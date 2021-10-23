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
    var value: Int?
}
struct Row: Codable {
    var cells: [Cell]

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

    init(difficulty:Int) { //difficulty needs to be 1-4 (easy, normal, hard, hell)
        var board = [Row]()
        for cellIndex in 0 ..< 9 {
            board.append(Row(cellIndex:cellIndex))
        }
        //copy cells from oldBoard
        let oldBoard = OldBoard(difficulty:difficulty)

        for y in 0 ..< oldBoard.tiles.count {
            for x in 0 ..< oldBoard.tiles[y].count {
                let value = Int("\(oldBoard.tiles[y][x])")
                board[y].cells[x].value = value
            }
        }
        
        self.board = board
    }
}

// old code, using this to generate new board
//it's not efficient but it works!
//"be as lazy as possible" -Professor David Ben-Yakkov
public class OldBoard {

    public var tiles: [[Int]] = [[Int]]()

    init(difficulty:Int) {
        //creates a valid sudoku board
        let offsets = [0, 3, 6, 1, 4, 7, 2, 5, 8]
        for y in 0 ..< 9 {
            tiles.append([Int]())
            for x in 0 ..< 9 {
                var tileValue = x + 1 + offsets[y]
                while tileValue > 9 {
                    tileValue -= 9
                }
                tiles[y].append(tileValue)
            }
        }

        //randomize the board
        var characters : [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        characters.shuffle()
        for y in 0 ..< tiles.count {
            for x in 0 ..< tiles[y].count {
                if Int.random(in:1...10) > 0 + 2*difficulty {
                    switch tiles[y][x] {
                    case 1:
                        tiles[y][x] = characters[0]
                    case 2:
                        tiles[y][x] = characters[1]
                    case 3:
                        tiles[y][x] = characters[2]
                    case 4:
                        tiles[y][x] = characters[3]
                    case 5:
                        tiles[y][x] = characters[4]
                    case 6:
                        tiles[y][x] = characters[5]
                    case 7:
                        tiles[y][x] = characters[6]
                    case 8:
                        tiles[y][x] = characters[7]
                    case 9:
                        tiles[y][x] = characters[8]
                    default:
                        fatalError("invalid character found in Board")
                    }
                } else {
                    tiles[y][x] = 0
                }
            }
            
        } 
    }
}


/*let falseBoard = Board()
falseBoard.tiles = [[Board.Constants.two, Board.Constants.four, Board.Constants.six, Board.Constants.eight]]

testBoard(falseBoard)
*/
//test

//testBoard(board)
