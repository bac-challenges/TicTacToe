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

	private lazy var model = GameViewModel()
	private lazy var gameView = GameView()

	override func viewDidLoad() {
		super.viewDidLoad()
		view = gameView
	}
}

// MARK: - Actions
extension GameViewController: GameViewDelegate {

	@objc func squarePressed(sender: UIButton) {
		guard let square = Square(rawValue: sender.tag) else {
			fatalError("Square does not exist for button")
		}
		
		#warning("Refactor")
		let result = model.process(move: model.playerTurn.piece,
								   coordinates: square.coordinates)
		
		switch result {
		case .illegalMove: showAlertView(title: "Illegal Move",
										 message: "Please select another square")
			
		case .moveMade(let model): update(using: model)
			
		case .draw(let model): handleEndGame(with: model,
											 message: "It's a draw")
			
		case .playerWin(let model): handleEndGame(with: model,
												  message: "\(model.playerTurn.rawValue) Wins")
		}
	}
}

// MARK: - End game methods
extension GameViewController {
	private func handleEndGame(with model: GameViewModel, message: String) {
		showAlertView(title: "Game Over", message: message)
		reset()
	}
	
	private func reset() {
		update(using: GameViewModel.reset)
	}
	
	private func update(using model: GameViewModel) {
		self.model = model
		gameView.update(model)
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
