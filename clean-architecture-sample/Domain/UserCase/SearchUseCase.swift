//
//  SearchUseCase.swift
//  clean-architecture-sample
//
//  Created by iori tenma on 2020/10/07.
//  Copyright © 2020 iori tenma. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchUseCase {
    func search(text: String) -> Observable<GithubReposModel>
}

class SearchUseCaseImpl: SearchUseCase {
    
    let githubRepository: GithubRepository
    
    init(repository: GithubRepository) {
        self.githubRepository = repository
    }

    func search(text: String) -> Observable<GithubReposModel> {
        return githubRepository.search(text: text).map { GithubReposTranslator.translate($0)}
    }

}
