//
//  FindGameTableViewCell.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/28.
//  没有类似点赞数据增加立即刷新到界面的互动操作所以不设置CellViewModel

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class FindGameTableViewCell: UITableViewCell {
    @IBOutlet weak var rightDivlineWidthContraint       : NSLayoutConstraint!
    @IBOutlet weak var bottomDivlineHeightContraint     : NSLayoutConstraint!
    @IBOutlet weak var starViewWidthContraint           : NSLayoutConstraint!
    @IBOutlet weak var gameTagLabelHeightContraint      : NSLayoutConstraint!
    @IBOutlet weak var priceViewWidthContraint          : NSLayoutConstraint!
    
    @IBOutlet weak var coverView        : UIImageView!
    @IBOutlet weak var gameTitleLabel   : UILabel!
    @IBOutlet weak var starView         : UIView!
    @IBOutlet weak var starText         : UILabel!
    @IBOutlet weak var wantPlayLabel    : UILabel!
    @IBOutlet weak var gameTagLabel     : UILabel!
    @IBOutlet weak var priceLabel       : UILabel!
    @IBOutlet weak var lowestPriceView  : UIView!
    
    fileprivate let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rightDivlineWidthContraint.constant = 1.0/UIScreen.main.scale
        bottomDivlineHeightContraint.constant = 1.0/UIScreen.main.scale
    }

    //viewModel 绑定
    public func bindViewModel(viewModel:FindGameSublistCellViewModel) {
        viewModel.coverUrl.subscribe {[weak self] (url:URL?) in
            guard let `self` = self else {return}
            guard let imageURL = url else {return}
            self.coverView.kf.setImage(with: imageURL, placeholder: UIImage(named: ""), options: nil, completionHandler: nil)
        }.disposed(by: disposeBag)

        viewModel.title.drive(gameTitleLabel.rx.text).disposed(by: disposeBag)
        
        //监听操作放在主线程中
        viewModel.gsScore.subscribeOn(MainScheduler.instance).subscribe {[weak self] (score:Float) in
            guard let `self` = self else {return}
            self.starView.isHidden = 0.0==score ? true : false
            self.starText.isHidden = 0.0==score ? true : false
            self.wantPlayLabel.isHidden = 0.0==score ? false : true
            self.starViewWidthContraint.constant = CGFloat(score/10.0)*54.0
            self.starText.text = "\(score)"
        }.disposed(by: disposeBag)

        //多少人想玩,上面已经控制显示隐藏了，所以这里只要显示即可
        viewModel.wantPlay.drive(wantPlayLabel.rx.text).disposed(by: disposeBag)
        //标签
        viewModel.gameTag.drive(gameTagLabel.rx.text).disposed(by:disposeBag)
        //价格
        viewModel.price.drive(priceLabel.rx.attributedText).disposed(by:disposeBag)
        
        priceViewWidthContraint.constant = priceLabel.sizeThatFits(CGSize(width: 1000, height: 15)).width + 10.0
    }
}
