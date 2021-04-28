//
//  YMFindGameSublistViewController.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/26.
//

import UIKit
import JXSegmentedView
import RxSwift
import RxCocoa

class YMFindGameSublistViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    let gameSublistViewModel    = FindGameSublistViewModel()
    let disposeBag              = DisposeBag()
    var channelIndex : Int      = 0
    var categoryIndex : Int     = 0
    
    
    init(channelIndex:Int,categoryIndex:Int) {
        super.init(nibName: "YMFindGameSublistViewController", bundle: nil)
        self.channelIndex = channelIndex
        self.categoryIndex = categoryIndex
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameSublistViewModel.requestData(channelIndex: channelIndex, categoryIndex: categoryIndex)
        gameSublistViewModel.dataSourceDriver.skip(1).drive { [weak self] (games:[GameModel]) in
            guard let `self` = self else {return}
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
}




extension YMFindGameSublistViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
