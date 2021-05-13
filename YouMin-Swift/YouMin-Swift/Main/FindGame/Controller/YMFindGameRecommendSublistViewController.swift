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
            guard let `self` = self else {return}
            self.recommendTableView.reloadData()
        }.disposed(by: disposeBag)
    
        //注册卡片
        recommendTableView.register(UINib(nibName: "YMRecommendGameHeaderTableCell", bundle: nil), forCellReuseIdentifier: "YMRecommendGameHeaderTableCell")
        recommendTableView.register(UINib(nibName: "YMRecommendGameTableCell", bundle: nil), forCellReuseIdentifier: "YMRecommendGameTableCell")
        recommendTableView.register(UINib(nibName: "YMRecommendGameBannerCell", bundle: nil), forCellReuseIdentifier: "YMRecommendGameBannerCell")
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
        return findGameRecommendViewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if 0 == indexPath.row {
            return 100.0
        }else if 1 == indexPath.row {
            return 406.0
        } else if 2 == indexPath.row {
            return 150.0
        } else {
            return 44.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var rescell : UITableViewCell = UITableViewCell()
        if 0 == indexPath.row {
            rescell = tableView.dequeueReusableCell(withIdentifier: "YMRecommendGameHeaderTableCell", for: indexPath)
        } else if 1 == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YMRecommendGameTableCell", for: indexPath) as! YMRecommendGameTableCell
            cell.bindViewModel(viewModel: findGameRecommendViewModel.dataSource[indexPath.row] as! FindGameRecommendCellViewModel)
            rescell = cell
        } else if 2 == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YMRecommendGameBannerCell", for: indexPath) as! YMRecommendGameBannerCell
            cell.bindViewModel(viewModel: findGameRecommendViewModel.dataSource[indexPath.row] as! FindGameRecommendBannerCellViewModel)
            rescell = cell
        }
        return rescell
    }
}

