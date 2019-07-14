//
//  GameTests.swift
//  TicTacToeTests
//
//  Created by 2019_DEV_137 on 19/03/2019.
//  Copyright © 2019 2019_DEV_137. All rights reserved.
//

import XCTest
@testable import TicTacToe

class GameTests: XCTestCase {
    
    func testSubscriptWithCoordinates() {
        let model = mockModelFullBoard()
        XCTAssert(model.game[.init(row: 0, column: 0)] == .x)
    }
}

