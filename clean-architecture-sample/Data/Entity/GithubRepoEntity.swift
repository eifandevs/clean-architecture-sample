//
//  GithubRepoEntity.swift
//  clean-architecture-sample
//
//  Created by iori tenma on 2020/10/21.
//  Copyright © 2020 iori tenma. All rights reserved.
//

import Foundation

struct GithubReposEntity: Codable {
    let count: Int
    let repos: [GithubRepoEntity]
}

struct GithubRepoEntity: Codable {
    let name: String
}

