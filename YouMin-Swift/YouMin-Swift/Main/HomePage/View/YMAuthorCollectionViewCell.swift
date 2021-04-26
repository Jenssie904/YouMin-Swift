//
//  YMAuthorCollectionViewCell.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/8.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class YMAuthorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var avatarView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var fansLabel : UILabel!
    
    fileprivate var curViewModel : HomeAuthorCollectionCellViewModel?
    fileprivate let disposeBag = DisposeBag()
    
    
    override func awakeFromNib() {
        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 1/UIScreen.main.scale
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    //绑定数据
    public func bind(viewModel:HomeAuthorCollectionCellViewModel) {
        curViewModel = viewModel
        viewModel.avatarThumb.bind { [weak self] in
            guard let `self` = self else { return }
            guard let url = $0,let avatarURL = URL(string: url) else { return }
            self.avatarView.kf.setImage(with: avatarURL, placeholder: UIImage(named: "image_UserHeadImage_36x36_36x36_"), options: nil, completionHandler: nil)
        }.disposed(by: disposeBag)
        viewModel.fansCountDriver.drive(fansLabel.rx.text).disposed(by: disposeBag)
        viewModel.nameDriver.drive(nameLabel.rx.text).disposed(by: disposeBag)
    }
    
    //绑定点击事件
    @IBAction func onAttention(sender:Any) {
        guard let author = curViewModel?.clickAttentionEvent.value else {return}
        curViewModel?.clickAttentionEvent.accept(author)
    }
    
}
