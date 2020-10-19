//
//  WireFrame.swift
//  clean-architecture-sample
//
//  Created by iori tenma on 2020/10/19.
//  Copyright © 2020 iori tenma. All rights reserved.
//

import Foundation
import UIKit

protocol WireFrame {
    associatedtype ViewController: UIViewController

    init(viewController: ViewController)
}
