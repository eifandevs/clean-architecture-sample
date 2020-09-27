//
//  SearchViewPresenter.swift
//  clean-architecture-sample
//
//  Created by iori tenma on 2020/09/27.
//  Copyright © 2020 iori tenma. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchViewPresenterInputs: AnyObject {
    var searchText: PublishRelay<String> { get }
}

protocol SearchViewPresenterOutputs: AnyObject {
    var searchResults: PublishRelay<[String]> { get }
}

protocol SearchViewPresenterType: AnyObject {
    var inputs: SearchViewPresenterInputs { get }
    var outputs: SearchViewPresenterOutputs { get }
}

final class SearchViewPresenter: SearchViewPresenterType, SearchViewPresenterInputs, SearchViewPresenterOutputs {
    /// Type
    var inputs: SearchViewPresenterInputs { return self }
    var outputs: SearchViewPresenterOutputs { return self }
    
    
    /// Input
    let searchText = PublishRelay<String>()

    /// Output
    let searchResults = PublishRelay<[String]>()

    private let disposeBag = DisposeBag()
    
    init() {
        searchText.subscribe { e in
            if let text = e.element {
                print("### text: \(text)")
            }
        }.disposed(by: self.disposeBag)
    }
}
