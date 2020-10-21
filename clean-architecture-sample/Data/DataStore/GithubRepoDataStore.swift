//
//  GithubRepoDataStore.swift
//  clean-architecture-sample
//
//  Created by iori tenma on 2020/10/21.
//  Copyright © 2020 iori tenma. All rights reserved.
//

import Foundation
import RxSwift

protocol GithubRepoDataStore {
    func searchRepo(text: String) -> Observable<GithubReposEntity>
}

class GithubRepoDataStoreImpl: GithubRepoDataStore {
    
    func searchRepo(text: String) -> Observable<GithubReposEntity> {
        return Observable.create { observer -> Disposable in
            let githubReposEntity = GithubReposEntity(count: 2, repos: ["aaa", "bbb"].map{ GithubRepoEntity(name: $0)})
            observer.onNext(githubReposEntity)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
