import Vapor
import Foundation

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

    app.get("games", ":id", "cells") { req -> String in
        //guard let id = req.parameters.get("id", as: Int.self) else {
        //    throw Abort(.badRequest)
        //}
        return "\(testBoard(board))"
    }.description("200 OK")


}

func testBoard(_ board: Board) -> String {
    var finishedBoard = ""
    for row in board.tiles   {
        let toIntArray = createIntegerArray(row)
        let valid = board.isArrayValid(toIntArray)
        finishedBoard += "\(row): \(valid)"
    }
    return finishedBoard
}

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
