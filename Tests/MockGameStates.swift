//	MIT License
//
//	Copyright © 2019_DEV_182
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.
//
//	ID: BD9ADD22-8EC4-438E-BE70-91369D9FB07A
//
//	Pkg: TicTacToe
//
//	Swift: 5.0
//
//	MacOS: 10.15
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

func mockModelEmptyBoard(for player: Player = .playerOne) -> GameViewModel {
	return GameViewModel(game: mockGameEmptyBoard, playerTurn: player)
}

func mockModelFullBoard(for player: Player = .playerOne) -> GameViewModel {
	return GameViewModel(game: mockGameFullBoard, playerTurn: player)
}

func mockModelOneSpaceLeft(for player: Player = .playerOne) -> GameViewModel {
	return GameViewModel(game: mockGameOneSpaceLeft, playerTurn: player)
}

func board(using model: GameViewModel, playerMove: Game.Piece, coords: [Coordinates]) -> GameViewModel {
	var mutModel = model
	mutModel.process(move: playerMove, coordinates: coords[0])
	mutModel.process(move: playerMove, coordinates: coords[1])
	mutModel.process(move: playerMove, coordinates: coords[2])
	return mutModel
}
