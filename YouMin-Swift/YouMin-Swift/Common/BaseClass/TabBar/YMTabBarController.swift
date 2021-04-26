//
//  YMTabBarController.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/6.
//

import UIKit
import ESTabBarController_swift
import SVProgressHUD

class YMTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //初始化代码
        setupTabBarItems()
    }

    fileprivate func setupTabBarItems() {
        
        if let tabBar = self.tabBar as? ESTabBar {
            tabBar.itemCustomPositioning = .fillIncludeSeparator
        }
        
        tabBar.barTintColor = .white
        
        let homePageController =  YMHomePageViewController()
        homePageController.title = "首页"
        homePageController.tabBarItem = ESTabBarItem(YMFMIrregularityBasicContentView(), title: nil, image: UIImage(named: "icon_NewsModule_30x36_30x36_"), selectedImage: UIImage(named: "icon_NewsModule_30x36_Selected_30x36_"), tag: 10)
        let homeNavigationController = YMNavigationController(rootViewController: homePageController)
        homeNavigationController.isNavigationBarHidden = true
        
        let findGameController = YMFindGameViewController()
        findGameController.title = "找游戏"
        findGameController.tabBarItem = ESTabBarItem(YMFMIrregularityBasicContentView(), title: nil, image: UIImage(named: "icon_GameLibraryModule_30x36_30x36_"), selectedImage: UIImage(named: "icon_GameLibraryModule_30x36_Selected_30x36_"), tag: 11)
        let gameNavigationController = YMNavigationController(rootViewController: findGameController)
//        gameNavigationController.isNavigationBarHidden = true
        
        let checkRaidersController = YMCheckRaidersViewController()
        checkRaidersController.title = "查攻略"
        checkRaidersController.tabBarItem = ESTabBarItem(YMFMIrregularityBasicContentView(), title: nil, image: UIImage(named: "icon_StrategyModule_30x36_30x36_"), selectedImage: UIImage(named: "icon_StrategyModule_30x36_Selected_30x36_"), tag: 12)
        let raidersNavigationController = YMNavigationController(rootViewController: checkRaidersController)
        raidersNavigationController.isNavigationBarHidden = true
        
        let circleController = YMCircleViewController()
        circleController.title = "圈子"
        circleController.tabBarItem = ESTabBarItem(YMFMIrregularityBasicContentView(), title: nil, image: UIImage(named: "icon_ClubModule_30x36_30x36_"), selectedImage: UIImage(named: "icon_ClubModule_30x36_Selected_30x36_"), tag: 13)
        let circleNavigationController = YMNavigationController(rootViewController: circleController)
        circleNavigationController.isNavigationBarHidden = true
        
        let userPageController = YMUserPageViewController()
        userPageController.title = "我的"
        userPageController.tabBarItem = ESTabBarItem(YMFMIrregularityBasicContentView(), title: nil, image: UIImage(named: "icon_UserCenterModule_30x36_30x36_"), selectedImage: UIImage(named: "icon_UserCenterModule_30x36_Selected_30x36_"), tag: 14)
        let userNavigationController = YMNavigationController(rootViewController: userPageController)
        userNavigationController.isNavigationBarHidden = true
        
        self.viewControllers = [homeNavigationController,gameNavigationController,raidersNavigationController,circleNavigationController,userNavigationController]
    }
}
