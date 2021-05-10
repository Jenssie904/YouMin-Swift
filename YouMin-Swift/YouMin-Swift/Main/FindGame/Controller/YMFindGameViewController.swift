//
//  YMFindGameViewController.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/6.
//  找游戏

import UIKit
import JXSegmentedView

class YMFindGameViewController: UIViewController {
    let segmentedDataSource = JXSegmentedTitleDataSource()
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default )
        navigationController?.navigationBar.shadowImage = UIImage()
                
        let titles = ["推荐","PC","PS5","XSX","PS4","NS","XBONE"];
        segmentedDataSource.itemWidth = 50.0
        segmentedDataSource.titles = titles
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedDataSource.isTitleZoomEnabled = true
        segmentedDataSource.titleSelectedZoomScale = 1.3
        segmentedDataSource.titleNormalColor = .gray
        segmentedDataSource.titleSelectedColor = .black
        segmentedDataSource.titleSelectedFont = .boldSystemFont(ofSize: 18)
        segmentedDataSource.titleNormalFont = .systemFont(ofSize: 16)
        segmentedDataSource.itemSpacing = 2
        
        segmentedView.contentEdgeInsetLeft = 15.0
        segmentedView.contentEdgeInsetRight = 15.0
        segmentedView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30)
        segmentedView.dataSource = segmentedDataSource
        navigationItem.titleView = segmentedView

        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listContainerView.frame = view.bounds
    }
}

extension YMFindGameViewController : JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return 7
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        if 0 == index {
            return YMFindGameRecommendSublistViewController(nibName: "YMFindGameRecommendSublistViewController", bundle: nil)
        } else {
            let array = 1==index ? ["近期热度","当前在线","评分最高","最新上市","即将上市"] : ["近期热度","评分最高","最新上市","即将上市"]
            return YMFindGameChildViewController(sometitles: array,channelIndex: index)
        }
    }
}
