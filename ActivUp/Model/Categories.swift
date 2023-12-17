//
//  Categories.swift
//  ActivUp
//
//  Created by Anel Rustamova on 06.12.2023.
//

import Foundation


class VideoCategory {
    var name : String
    var catImg : Data
    init(name: String, catImg: Data) {
        self.name = name
        self.catImg = catImg
    }
}

let c1 = VideoCategory(name: "by Time", catImg: Data())
let c2 = VideoCategory(name: "by YouTube", catImg: Data())

var listCat = [c1, c2]
