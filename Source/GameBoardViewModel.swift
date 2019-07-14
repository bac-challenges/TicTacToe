//	MIT License
//
//	Copyright © 2019 Emile, Blue Ant Corp
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
//	ID: F0300BC8-CF2C-4F7C-8710-780BE39722E7
//
//	Pkg: TicTacToe
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import Foundation

enum Result {
	case illegalMove
	case moveMade(GameBoardViewModel)
	case draw(GameBoardViewModel)
	case playerWin(GameBoardViewModel)
}

enum Player: String {
	case playerOne = "Player One"
	case playerTwo = "Player Two"
	
	fileprivate var switchPlayer: Player {
		switch self {
		case .playerOne: return .playerTwo
		case .playerTwo: return .playerOne
		}
	}
	
	var piece: Game.Piece {
		switch self {
		case .playerOne: return .x
		case .playerTwo: return .o
		}
	}
}

struct GameBoardViewModel {
	var game: Game = Game()
	var playerTurn = Player.playerOne
	
	var flattenedBoard: [Game.Piece] {
		return game.board.flatMap { $0 }
	}
	
	static var reset: GameBoardViewModel {
		return GameBoardViewModel(game: .init(), playerTurn: .playerOne)
	}
	
	mutating func update(with coords: Coordinates) -> GameBoardViewModel {
		let board = game.updateBoard(using: coords, playerTurn: playerTurn)
		return GameBoardViewModel(
			game: .init(board: board),
			playerTurn: self.playerTurn)
	}
	
	func swapTurn(current: Player) -> GameBoardViewModel {
		return GameBoardViewModel(
			game: self.game,
			playerTurn: current.switchPlayer)
	}
}

extension GameBoardViewModel {
	
	mutating func process(move playerPiece: Game.Piece, coordinates: Coordinates) -> Result {
		
		guard checkLegalMove(coordinates: coordinates) else {
			return .illegalMove
		}
		
		let updatedModel = update(with: coordinates)
		
		if updatedModel.checkWin(for: playerPiece, coordinates: coordinates) {
			return .playerWin(updatedModel)
		}
		
		if checkDraw(game: game) {
			return .draw(updatedModel)
		}
		
		return .moveMade(updatedModel.swapTurn(current: playerTurn))
	}
	
	func checkLegalMove(coordinates: Coordinates) -> Bool {
		return self.game[coordinates] == .empty
	}
	
	func checkWin(for playerPiece: Game.Piece, coordinates: Coordinates) -> Bool {
		return checkHorizontalWin(for: playerPiece)
			|| checkVerticalWin(for: playerPiece)
			|| checkDiagonalWin(for: playerPiece)
	}
}
