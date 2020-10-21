//
//  GitHubRepoModel.swift
//  clean-architecture-sample
//
//  Created by iori tenma on 2020/10/21.
//  Copyright © 2020 iori tenma. All rights reserved.
//

import Foundation

struct GithubReposModel {
    let count: Int
    let items: [GithubRepoModel]
}

struct GithubRepoModel {
    let name: String
}
