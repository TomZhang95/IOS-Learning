//
//  Meme.swift
//  Meme_v1.0
//
//  Created by Tom Zhang on 4/24/17.
//  Copyright © 2017 Tom Zhang. All rights reserved.
//

import UIKit
class Meme {
    var topText : String
    var bottomText: String
    let originalImage : UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
