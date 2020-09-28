//
//  SearchViewController.swift
//  clean-architecture-sample
//
//  Created by iori tenma on 2020/09/15.
//  Copyright © 2020 iori tenma. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.backgroundColor = UIColor.lightGray
        searchBar.placeholder = "検索ワードを入力してください"
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInset = UIEdgeInsets.zero
        tableView.estimatedRowHeight = 30.0
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    private let presenter: SearchViewPresenterType
    
    private let disposeBag = DisposeBag()

    init(presenter: SearchViewPresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        
        self.contentStackView.addArrangedSubview(self.searchBar)
        self.contentStackView.addArrangedSubview(self.tableView)
        self.view.addSubview(contentStackView)
                
        self.contentStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.right.left.equalToSuperview()
        }
        self.searchBar.snp.makeConstraints { make in
            make.height.equalTo(80.0)
            make.right.left.equalToSuperview()
        }
        self.tableView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
        }
        
        self.searchBar.rx.text
            .bind(to: self.presenter.inputs.searchText)
            .disposed(by: disposeBag)
        
        self.searchBar.rx.text.orEmpty
        .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .flatMap { text -> Observable<String> in
            guard text.count > 2 else {
                return .empty()
            }
            return .just(text)
        }.subscribe { e in
            if let text = e.element {
//                self.presenter.inputs.searchText.accept(text)
            }
        }.disposed(by: disposeBag)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
