//
//  YMHomeCommon1FigureTableCell.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/8.
//  优化代码

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class YMHomeCommon1ImageTableCell: UITableViewCell {
    @IBOutlet weak var newsTitleLabel : UILabel!
    @IBOutlet weak var coverView : UIImageView!
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
            self.coverView.kf.setImage(with: URL(string: thumbnails[0])!, placeholder: UIImage(named: "icon_RankCardBackground_111x52_111x52_"), options: nil, completionHandler: nil)
        }.disposed(by: disposeBag)
    }
    
    public class func CellHeight() -> CGFloat {
        return (((UIScreen.main.bounds.size.width-38.0)/3.0) * (2/3)) + 20.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let _ = cellViewModel else {return}
        
        let screenWidth = UIScreen.main.bounds.size.width
        
        let imageWidth = (screenWidth-38.0)/3.0
        imageWidthConstraint.constant = imageWidth
        
        let titleSize = newsTitleLabel.sizeThatFits(CGSize(width: (screenWidth-imageWidth-35.0), height: 1000.0))
        newsTitleHeightConstraint.constant = titleSize.height
        
        let dateSize = dateLabel.sizeThatFits(CGSize(width: 1000, height: 12))
        dateWidthConstraint.constant = dateSize.width
        
        let commentsSize = commentsLabel.sizeThatFits(CGSize(width: 1000, height: 12))
        commentsWidthConstraint.constant = commentsSize.width
        
        let authorSize = authorLabel.sizeThatFits(CGSize(width: 1000, height: 12))
        authorWidthConstraint.constant = authorSize.width
    }
    
}
