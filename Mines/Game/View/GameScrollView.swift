//
//  GameScrollView.swift
//  Mines
//
//  Created by Andrey Zonov on 21/10/2018.
//  Copyright © 2018 Andrey Zonov. All rights reserved.
//

import UIKit

class GameScrollView: UIScrollView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        recognizer.cancelsTouchesInView = false
        addGestureRecognizer(recognizer)
    }
    
    @objc
    func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: self)
    }
}
