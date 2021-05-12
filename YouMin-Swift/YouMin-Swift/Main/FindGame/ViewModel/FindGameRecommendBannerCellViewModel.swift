//
//  FindGameRecommendBannerCellViewModel.swift
//  YouMin-Swift
//
//  Created by admin on 2021/5/12.
//  推荐列表banner cell ViewModel

import Foundation

class FindGameRecommendBannerCellViewModel {
    var models : [GameRecommendBannerModel]
    
    init(cellViewModels:[GameRecommendBannerModel]) {
        models = cellViewModels
    }
}
