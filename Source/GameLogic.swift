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
//	ID: 2D77BA03-54E9-4448-85B2-D4CA318B5897
//
//	Pkg: TicTacToe
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import Foundation

extension GameBoardViewModel {
	
	func checkHorizontalWin(for playerPiece: Game.Piece) -> Bool {
		for row in game.board {
			if row.elements(areAll: playerPiece) { return true }
		}
		return false
	}
	
	func checkVerticalWin(for playerPiece: Game.Piece) -> Bool {
		for i in 0..<game.board.count {
			
			var match = true
			for row in game.board {
				if row[i] == playerPiece { continue }
				else { match = false; break }
			}
			if match { return true }
		}
		return false
	}
	
	func checkDiagonalWin(for playerPiece: Game.Piece) -> Bool {
		if playerPiece == game.board[0][0] && playerPiece == game.board[1][1] && playerPiece == game.board[2][2] ||
			playerPiece == game.board[2][0] && playerPiece == game.board[1][1] && playerPiece == game.board[0][2] {
			return true
		}
		return false
	}
	
	func checkDraw(game: Game) -> Bool {
		for row in game.board {
			if row.contains(.empty) { return false }
		}
		return true
	}
}
