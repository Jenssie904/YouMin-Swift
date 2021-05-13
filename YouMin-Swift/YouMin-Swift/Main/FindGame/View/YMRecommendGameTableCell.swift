//
//  YMRecommendGameTableCell.swift
//  YouMin-Swift
//
//  Created by admin on 2021/5/11.
//  推荐游戏卡片 推荐游戏卡片

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class YMRecommendGameTableCell: UITableViewCell {

    @IBOutlet weak var itemWidthContraint : NSLayoutConstraint!
    
    @IBOutlet weak var score0ViewWidthContraint : NSLayoutConstraint!
    @IBOutlet weak var score1ViewWidthContraint : NSLayoutConstraint!
    @IBOutlet weak var score2ViewWidthContraint : NSLayoutConstraint!
    @IBOutlet weak var score3ViewWidthContraint : NSLayoutConstraint!
    @IBOutlet weak var score4ViewWidthContraint : NSLayoutConstraint!
    @IBOutlet weak var score5ViewWidthContraint : NSLayoutConstraint!

    var coverViews : [UIImageView]  = []
    var gameNameLabels : [UILabel]  = []
    var scoreLabels : [UILabel]     = []
    
    let disposeBag                  = DisposeBag()
    
    //界面初始化
    override func awakeFromNib() {
        super.awakeFromNib()

        for i in 1...6 {
            let view = self.viewWithTag(i)!
            
            let coverView = view.viewWithTag(10) as! UIImageView
            coverViews.append(coverView)

            let gameNameLabel = view.viewWithTag(11) as! UILabel
            gameNameLabels.append(gameNameLabel)
            
            let scoreLabel = view.viewWithTag(12) as! UILabel
            scoreLabels.append(scoreLabel)
        }

        //单个卡片的宽度
        itemWidthContraint.constant = (UIScreen.main.bounds.size.width-60.0)/3.0
    }
    
    //绑定视图模型 数据模型有可能多于或者少于6个，代码区分
    public func bindViewModel(viewModel:FindGameRecommendCellViewModel){
        for i in 0...5 {
            if i < viewModel.models.count {
                let model = viewModel.models[i]
                
                let coverView = coverViews[i]
                model.coverUrl.subscribe {(url:URL?) in
                    guard let imageURL = url else {return}
                    coverView.kf.setImage(with: imageURL, placeholder: UIImage(named: "icon_UserHeadImage_34x34_37x37_"), options: nil, completionHandler: nil)
                }.disposed(by: disposeBag)
                
                let gameNameLabel = gameNameLabels[i]
                model.title.drive(gameNameLabel.rx.text).disposed(by: disposeBag)
                
                //显示评分比率
                model.gsScore.subscribeOn(MainScheduler.instance).subscribe {[weak self] (score:Float) in
                    guard let `self` = self else {return}
                    
                    if 0 == i {
                        self.score0ViewWidthContraint.constant = CGFloat(score/10.0)*54.0
                    } else if 1 == i {
                        self.score1ViewWidthContraint.constant = CGFloat(score/10.0)*54.0
                    } else if 2 == i {
                        self.score2ViewWidthContraint.constant = CGFloat(score/10.0)*54.0
                    } else if 3 == i {
                        self.score3ViewWidthContraint.constant = CGFloat(score/10.0)*54.0
                    } else if 4 == i {
                        self.score4ViewWidthContraint.constant = CGFloat(score/10.0)*54.0
                    } else if 5 == i {
                        self.score5ViewWidthContraint.constant = CGFloat(score/10.0)*54.0
                    }
                    
                    let starTextLabel = self.scoreLabels[i]
                    starTextLabel.text = "\(score)"
                }.disposed(by: disposeBag)
                
                
                self.viewWithTag(i+1)?.isHidden = false
            } else {
                self.viewWithTag(i+1)?.isHidden = true
            }
        }
    }
    
    //点击item
    @IBAction func clickItems(button:UIButton) {
        let tag = button.tag
        print("========点击了第 \(tag) 个item")
    }
    
    //点击查看更多
    @IBAction func clickMore() {
        print("点击了查看更多按钮+++++++++++++++++++++")
    }
}
