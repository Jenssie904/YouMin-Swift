//
//  FindGameRecommendCellViewModel.swift
//  YouMin-Swift
//
//  Created by admin on 2021/5/12.
//  这里可直接使用cellViewModel视图模型

import Foundation
import RxSwift
import RxCocoa
import Moya
import HandyJSON

class FindGameRecommendCellViewModel {
    var models : [FindGameSublistCellViewModel]
    
    init(cellViewModels : [FindGameSublistCellViewModel]) {
        models = cellViewModels
    }
}

