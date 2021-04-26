//
//  YMFindGameSublistViewController.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/26.
//

import UIKit
import JXSegmentedView

class YMFindGameSublistViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension YMFindGameSublistViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
