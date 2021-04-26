//
//  YMHomeCommon3FigureTableCell.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/8.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class YMHomeCommon3ImageTableCell: UITableViewCell {
    
    @IBOutlet weak var newsTitleLabel : UILabel!
    @IBOutlet weak var leftImageView : UIImageView!
    @IBOutlet weak var midImageView : UIImageView!
    @IBOutlet weak var rightImageView : UIImageView!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var commentsLabel : UILabel!
    @IBOutlet weak var authorLabel : UILabel!
    
    @IBOutlet weak var newsTitleHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var imageWidthConstraint : NSLayoutConstraint!
    @IBOutlet weak var dateWidthConstraint : NSLayoutConstraint!
    @IBOutlet weak var commentsWidthConstraint : NSLayoutConstraint!
    @IBOutlet weak var authorWidthConstraint : NSLayoutConstraint!
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate var cellViewModel : HomeCommonCellViewModel?
    
    //数据绑定
    public func bind(model:HomeCommonCellViewModel) {
        cellViewModel = model
        model.newsTitle.drive(newsTitleLabel.rx.text).disposed(by: disposeBag)
        model.date.drive(dateLabel.rx.text).disposed(by: disposeBag)
        model.commentsCount.drive(commentsLabel.rx.text).disposed(by: disposeBag)
        model.authorName.drive {[weak self] (name:String) in
            guard let `self` = self else {return}
            self.authorLabel.text = name
            self.authorLabel.isHidden = (name == "未知")
        }.disposed(by: disposeBag)
        
        //仅取前面三个防止数据错误
        model.thumbnails.subscribe{[weak self] (thumbnails:[String]) in
            guard let `self` = self else {return}
            let imageViews = [self.leftImageView,self.midImageView,self.rightImageView]
            for index in 0..<imageViews.count {
                let imageView = imageViews[index]
                if index < thumbnails.count {
                    imageView?.isHidden = false
                    imageView?.kf.setImage(with: URL(string: thumbnails[index])!, placeholder: UIImage(named: "icon_RankCardBackground_111x52_111x52_"), options: nil, completionHandler: nil)
                }else{
                    imageView?.isHidden = true
                }
            }
        }.disposed(by: disposeBag)

    }
    
    //这种方案效率会比较低，重复计算，滑动卡顿
    public class func CellHeight(model:HomeCommonCellViewModel) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        let maxSize = CGSize(width: (screenWidth-30.0), height: 1000.0)
        let titleHeight = NSString(string: model.news.Title ?? "").boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], context: nil).size.height
        let imageHeight = ((screenWidth-38.0)/3.0) * (2/3)
        return titleHeight + imageHeight + 53.0
    }
    
    
    //这种方案效率会比较低，重复计算，滑动卡顿
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let _ = cellViewModel else {return}
        
        let screenWidth = UIScreen.main.bounds.size.width
        let titleSize = newsTitleLabel.sizeThatFits(CGSize(width: (screenWidth-30.0), height: 1000))
        newsTitleHeightConstraint.constant = titleSize.height
        
        let imageWidth = (screenWidth-38.0)/3.0
        imageWidthConstraint.constant = imageWidth
        
        let dateSize = dateLabel.sizeThatFits(CGSize(width: 1000, height: 12))
        dateWidthConstraint.constant = dateSize.width
        
        let commentsSize = commentsLabel.sizeThatFits(CGSize(width: 1000, height: 12))
        commentsWidthConstraint.constant = commentsSize.width
        
        let authorSize = authorLabel.sizeThatFits(CGSize(width: 1000, height: 12))
        authorWidthConstraint.constant = authorSize.width
    }
}
