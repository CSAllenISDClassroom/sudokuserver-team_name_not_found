import Foundation

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

    func isValid(_ number:Int) -> Bool {
        return number >= 1 && number <= 9
    }

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
        }
    }
}