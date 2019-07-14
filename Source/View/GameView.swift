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
//	ID: 2981EADC-4CB8-43FB-A749-7888E3693D60
//
//	Pkg: TicTacToe
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

//
class GameView: UIView {

	private lazy var instructionsLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = .darkGray
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 32, weight: .light)
		return label
	}()
	
	private lazy var container: GameBoard = {
		let container = GameBoard()
		return container
	}()

	private var buttons: [UIButton] {
		return []
	}
	
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

// MARK: -
extension GameView {
	
	/// Reset
	public func reset() {
		update(GameViewModel.reset)
	}
	
	/// Update
	public func update(_ model: GameViewModel) {
		instructionsLabel.text = "\(model.playerTurn.piece.rawValue) to go"
		
		for (index, button) in buttons.enumerated() {
			let value = model.flattenedBoard[index]
			button.setTitle(value.rawValue, for: .normal)
		}
	}
	
	private func setButtonTitle() {
		buttons.forEach { button in
			button.setTitle("", for: .normal)
		}
	}
}

// MARK: - Actions
extension GameView: GameBoardDelegate {
	func squarePressed(square: UIButton) {
		print(square.tag)
	}
}

// MARK: - UI
extension GameView {
	private func setupView() {
		backgroundColor = .white
		instructionsLabel.text = "X to go"
		container.elements = Game().board
		container.delegate = self
		addSubview(instructionsLabel)
		addSubview(container)
		setupLayout()
	}
	
	private func setupLayout() {
		container.anchor(centerX: centerXAnchor, centerY: centerYAnchor)
		instructionsLabel.anchor(bottom: container.topAnchor, paddingBottom: 20,
								 left: container.leftAnchor,
								 right: container.rightAnchor)
	}
}
