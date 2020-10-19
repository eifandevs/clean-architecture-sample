//
//  GithubRepository.swift
//  clean-architecture-sample
//
//  Created by iori tenma on 2020/10/19.
//  Copyright © 2020 iori tenma. All rights reserved.
//

import Foundation
import RxSwift

protocol GithubRepository {
    func search(text: String) -> Observable<GithubRepoInfo>
}

class GithubRepositoryImpl: GithubRepository {
    
    func search(text: String) -> Observable<GithubRepoInfo> {
        return Observable.create { observer -> Disposable in
            let githubRepoInfo = GithubRepoInfo(count: 2, items: ["aaa", "bbb"].map{ GithubRepoItem(name: $0)})
            observer.onNext(githubRepoInfo)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
