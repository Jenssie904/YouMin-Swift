//
//  YMFindGameChildViewController.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/26.
//  这个不显示到前面了？

import UIKit
import JXSegmentedView

class YMFindGameChildViewController: UIViewController {
    var titles              = [String]()
    var channelIndex : Int  = 0             //频道名称
    let segmentedDataSource = JXSegmentedTitleDataSource()
    let segmentedView       = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegment()
    }
    
    //初始化界面
    init(sometitles : [String],channelIndex:Int) {
        super.init(nibName: nil, bundle: nil)
        self.channelIndex   = channelIndex
        self.titles         = sometitles
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSegment() {
        view.backgroundColor = .black
        //配置数据源
        segmentedDataSource.titleNormalColor = .gray
        segmentedDataSource.titleSelectedColor = .black
        segmentedDataSource.titleSelectedFont = .systemFont(ofSize: 16)
        segmentedDataSource.titleNormalFont = .systemFont(ofSize: 16)
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedDataSource.titles = titles
        
        //配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorHeight = 1.0/UIScreen.main.scale
        indicator.indicatorColor = .black
        indicator.indicatorWidth = 30
        indicator.verticalOffset = 5.0

        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedView.dataSource = segmentedDataSource
        segmentedView.indicators = [indicator]
        segmentedView.frame = CGRect(x: 0, y: 64, width: view.bounds.size.width, height: 40)
        //视图置顶
        view.addSubview(segmentedView)
        
        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listContainerView.frame = CGRect(x: 0, y: 50, width: view.bounds.size.width, height: view.bounds.size.height - 50)
    }
}

//不能显示当前view ？why
extension YMFindGameChildViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

extension YMFindGameChildViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return YMFindGameSublistViewController(channelIndex: channelIndex, categoryIndex: index)
    }
}

