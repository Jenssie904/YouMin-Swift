//
//  YMNavigationController.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/6.
//

import UIKit

class YMNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func pushViewController(_ viewController:UIViewController,animated:Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        } else {
            viewController.hidesBottomBarWhenPushed = false
        }
        super .pushViewController(viewController, animated: animated)
    }
    
    

}
