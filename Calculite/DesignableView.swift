//
//  DesignableView.swift
//  Calculite
//
//  Created by Abdurrahman on 10/5/16.
//  Copyright © 2016 AR Ehsan. All rights reserved.
//

import UIKit

class DesignableView: UIView {

	override func awakeFromNib() {
		super.awakeFromNib()
		self.layer.cornerRadius = 32
		self.layer.opacity = 0.6
	}

}
