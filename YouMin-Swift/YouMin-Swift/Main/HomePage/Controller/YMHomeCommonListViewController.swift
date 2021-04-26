//
//  YMHomeCommonListViewController.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/8.
//

import UIKit
import JXSegmentedView
import RxSwift
import RxCocoa

class YMHomeCommonListViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    private let viewModel = HomeCommonListViewModel()
    private var curIndex : Int = 1
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "YMHomeCommon1ImageTableCell", bundle: nil), forCellReuseIdentifier: "YMHomeCommon1ImageTableCellIde")
        tableView.register(UINib(nibName: "YMHomeCommon3ImageTableCell", bundle: nil), forCellReuseIdentifier: "YMHomeCommon3ImageTableCellIde")
        
        viewModel.requestData(type: HomeCommonListViewModel.RequestType(rawValue: curIndex) ?? .GetHeadline)
        viewModel.newsListDriver.skip(1).drive {[weak self] (cellViewModels:[HomeCommonCellViewModel]) in
            guard let `self` = self else {return}
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    init(index:Int) {
        curIndex = index
        super.init(nibName: "YMHomeCommonListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//继承协议
extension YMHomeCommonListViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isOnly1Image = viewModel.newsArray[indexPath.row].news.thumbnails?.count == 1
        return isOnly1Image ? YMHomeCommon1ImageTableCell.CellHeight() : YMHomeCommon3ImageTableCell.CellHeight(model: viewModel.newsArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isOnly1Image = viewModel.newsArray[indexPath.row].news.thumbnails?.count == 1
        let identifier = isOnly1Image ? "YMHomeCommon1ImageTableCellIde" : "YMHomeCommon3ImageTableCellIde"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if isOnly1Image {
            let Only1ImgCell = cell as! YMHomeCommon1ImageTableCell
            Only1ImgCell.bind(model: viewModel.newsArray[indexPath.row])
        } else {
            let moreImgCell = cell as! YMHomeCommon3ImageTableCell
            moreImgCell.bind(model: viewModel.newsArray[indexPath.row])
        }
        return cell
    }

    //卡片被点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("新闻卡片被点击")
    }

}

//这里应该返回listView
extension YMHomeCommonListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
