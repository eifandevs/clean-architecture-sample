//
//  SearchViewControllerBuilder.swift
//  clean-architecture-sample
//
//  Created by iori tenma on 2020/10/19.
//  Copyright © 2020 iori tenma. All rights reserved.
//

import Foundation

struct SearchViewControllerBuilder: ViewControllerBuilder {
    typealias ViewController = SearchViewController

    static func build() -> ViewController {
        let dataStore = GithubRepoDataStoreImpl()
        let repository = GithubRepositoryImpl(dataStore: dataStore)
        let usecase = SearchUseCaseImpl(repository: repository)
        let presenter = SearchViewPresenterImpl(usecase: usecase)
        let viewController = SearchViewController(presenter: presenter)

        return viewController
    }
}
