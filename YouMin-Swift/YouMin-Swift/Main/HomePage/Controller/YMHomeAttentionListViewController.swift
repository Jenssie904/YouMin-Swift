//
//  YMHomeSubViewController.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/7.
//

import UIKit
import JXSegmentedView
import RxSwift
import RxCocoa
import SwiftHEXColors

class YMHomeAttentionListViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    fileprivate let viewModel = HomeAttentionListViewModel()
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "YMAttentionAuthorTableCell", bundle: nil), forCellReuseIdentifier: "YMAttentionAuthorTableCellIde")
        
        viewModel.requestData(type: .GetAttention)
        viewModel.attentionAuthorsDriver.skip(1).drive { [weak self] (model:HomeSubListAuthorTableCellViewModel) in
            guard let `self` = self else {return}
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
}

//tableView代理
extension YMHomeAttentionListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return view.bounds.size.height-250.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //加载更多
        let tableHeader = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50.0))
        let titleLabel = UILabel(frame: CGRect(x: 15.0, y: 0, width: UIScreen.main.bounds.size.width-30, height: 50))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.text = "推荐关注"
        tableHeader.addSubview(titleLabel)
        
        let arrowLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width-115.0, y: 0, width: 100.0, height: 50.0))
        arrowLabel.text = "更多 >"
        arrowLabel.font = UIFont.systemFont(ofSize: 16)
        arrowLabel.textAlignment = .right
        arrowLabel.textColor = .gray
        tableHeader.addSubview(arrowLabel)
        
        return tableHeader
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerHeight = view.bounds.size.height-250.0
        let footerWidth = UIScreen.main.bounds.size.width
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: footerWidth, height: footerHeight))
        
        let label = UILabel(frame: CGRect(x: 0, y: footerHeight/2.0-18.0, width: footerWidth, height: 18.0))
        label.text = "登录后可查看关注用户"
        label.textColor = UIColor(hexString: "#333333")
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize:14)
        footerView.addSubview(label)
        
        let button = UIButton(type: .custom)
        button.setTitle("去登录", for: .normal)
        button.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        button.frame = CGRect(x: (footerWidth-80)/2.0, y: footerHeight/2.0+10.0, width: 80, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1/UIScreen.main.scale
        button.layer.borderColor = UIColor(hexString: "#333333")?.cgColor
        button.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
        footerView.addSubview(button)
        
        return footerView
    }
    
    @objc func onLogin(sender:Any) {
        print("去登录...")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YMAttentionAuthorTableCellIde", for: indexPath) as! YMAttentionAuthorTableCell
        cell.bind(viewModel: viewModel.authorsCellViewModels)
        return cell
    }
    
}

//这里应该返回listView
extension YMHomeAttentionListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
