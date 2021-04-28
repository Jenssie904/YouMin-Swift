//
//  FindGameTableViewCell.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/28.
//  没有类似点赞数据增加立即刷新到界面的互动操作所以不设置CellViewModel

import UIKit

class FindGameTableViewCell: UITableViewCell {
    @IBOutlet weak var rightDivlineWidthContraint       : NSLayoutConstraint!
    @IBOutlet weak var bottomDivlineHeightContraint     : NSLayoutConstraint!
    @IBOutlet weak var starViewWidthContraint           : NSLayoutConstraint!
    @IBOutlet weak var gameTagLabelHeightContraint      : NSLayoutConstraint!
    @IBOutlet weak var priceViewWidthContraint          : NSLayoutConstraint!
    
    @IBOutlet weak var coverView        : UIImageView!
    @IBOutlet weak var gameTitleLabel   : UILabel!
    @IBOutlet weak var starView         : UIView!
    @IBOutlet weak var wantPlayLabel    : UILabel!
    @IBOutlet weak var gameTagLabel     : UILabel!
    @IBOutlet weak var priceLabel       : UILabel!
    @IBOutlet weak var lowestPriceView  : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rightDivlineWidthContraint.constant = 1.0/UIScreen.main.scale
        bottomDivlineHeightContraint.constant = 1.0/UIScreen.main.scale
    }

    //viewModel 绑定
    public func bindViewModel(viewModel:FindGameSublistViewModel) {
        
    }
    
    
}
