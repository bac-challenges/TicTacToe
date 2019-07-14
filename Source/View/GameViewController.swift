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
//	ID: AC2790D1-2438-4235-81E1-8BD139638A35
//
//	Pkg: TicTacToe
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

class GameViewController: UIViewController {

	private var model = GameViewModel()
	
	var buttons: [UIButton] {
		return [UIButton]()
//		return [
//			topLeftButton1,
//			topMiddleButton,
//			topRightButton,
//			middleLeftButton,
//			middleButton,
//			middleRightButton,
//			bottomLeftButton,
//			bottomMiddleButton,
//			bottomRightButton
//		]
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
//		whoesTurnLabel.text = "X to go"
		
		for button in buttons {
			button.setTitle("_", for: .normal)
			button.titleLabel?.font = .boldSystemFont(ofSize: 60)
		}
	}
	
	private func process(result: Result) {
		switch result {
			
		case .illegalMove:
			showAlertView(title: "Illegal Move", message: "Please select another square")
			
		case .moveMade(let model):
			update(using: model)
			
		case .draw(let model):
			handleEndGame(with: model, message: "Only a draw this time")
			
		case .playerWin(let model):
			handleEndGame(with: model, message: "\(model.playerTurn.rawValue) Wins")
		}
	}
}

// MARK: - Actions
extension GameViewController {

	@objc func squarePressed(sender: UIButton) {
		guard let square = Square(rawValue: sender.tag) else {
			fatalError("Square does not exist for button")
		}
		
		let result = model.process(move: model.playerTurn.piece, coordinates: square.coordinates)
		
		process(result: result)
	}
}

// MARK: - UI
extension GameViewController {
	private func setupView() {
		setupLayout()
	}
	
	private func setupLayout() {
	}
}

// MARK: - End game methods
extension GameViewController {
	
	private func update(using model: GameViewModel) {
		self.model = model
		
//		whoesTurnLabel.text = "\(model.playerTurn.piece.rawValue) to go"
		
		for (index, button) in buttons.enumerated() {
			let value = model.flattenedBoard[index]
			button.setTitle(value.rawValue, for: .normal)
		}
	}
	
	private func handleEndGame(with model: GameViewModel, message: String) {
		showAlertView(title: "Game Over", message: message)
		reset()
	}
	
	private func reset() {
		update(using: GameViewModel.reset)
		for button in buttons {
			button.setTitle("_", for: .normal)
		}
	}
}

// MARK:- AlertView
extension GameViewController {
	private func showAlertView(title: String, message: String) {
		let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
		vc.addAction(.init(title: "Ok", style: .default, handler: nil))
		present(vc, animated: true, completion: nil)
	}
}
