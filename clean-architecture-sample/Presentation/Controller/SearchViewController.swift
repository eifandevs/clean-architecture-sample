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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let mySearchBar = UISearchBar()
//        mySearchBar.delegate = self　//UISearchBarDelegate
        mySearchBar.showsCancelButton = true
        mySearchBar.placeholder = "会社への不満を入力して下さい"
        self.view.addSubview(mySearchBar)
                
        mySearchBar.snp.makeConstraints { make in
            make.height.equalTo(80.0)
            make.top.right.left.equalTo(0)
        }
        
        self.view.backgroundColor = UIColor.red
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
