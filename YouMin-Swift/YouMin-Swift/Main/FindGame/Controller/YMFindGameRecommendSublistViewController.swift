//
//  YMFindGameRecommendSublistViewController.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/27.
//  找游戏推荐列表

import UIKit
import JXSegmentedView

class YMFindGameRecommendSublistViewController: UIViewController {
    
    @IBOutlet weak var recommendTableView : UITableView!
    
    let findGameRecommendViewModel = FindGameRecommendChildViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findGameRecommendViewModel.requestData()
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

