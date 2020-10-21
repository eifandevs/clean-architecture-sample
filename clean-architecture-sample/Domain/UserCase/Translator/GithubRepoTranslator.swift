//
//  GithubRepoTranslator.swift
//  clean-architecture-sample
//
//  Created by iori tenma on 2020/10/21.
//  Copyright © 2020 iori tenma. All rights reserved.
//

import Foundation

final class GithubReposTranslator: Translator {
    typealias Input  = GithubReposEntity
    typealias Output = GithubReposModel

    static func translate(_ entity: Input) -> Output {
        let repos: [GithubRepoModel] = entity.repos.map {
            GithubRepoTranslator.translate($0)
        }

        return GithubReposModel(count: repos.count, items: repos)
    }
}

final class GithubRepoTranslator: Translator {
    typealias Input  = GithubRepoEntity
    typealias Output = GithubRepoModel

    static func translate(_ entity: Input) -> Output {
        let name            = entity.name

        return GithubRepoModel(name: name)
    }
}
