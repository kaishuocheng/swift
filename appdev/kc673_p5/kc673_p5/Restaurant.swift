//
//  Restaurant.swift
//  kc673_p5
//
//  Created by kaishuo cheng on 4/14/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import Foundation
import UIKit
enum foodtype: CaseIterable{
    case Dininghall, Chinese, Korean, Thai, Steak, American, Mexican
}
enum mealtime: CaseIterable{
    case breakfast, lunch, dinner, latedinner
}
class restaurant {
    var image: UIImage
    var name: String
    var food: foodtype
    var time: [mealtime]
    var cost: Int
    
    init(image: UIImage, name: String, food: foodtype,time: [mealtime],cost: Int) {
        self.image = image
        self.name = name
        self.food = food
        self.time = time
        self.cost = cost
    }
    
}
