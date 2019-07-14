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
//	ID: BD9ADD22-8EC4-438E-BE70-37495D9FB07A
//
//	Pkg: TicTacToe
//
//	Swift: 5.0
//
//	MacOS: 10.15
//

import XCTest
@testable import TicTacToe

class GameBoardModelTests: XCTestCase {

    func testResetBoard() {
        XCTAssert(GameViewModel.reset.game.board == mockGameEmptyBoard.board)
    }
    
    func testCanSwapTurn() {
        let model = mockModelEmptyBoard()
        let swappedPlayerModel = model.swapTurn(current: .playerOne)
        
        XCTAssert(swappedPlayerModel.playerTurn == .playerTwo)
    }
}

// MARK:- Tests for checking row win
extension GameBoardModelTests {
    
    func testWinForXFirstRow() {
        let coords = [Coordinates(row: 0, column: 0),
                      Coordinates(row: 0, column: 1),
                      Coordinates(row: 0, column: 2)
        ]
        
        let winningX = board(using: mockModelEmptyBoard(), playerMove: .x, coords: coords)
        XCTAssert(winningX.checkHorizontalWin(for: .x))
        
        let winningO = board(using: mockModelEmptyBoard(for: .playerTwo), playerMove: .o, coords: coords)
        XCTAssert(winningO.checkHorizontalWin(for: .o))
    }
    
    func testWinForSecondRow() {
        func testWinForXFirstHorizontal() {
            let coords = [Coordinates(row: 1, column: 0),
                          Coordinates(row: 1, column: 1),
                          Coordinates(row: 1, column: 2)
            ]
            
            let winningX = board(using: mockModelEmptyBoard(), playerMove: .x, coords: coords)
            XCTAssert(winningX.checkHorizontalWin(for: .x))
            
            let winningO = board(using: mockModelEmptyBoard(for: .playerTwo), playerMove: .o, coords: coords)
            XCTAssert(winningO.checkHorizontalWin(for: .o))
        }
    }
    
    func testWinForThirdRow() {
        func testWinForXFirstHorizontal() {
            let coords = [Coordinates(row: 2, column: 0),
                          Coordinates(row: 2, column: 1),
                          Coordinates(row: 2, column: 2)
            ]
            
            let winningX = board(using: mockModelEmptyBoard(), playerMove: .x, coords: coords)
            XCTAssert(winningX.checkHorizontalWin(for: .x))
            
            let winningO = board(using: mockModelEmptyBoard(for: .playerTwo), playerMove: .o, coords: coords)
            XCTAssert(winningO.checkHorizontalWin(for: .o))
        }
    }
}


// MARK: Tests for checking column win
extension GameBoardModelTests {
    func testWinForFirstColumn() {
        let coords = [Coordinates(row: 0, column: 0),
                      Coordinates(row: 1, column: 0),
                      Coordinates(row: 2, column: 0)
        ]
        
        let winningX = board(using: mockModelEmptyBoard(), playerMove: .x, coords: coords)
        XCTAssert(winningX.checkVerticalWin(for: .x))
        
        let winningO = board(using: mockModelEmptyBoard(for: .playerTwo), playerMove: .o, coords: coords)
        XCTAssert(winningO.checkVerticalWin(for: .o))
    }
    
    func testWinForSecondColumn() {
        let coords = [Coordinates(row: 0, column: 1),
                      Coordinates(row: 1, column: 1),
                      Coordinates(row: 2, column: 1)
        ]
        
        let winningX = board(using: mockModelEmptyBoard(), playerMove: .x, coords: coords)
        XCTAssert(winningX.checkVerticalWin(for: .x))
        
        let winningO = board(using: mockModelEmptyBoard(for: .playerTwo), playerMove: .o, coords: coords)
        XCTAssert(winningO.checkVerticalWin(for: .o))
    }
    
    func testWinForThirdColumn() {
        let coords = [Coordinates(row: 0, column: 2),
                      Coordinates(row: 1, column: 2),
                      Coordinates(row: 2, column: 2)
        ]
        
        let winningX = board(using: mockModelEmptyBoard(), playerMove: .x, coords: coords)
        XCTAssert(winningX.checkVerticalWin(for: .x))
        
        let winningO = board(using: mockModelEmptyBoard(for: .playerTwo), playerMove: .o, coords: coords)
        XCTAssert(winningO.checkVerticalWin(for: .o))
    }
    
    func testWinForDiagonalTopLeftToBottomRight() {
        let coords = [Coordinates(row: 0, column: 0),
                      Coordinates(row: 1, column: 1),
                      Coordinates(row: 2, column: 2)
        ]
        
        let winningX = board(using: mockModelEmptyBoard(), playerMove: .x, coords: coords)
        XCTAssert(winningX.checkDiagonalWin(for: .x))
        
        let winningO = board(using: mockModelEmptyBoard(for: .playerTwo), playerMove: .o, coords: coords)
        XCTAssert(winningO.checkDiagonalWin(for: .o))
    }
    
    func testWinForDiagonalBottomLeftToTopRight() {
        let coords = [Coordinates(row: 2, column: 0),
                      Coordinates(row: 1, column: 1),
                      Coordinates(row: 0, column: 2)
        ]
        
        let winningX = board(using: mockModelEmptyBoard(), playerMove: .x, coords: coords)
        XCTAssert(winningX.checkDiagonalWin(for: .x))
        
        let winningO = board(using: mockModelEmptyBoard(for: .playerTwo), playerMove: .o, coords: coords)
        XCTAssert(winningO.checkDiagonalWin(for: .o))
    }
}


// MARK: Tests for checking the processing of a move
extension GameBoardModelTests {
    
    func testCantMakeIllegalMove() {
        
        var model = mockModelEmptyBoard()
        
        _ = model.process(move: .x, coordinates: .init(row: 0, column: 0))
        let illegalMove = model.process(move: .x, coordinates: .init(row: 0, column: 0))
        
        switch illegalMove {
        case .illegalMove: XCTAssert(true)
        default: XCTFail()
        }
    }
    
    func testProcessMoveReturnsPlayerWinOnWinningMove() {
        
        var model = mockModelOneSpaceLeft()
        
        let result = model.process(move: .x, coordinates: .init(row: 2, column: 2))
        
        switch result {
        case .playerWin(_): XCTAssert(true)
        default: XCTFail()
        }
    }
    
    func testProcessMoveReturnsDrawWhenBoardIsCompleteWithNoWinner() {
        
        var model = mockModelOneSpaceLeft(for: .playerTwo)
        
        let result = model.process(move: .o, coordinates: .init(row: 2, column: 2))
        
        switch result {
        case .draw(_): XCTAssert(true)
        default: XCTFail()
        }
    }
    
    func testProcessMoveReturnsMoveWhenStandardMoveIsMade() {
        
        var model = mockModelEmptyBoard()
        
        let result = model.process(move: .x, coordinates: .init(row: 0, column: 0))
        
        switch result {
        case .moveMade(_): XCTAssert(true)
        default: XCTFail()
        }
    }
}

