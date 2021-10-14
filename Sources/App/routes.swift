import Vapor
import Foundation

var boards = [Board]()
//json stuff
let board = Board()
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
        boards.append(Board())
        
        return "{\"id\": \(boards.count-1)}"
    }
    
    app.get("games", ":id", "cells") { req -> String in
        guard let id = req.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest)
        }
        if id >= boards.count {
            throw Abort(.badRequest)
        }
        guard let data = try? encoder.encode(board),
              let json = String(data: data, encoding: .utf8) else {
            fatalError("Failed to encode data into json.")
        }
        return "\(json)"
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
