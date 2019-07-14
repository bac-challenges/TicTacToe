//
//  MockGameStates.swift
//  TicTacToeTests
//
//  Created by 2019_DEV_137 on 19/03/2019.
//  Copyright © 2019 2019_DEV_137. All rights reserved.
//

import Foundation
@testable import TicTacToe

let mockGameEmptyBoard = Game.init(board: [
    [.empty, .empty, .empty],
    [.empty, .empty, .empty],
    [.empty, .empty, .empty]
    ])

let mockGameFullBoard = Game.init(board: [
    [.x, .o, .x],
    [.o, .o, .x],
    [.x, .x, .o]
    ])

let mockGameOneSpaceLeft = Game.init(board: [
    [.x, .o, .x],
    [.o, .o, .x],
    [.x, .x, .empty]
    ])

func mockModelEmptyBoard(for player: Player = .playerOne) -> GameBoardViewModel {
    return GameBoardViewModel(game: mockGameEmptyBoard, playerTurn: player)
}

func mockModelFullBoard(for player: Player = .playerOne) -> GameBoardViewModel {
    return GameBoardViewModel(game: mockGameFullBoard, playerTurn: .playerTwo)
}

func mockModelOneSpaceLeft(for player: Player = .playerOne) -> GameBoardViewModel {
    return GameBoardViewModel(game: mockGameOneSpaceLeft, playerTurn: .playerOne)
}

func board(using model: GameBoardViewModel,
                  playerMove: Game.Piece,
                  coords: [Coordinates]) -> GameBoardViewModel {
    var mutModel = model
    _ = mutModel.process(move: playerMove, coordinates: coords[0])
    _ = mutModel.process(move: playerMove, coordinates: coords[1])
    _ = mutModel.process(move: playerMove, coordinates: coords[2])
    return mutModel
}
