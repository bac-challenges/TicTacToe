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
//	ID: 2981EADC-4CB8-43FB-A749-7888E3693D60
//
//	Pkg: TicTacToe
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

protocol GameViewDelegate: class {
	func squarePressed(square: UIButton)
}

// MARK: -
class GameView: UIView {

	// Public
	public weak var delegate: GameViewDelegate?
	public var elements: [[Game.Piece]]? {
		didSet {
			setupView()
		}
	}
	
	// Private
	private lazy var container = UIStackView()
	private lazy var instructionsLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = .darkGray
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 32, weight: .light)
		return label
	}()
	
	private lazy var buttons: [UIButton] = []
	
	// Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
}

// MARK: - Game State Controls
extension GameView {
	
	/// Reset
	public func reset() {
		update(GameViewModel.reset)
	}
	
	/// Update
	public func update(_ model: GameViewModel) {
		// Instructions
		instructionsLabel.text = model.playerTurn.piece.rawValue
		
		for (index, button) in buttons.enumerated() {
			let value = model.flatBoard[index]
			button.setTitle(value.rawValue, for: .normal)
		}
	}
}

// MARK: - UI
extension GameView {
	private func setupView() {
		backgroundColor = .white
		
		// Instructions
		instructionsLabel.text = Player.playerOne.piece.rawValue
		
		// Grid
		container.spacing = 10
		container.axis = .vertical
		
		// Clear grid
		buttons.removeAll()
		container.removeAllArrangedSubviews()
		
		// Generate grid
		if let map = elements {
			
			var index = 0
			
			// Generate rows
			map.forEach { row in
				
				// Create row
				let rowStack = UIStackView()
				rowStack.spacing = 10
				rowStack.axis = .horizontal
				rowStack.alignment = .fill
				rowStack.distribution = .fillEqually
				
				// Create column
				row.forEach { square in
					let button = UIButton()
					button.tag = index
					button.layer.cornerRadius = 6
					button.anchor(width: 80, height: 80)
					button.backgroundColor = .groupTableViewBackground
					button.addTarget(self, action: #selector(squarePressed), for: .touchUpInside)
					
					//
					buttons.append(button)
					
					// Add item to row
					rowStack.addArrangedSubview(button)
					index += 1
				}
				
				// Add row
				container.addArrangedSubview(rowStack)
			}
		}
		
		addSubview(container)
		addSubview(instructionsLabel)
		setupLayout()
	}
	
	private func setupLayout() {
		container.anchor(centerX: centerXAnchor, centerY: centerYAnchor, paddingCenterY: 30)
		instructionsLabel.anchor(bottom: container.topAnchor, paddingBottom: 20,
								 left: container.leftAnchor,
								 right: container.rightAnchor)
	}
}

// MARK: - Actions
extension GameView {
	@objc func squarePressed(sender: UIButton) {
		if let delegate = delegate {
			delegate.squarePressed(square: sender)
		}
	}
}
