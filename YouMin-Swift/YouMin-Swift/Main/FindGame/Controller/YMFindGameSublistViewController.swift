//
//  YMFindGameSublistViewController.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/26.
//  只能直接显示这个sublist了 ？

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
                
        tableView.register(UINib(nibName: "FindGameTableViewCell", bundle: nil), forCellReuseIdentifier: "FindGameTableViewCellIde")
        gameSublistViewModel.requestData(channelIndex: channelIndex, categoryIndex: categoryIndex)
        gameSublistViewModel.dataSourceDriver.skip(1).drive {[weak self] (cellViewModels: [FindGameSublistCellViewModel]) in
            guard let `self` = self else {return}
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
}

extension YMFindGameSublistViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameSublistViewModel.dataSource.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindGameTableViewCellIde", for: indexPath) as! FindGameTableViewCell
        cell.bindViewModel(viewModel: gameSublistViewModel.dataSource[indexPath.row])
        return cell
    }
}


extension YMFindGameSublistViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
