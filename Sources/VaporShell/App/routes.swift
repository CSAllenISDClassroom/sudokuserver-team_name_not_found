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
        guard let difficultyString = req.query[String.self, at: "difficulty"] else {
            throw Abort(.badRequest, reason: "Must specify difficulty (easy, medium, hard, hell)")
        }
        print("attempting to create board with difficulty \(difficultyString)")
        var difficulty : Int
        switch difficultyString {
        case "easy":
            difficulty = 1
        case "medium":
            difficulty = 2
        case "hard":
            difficulty = 3
        case "hell":
            difficulty = 4
        default:
            throw Abort(.badRequest, reason: "Difficulty must be easy, medium, hard, or hell")
        }
        boards.append(Board(difficulty:difficulty))

        print("created board with id \(boards.count-1) with a difficulty of \(difficultyString) (\(difficulty))")
        
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
    app.put("games", ":id", "cells", ":boxIndex", ":cellIndex", ":value") { req -> String in
        guard let id = req.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest, reason: ("The ID you entered does not exist."))
        }
        guard let cellIndex = req.parameters.get("cellIndex", as: Int.self) else {
            throw Abort(.badRequest, reason: ("cellIndex is out of range 0 ... 8"))
        }
        guard let boxIndex = req.parameters.get("boxIndex", as: Int.self) else {
            throw Abort(.badRequest, reason: ("boxIndex is out of range 0 ... 8"))
        }
        guard let value = req.parameters.get("value", as: Int.self) else {
            throw Abort(.badRequest, reason: ("value must be an integer"))
        }
        if boxIndex > 8 || boxIndex < 0 || cellIndex > 8 || cellIndex < 0 || value > 9 || value < 1 {
            throw Abort(.badRequest, reason: ("value is out of range 1 ... 9 or null"))
        }
        if id >= boards.count {
            throw Abort(.badRequest, reason: ("This ID has not been created yet."))
        }
        
        boards[id].board[cellIndex].cells[boxIndex].value = value
        
        return "{\"value\":\(value)}"
    }.description("200 OK")
}
