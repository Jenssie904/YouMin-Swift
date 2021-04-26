//
//  YMHomePageViewController.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/6.
//

import UIKit
import RxSwift
import RxCocoa
import JXSegmentedView

class YMHomePageViewController: UIViewController {
    let homePageViewModel : HomePageViewModel = HomePageViewModel()
    let diposeBag:DisposeBag = DisposeBag()
    var visibleCategorys : [ChannelModel]?
    
    fileprivate lazy var segmentedTitleDataSource : JXSegmentedTitleDataSource = {
       let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titleSelectedColor = .black
        dataSource.titleNormalColor = .lightGray
        dataSource.isTitleZoomEnabled = true
        dataSource.titleSelectedZoomScale = 1.3
        dataSource.isTitleStrokeWidthEnabled = true
        dataSource.isSelectedAnimable = true
        let titles = self.visibleCategorys?.map({$0.name}) as! [String]
        dataSource.titles = titles
        return dataSource
    }()
    fileprivate lazy var listContainerView : JXSegmentedListContainerView = {
       return JXSegmentedListContainerView(dataSource: self)
    }()
    
    fileprivate let segmentedView = JXSegmentedView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homePageViewModel.requestData()
        homePageViewModel.dataSourceDriver.skip(1).drive {[weak self] (models:[ChannelModel]) in
            guard let `self` = self else {return}
            self.visibleCategorys = models.filter { (model:ChannelModel) -> Bool in
                return model.isDefaultChannel
            }
            self.setupSegmentedView()
        }.disposed(by: diposeBag)
    }
    
    fileprivate func setupSegmentedView() {
        segmentedView.dataSource = segmentedTitleDataSource
        segmentedView.defaultSelectedIndex = 1
        segmentedView.listContainer = listContainerView
        view.addSubview(segmentedView)
        view.addSubview(listContainerView)
    }
    
    
    //处于第一个item的时候，才允许屏幕边缘手势返回
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
    
    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    //保留顶部50高度的搜索栏
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        segmentedView.frame = CGRect(x: 0, y: 50, width: view.bounds.size.width, height: 50)
        listContainerView.frame = CGRect(x: 0, y: 100, width: view.bounds.size.width, height: view.bounds.size.height - 150)
    }
}

extension YMHomePageViewController : JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if 0 == index {
           return YMHomeAttentionListViewController()
        }else{
            return YMHomeCommonListViewController(index: index)
        }
    }
}

//点击segmentedView item事件
extension YMHomePageViewController : JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedTitleDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}
