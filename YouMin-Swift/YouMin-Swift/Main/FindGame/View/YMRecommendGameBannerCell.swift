//
//  YMRecommendGameBannerCell.swift
//  YouMin-Swift
//
//  Created by admin on 2021/5/12.
//

import UIKit
import FSPagerView
import RxSwift
import RxCocoa
import Kingfisher

class YMRecommendGameBannerCell: UITableViewCell {
    
    fileprivate var models : [GameRecommendBannerModel] = []
    
    @IBOutlet weak var pagerView : FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.automaticSlidingInterval = 3.0
            let width = UIScreen.main.bounds.width
            self.pagerView.itemSize = CGSize(width: (width-70.0), height: 120)
            self.pagerView.interitemSpacing = 15.0
        }
    }
    
    //数据绑定
    public func bindViewModel(viewModel:FindGameRecommendBannerCellViewModel){
        models = viewModel.models
        pagerView.reloadData()
    }
}

//继承banner代理
extension YMRecommendGameBannerCell : FSPagerViewDelegate,FSPagerViewDataSource {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return models.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        
        guard let urlStr = models[index].thumbnailURLs?.last,let imageURL = URL(string: urlStr) else {return cell}
        
        cell.imageView?.kf.setImage(with: imageURL, placeholder: UIImage(named: "icon_UserHeadImage_34x34_37x37_"), options: nil, completionHandler: nil)
        return cell
    }
}
