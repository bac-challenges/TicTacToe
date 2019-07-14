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
//	ID: 91B949A9-46D9-4FD4-882C-406FFCA7A6E9
//
//	Pkg: TicTacToe
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

//
protocol GameBoardDelegate: class {
	func squarePressed(sender: UIButton)
}

class GameBoard: UIStackView {
	
	// Delegate
	public weak var delegate: GameBoardDelegate?
	
	// Elements map
	private var map: [[Game.Piece]]? {
		didSet {
			setupView()
		}
	}
}

// MARK: - UI
extension GameBoard {
	private func setupView() {
		
		// Grid
		spacing = 10
		axis = .vertical

		// Clear grid
		removeAllArrangedSubviews()
		
		// Generate grid
		if let map = map {

			var index = 0
			
			// Generate rows
			map.forEach { row in
				
				let rowStack = UIStackView()
				rowStack.spacing = 5
				rowStack.axis = .horizontal
//				rowStack.alignment = .fill
//				rowStack.distribution = .fillEqually
				
				// Prepare row
				row.forEach { square in
					let button = UIButton()
					button.backgroundColor = .orange
					button.layer.cornerRadius = 6
					button.setTitle("\(index)", for: .normal)
					button.addTarget(self,
									 action: #selector(squarePressed),
									 for: .touchUpInside)
					
					// Add item to row
					rowStack.addArrangedSubview(button)
					index += 1
				}
				
				// Add row to grid
				addArrangedSubview(rowStack)
			}
		}
	}
}

// MARK: - Actions
extension GameBoard {
	@objc func squarePressed(sender: UIButton) {
		
	}
}
