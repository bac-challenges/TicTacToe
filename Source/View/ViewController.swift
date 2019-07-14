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
//	ID: AC2790D1-2438-4235-81E1-8BD139638A35
//
//	Pkg: TicTacToe
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

class GameViewController: UIViewController {
	
	private enum Square: Int {
		case topLeft = 1
		case topMiddle = 2
		case topRight = 3
		case middleLeft = 4
		case middle = 5
		case middleRight = 6
		case bottomLeft = 7
		case bottomMiddle = 8
		case bottomRight = 9
	}
	
	@IBOutlet var whoesTurnLabel: UILabel!
	
	@IBOutlet var topLeftButton: UIButton!
	@IBOutlet var topMiddleButton: UIButton!
	@IBOutlet var topRightButton: UIButton!
	@IBOutlet var middleLeftButton: UIButton!
	@IBOutlet var middleButton: UIButton!
	@IBOutlet var middleRightButton: UIButton!
	@IBOutlet var bottomLeftButton: UIButton!
	@IBOutlet var bottomMiddleButton: UIButton!
	@IBOutlet var bottomRightButton: UIButton!
	
	private var model = GameBoardViewModel()
	var buttons: [UIButton] {
		return [
			topLeftButton,
			topMiddleButton,
			topRightButton,
			middleLeftButton,
			middleButton,
			middleRightButton,
			bottomLeftButton,
			bottomMiddleButton,
			bottomRightButton
		]
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		whoesTurnLabel.text = "X to go"
		for button in buttons {
			button.setTitle("_", for: .normal)
			button.titleLabel?.font = .boldSystemFont(ofSize: 60)
		}
	}
	
	@IBAction func squarePressed(sender: UIButton) {
		guard let square = Square(rawValue: sender.tag) else { fatalError("Square does not exist for button") }
		
		var coord: Coordinates
		switch square {
		case .topLeft: coord = .init(row: 0, column: 0)
		case .middleLeft: coord = .init(row: 1, column: 0)
		case .bottomLeft: coord = .init(row: 2, column: 0)
		case .topMiddle: coord = .init(row: 0, column: 1)
		case .middle: coord = .init(row: 1, column: 1)
		case .bottomMiddle: coord = .init(row: 2, column: 1)
		case .topRight: coord = .init(row: 0, column: 2)
		case .middleRight: coord = .init(row: 1, column: 2)
		case .bottomRight: coord = .init(row: 2, column: 2)
		}
		
		let result = model.process(move: model.playerTurn.piece, coordinates: coord)
		process(result: result)
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

// MARK:- End game methods
extension TicTacToeViewController {
	
	private func update(using model: GameBoardViewModel) {
		self.model = model
		whoesTurnLabel.text = "\(model.playerTurn.piece.rawValue) to go"
		for (index, button) in buttons.enumerated() {
			let value = model.flattenedBoard[index]
			button.setTitle(value.rawValue, for: .normal)
		}
	}
	
	private func handleEndGame(with model: GameBoardViewModel, message: String) {
		showAlertView(title: "Game Over", message: message)
		reset()
	}
	
	private func reset() {
		update(using: GameBoardViewModel.reset)
		for button in buttons {
			button.setTitle("_", for: .normal)
		}
	}
}

// MARK:- AlertView
extension TicTacToeViewController {
	private func showAlertView(title: String, message: String) {
		let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
		vc.addAction(.init(title: "Ok", style: .default, handler: nil))
		present(vc, animated: true, completion: nil)
	}
}

