//
//  AttentionAuthorCellViewModel.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/7.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import HandyJSON

//tableViewCell卡片数据类型
class HomeSubListAuthorTableCellViewModel {
    public var authors : BehaviorRelay<[HomeAuthorCollectionCellViewModel]>
    public var dataSource : [HomeAuthorCollectionCellViewModel] {
        return authors.value
    }
    
    init(authorCellViewModels:[HomeAuthorCollectionCellViewModel]) {
        self.authors = BehaviorRelay(value: authorCellViewModels)
    }
}
