//
//  YMFindGameRecommendSublistViewController.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/27.
//  找游戏推荐列表

import UIKit
import JXSegmentedView

class YMFindGameRecommendSublistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension YMFindGameRecommendSublistViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
