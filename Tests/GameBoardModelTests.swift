//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by 2019_DEV_137 on 18/03/2019.
//  Copyright © 2019 2019_DEV_137. All rights reserved.
//

import XCTest
@testable import TicTacToe

class GameBoardModelTests: XCTestCase {

    func testResetBoard() {
        XCTAssert(GameBoardViewModel.reset.game.board == mockGameEmptyBoard.board)
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

