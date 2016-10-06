//
//  ViewController.swift
//  Calculite
//
//  Created by Abdurrahman on 10/4/16.
//  Copyright © 2016 AR Ehsan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

	@IBOutlet weak var outputLabel: UILabel!
	@IBOutlet weak var finalResultLabel: UILabel!
	
	enum Operation: String {
		case Divide = "/"
		case Multiply = "*"
		case Subtract = "-"
		case Add = "+"
		case Empty = ""
	}
	
	var currentOperation = Operation.Empty
	var runningNumber = ""
	var leftValString = ""
	var rightValString = ""
	var result = ""
	
	var btnSound: AVAudioPlayer!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let path = Bundle.main.path(forResource: "pop", ofType: "mp3")
		let soundURL = URL(fileURLWithPath: path!)
		
		do {
			try btnSound = AVAudioPlayer(contentsOf: soundURL)
			btnSound.prepareToPlay()
		} catch let err as NSError {
			print(err.debugDescription)
			print(err.localizedDescription)
		}
		
		outputLabel.text = ""
		
	}

	@IBAction func divide(_ sender: UIButton) {
		processOperation(operation: .Divide)
	}

	@IBAction func multiply(_ sender: UIButton) {
		processOperation(operation: .Multiply)
	}
	
	@IBAction func subtract(_ sender: UIButton) {
		processOperation(operation: .Subtract)
	}
	
	@IBAction func add(_ sender: UIButton) {
		processOperation(operation: .Add)
	}
	
	@IBAction func equal(_ sender: UIButton) {
		processOperation(operation: currentOperation)
	}

	@IBAction func numberPressed(_ sender: UIButton) {
		playSound()
		
		if runningNumber.characters.count != 0 || sender.tag != 0 {
			runningNumber += "\(sender.tag)"
			finalResultLabel.text = runningNumber
		}
	}
	
	@IBAction func decimal(_ sender: AnyObject) {
		if "\(runningNumber)".range(of: ".") == nil {
			runningNumber += "."
			outputLabel.text = runningNumber
		}
	}
	
	@IBAction func clearPressed(_ sender: UIButton) {
		runningNumber = ""
		leftValString = ""
		rightValString = ""
		currentOperation = Operation.Empty
		result = ""
		outputLabel.text = ""
		finalResultLabel.text = "0"
	}
	
	func playSound() {
		if btnSound.isPlaying {
			btnSound.stop()
		}
		
		btnSound.play()
	}

	func processOperation(operation: Operation) {
		if currentOperation != Operation.Empty {
			if runningNumber != "" {
				rightValString = runningNumber
				runningNumber = ""
				
				if currentOperation == Operation.Multiply {
					if let dbLeftval = Double(leftValString), let dbRightval = Double(rightValString) {
						result = "\(dbLeftval * dbRightval)"
					} else {
						result = "0"
					}
				}
				else if currentOperation == Operation.Divide {
					if let dbLeftval = Double(leftValString), let dbRightval = Double(rightValString) {
						result = "\(dbLeftval / dbRightval)"
					} else {
						result = "0"
					}
				}
				else if currentOperation == Operation.Subtract {
					if let dbLeftval = Double(leftValString), let dbRightval = Double(rightValString) {
						result = "\(dbLeftval - dbRightval)"
					} else {
						result = "0"
					}
				}
				else if currentOperation == Operation.Add {
					if let dbLeftval = Double(leftValString), let dbRightval = Double(rightValString) {
						result = "\(dbLeftval + dbRightval)"
					} else {
						result = "0"
					}
				}
				
				leftValString = result
				outputLabel.text = result
			}
			
			currentOperation = operation
			
		} else {
			leftValString = runningNumber
			runningNumber = ""
			currentOperation = operation
		}
	
	}
	

}








