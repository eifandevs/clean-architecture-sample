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
    var searchResults: Observable<[GithubRepoItem]> { get }

}

protocol SearchViewPresenter: AnyObject {
    var inputs: SearchViewPresenterInputs { get }
    var outputs: SearchViewPresenterOutputs { get }
}

final class SearchViewPresenterImpl: SearchViewPresenter, SearchViewPresenterInputs, SearchViewPresenterOutputs {
    /// Type
    var inputs: SearchViewPresenterInputs { return self }
    var outputs: SearchViewPresenterOutputs { return self }
    
    /// Input
    let searchText: AnyObserver<String?>

    /// Output
    let searchResults: Observable<[GithubRepoItem]>

    /// UseCase
    let searchUseCase: SearchUseCase
    
    private let disposeBag = DisposeBag()
    
    init(usecase: SearchUseCase) {
        // inject
        searchUseCase = usecase
        
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
        
        let _searchResults = PublishRelay<[GithubRepoItem]>()
        self.searchResults = _searchResults.asObservable()
        
        do {
            let searchResult = searchWithText
                .flatMap { text -> Observable<Event<[GithubRepoItem]>> in
                    self.searchUseCase.search(text: text)
                        .map { $0.items }
                        .materialize()
                }.share()
            
            searchResult
                .flatMap { $0.element.map(Observable.just) ?? .empty() }
                .bind(to: _searchResults)
                .disposed(by: disposeBag)

            searchResult
                .flatMap { $0.error.map(Observable.just) ?? .empty() }
                .subscribe(onNext: { error in
                    print("api error")
                })
                .disposed(by: disposeBag)
        }
    }
    
//    func sendRequest(text: String) -> Observable<GithubRepoInfo> {
//        return Observable.create { observer -> Disposable in
//            let githubRepoInfo = GithubRepoInfo(count: 2, items: ["aaa", "bbb"].map{ GithubRepoItem(name: $0)})
//            observer.onNext(githubRepoInfo)
//            observer.onCompleted()
//
//            return Disposables.create()
//        }
//    }
//
//    func sendRequestWithError(text: String) -> Observable<GithubRepoInfo> {
//        return Observable.create { observer -> Disposable in
//            let error = NSError(domain: "", code: 1, userInfo: nil)
//            observer.onError(error)
//
//            return Disposables.create()
//        }
//    }
}


struct GithubRepoInfo {
    let count: Int
    let items: [GithubRepoItem]
}

struct GithubRepoItem {
    let name: String
}

