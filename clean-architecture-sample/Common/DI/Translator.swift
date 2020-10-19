//
//  Translator.swift
//  clean-architecture-sample
//
//  Created by iori tenma on 2020/10/19.
//  Copyright © 2020 iori tenma. All rights reserved.
//

import Foundation

protocol Translator: class {
    associatedtype Input
    associatedtype Output
 
    static func translate(_ entity: Input) -> Output
}
