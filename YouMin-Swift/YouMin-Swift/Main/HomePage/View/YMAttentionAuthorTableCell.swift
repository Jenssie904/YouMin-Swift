//
//  YMAttentionAuthorTableCell.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/7.
//

import UIKit
import RxSwift
import RxCocoa

class YMAttentionAuthorTableCell: UITableViewCell {
    @IBOutlet weak var collectionView : UICollectionView!
    
    //创建垃圾袋
    fileprivate let disposeBag = DisposeBag()
    fileprivate var curViewModel : HomeSubListAuthorTableCellViewModel?
    
    //推荐关注          更多 >
    //作者卡片
    //登录
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "YMAuthorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "YMAuthorCollectionViewCellIde")
    }
    
    //数据绑定
    public func bind(viewModel:HomeSubListAuthorTableCellViewModel) {
        curViewModel = viewModel
        viewModel.authors.share().subscribeOn(MainScheduler.instance).subscribe {[weak self] (authors : [HomeAuthorCollectionCellViewModel]) in
            guard let `self` = self else {return}
            self.collectionView.reloadData()
        }.disposed(by: disposeBag)
    }
}

//设置collection代理
extension YMAttentionAuthorTableCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let array = curViewModel?.dataSource else {return 0}
        return array.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120.0, height: 200.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.init(top: 0.0, left: 15, bottom: 0.0, right: 15)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YMAuthorCollectionViewCellIde", for: indexPath) as! YMAuthorCollectionViewCell
        guard let model = curViewModel?.dataSource[indexPath.row] else {return UICollectionViewCell()}
        cell.bind(viewModel: model)
        return cell
    }
    
}
