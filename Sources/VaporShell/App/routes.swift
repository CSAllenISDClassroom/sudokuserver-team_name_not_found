import Vapor
import Foundation

var boards = [Board]()
let encoder = JSONEncoder()

struct ResponseData : Content {
    var action: String
    var payload: String
    var response: String
    var statusCode: String
    }

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req in
        return "Hello, world!"
    }

    //returns ID for a new board
    app.post("games") { req -> String in
        boards.append(Board(difficulty:4))

        return "{\"id\": \(boards.count-1)}"
    }.description("201 Created")

    //returns cells from given id in json format
    app.get("games", ":id", "cells") { req -> String in
        guard let id = req.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest, reason: ("Your ID does not consist of only numbers."))
        }
        if id >= boards.count {
            throw Abort(.badRequest, reason: ("This ID has not been created yet."))
        }
        guard let data = try? encoder.encode(boards[id]),
              let json = String(data: data, encoding: .utf8) else {
            fatalError("Failed to encode data into json.")
        }
        return "\(json)"
    }.description("200 OK")

    //places specified value at given cellIndex and boxIndex
    app.put("games", ":id", "cells", ":cellIndex", ":boxIndex", ":value") { req -> String in
        guard let id = req.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest, reason: ("The ID you entered does not exist."))
        }
        guard let y = req.parameters.get("cellIndex", as: Int.self) else {
            throw Abort(.badRequest, reason: ("cellIndex is out of range 0 ... 8"))
        }
        guard let x = req.parameters.get("boxIndex", as: Int.self) else {
            throw Abort(.badRequest, reason: ("boxIndex is out of range 0 ... 8"))
        }
        guard let value = req.parameters.get("value", as: Int.self) else {
            throw Abort(.badRequest, reason: ("value must be an integer"))
        }
        if y > 8 || y < 0 || x > 8 || x < 0 || value > 9 || value < 1 {
            throw Abort(.badRequest, reason: ("value is out of range 1 ... 9 or null"))
        }
        if id >= boards.count {
            throw Abort(.badRequest, reason: ("This ID has not been created yet."))
        }
        
        return ""
    }.description("200 OK")
}
/* this isn't needed right now, it should return a boolean once we add it back
func testBoard(_ board: Board) -> String {
    var finishedBoard = ""
    for row in board.tiles   {
        let toIntArray = createIntegerArray(row)
        let valid = board.isArrayValid(toIntArray)
        finishedBoard += "\(row)"
    }
    return finishedBoard
}
 */

/*
let board = Board()

func createIntegerArray(_ array: [Character]) -> [Int] {
    var intArray = [Int]()
    for char in array {
        let toString = String(char)
        guard let toInt = Int(toString) else {
            print("Error: Cannot Cast \(toString) to an integer")
            return intArray
        }
        intArray.append(toInt)
    }
    return intArray
}
 */
