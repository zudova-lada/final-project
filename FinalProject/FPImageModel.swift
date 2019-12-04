//
//  FPImageModel.swift
//  FinalProject
//
//  Created by Лада on 04/12/2019.
//  Copyright © 2019 Лада. All rights reserved.
//

import UIKit

// Структура, хранящая в себе имя картинки и саму картинку.
// Имя необходимо для логики игры, т.к. сравнение изображений происходит по имени, а не по картинке
struct ImageModel {
    var name: String
    var image: UIImage
}
