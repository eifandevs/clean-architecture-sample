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
    func search(text: String) -> Observable<GithubReposEntity>
}

class GithubRepositoryImpl: GithubRepository {
    
    let githubRepoDataStore: GithubRepoDataStore

    init(dataStore: GithubRepoDataStore) {
        self.githubRepoDataStore = dataStore
    }

    func search(text: String) -> Observable<GithubReposEntity> {
        return githubRepoDataStore.searchRepo(text: text)
    }
}
