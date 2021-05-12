//
//  YMFindGameRecommendSublistViewController.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/27.
//  找游戏推荐列表 游戏推荐列表

import UIKit
import RxCocoa
import RxSwift
import JXSegmentedView

class YMFindGameRecommendSublistViewController: UIViewController {
    
    @IBOutlet weak var recommendTableView : UITableView!
    let disposeBag = DisposeBag()   //创建垃圾袋
    
    let findGameRecommendViewModel = FindGameRecommendChildViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findGameRecommendViewModel.requestData()
        findGameRecommendViewModel.dataSourceDriver.skip(1).drive {[weak self]  (dataSource:[Any]) in
            guard let `self` = self  else {return}
            
        }.disposed(by: disposeBag)
    }
    
}

extension YMFindGameRecommendSublistViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

//tableView代理函数
extension YMFindGameRecommendSublistViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

