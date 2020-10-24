//
//  SearchWireFrame.swift
//  clean-architecture-sample
//
//  Created by iori tenma on 2020/10/22.
//  Copyright © 2020 iori tenma. All rights reserved.
//

import Foundation

struct SearchWireframe: WireFrame {
    typealias ViewController = SearchViewController

    fileprivate weak var viewController: SearchViewController?

    init(viewController: ViewController) {
        self.viewController = viewController
    }

    func showDetail() {
        print("画面遷移")
    }
}
