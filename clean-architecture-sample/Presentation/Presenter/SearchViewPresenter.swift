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
    var searchText: AnyObserver<String?> { get }
}

protocol SearchViewPresenterOutputs: AnyObject {
    var searchResults: Observable<[String]> { get }

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
    let searchText: AnyObserver<String?>

    /// Output
    let searchResults: Observable<[String]>

    private let disposeBag = DisposeBag()
    
    init() {
        let _searchText = PublishRelay<String?>()
        self.searchText = AnyObserver<String?>() { event in
            guard let text = event.element else {
                return
            }
            _searchText.accept(text)
        }
        
        // 最後の入力から0.3秒が経過したら、3文字以上の場合に文字列を流す
        let searchWithText = _searchText
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMap { text -> Observable<String> in
                guard let text = text, text.count > 2 else {
                    return .empty()
                }
                return .just(text)
            }
            .share()
        
        let _searchResults = PublishRelay<[String]>()
        self.searchResults = _searchResults.asObservable()
        
        do {
//            let searchResult = searchWithText
//                .flatMap { text -> Observable<GithubRepoInfo> in
//                    self.sendRequest()
//                        .map { githubRepoInfo -> Result in
//                    }
//                }.share()
            
            
        }
    }
    
    func sendRequest() -> Observable<GithubRepoInfo> {
        return Observable.create { observer -> Disposable in
            let githubRepoInfo = GithubRepoInfo(count: 2, items: ["aaa", "bbb"].map{ GithubRepoItem(name: $0)})
            observer.onNext(githubRepoInfo)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}


struct GithubRepoInfo {
    let count: Int
    let items: [GithubRepoItem]
}

struct GithubRepoItem {
    let name: String
}

