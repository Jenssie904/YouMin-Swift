//
//  HomeCommonCellViewModel.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/8.
//

import Foundation
import RxSwift
import RxCocoa

class HomeCommonCellViewModel {
    fileprivate var newsBehavior : BehaviorRelay<NewsModel>
    public var news : NewsModel {
        return newsBehavior.value
    }
    
    init(model:NewsModel) {
        newsBehavior = BehaviorRelay(value: model)
    }
}

extension HomeCommonCellViewModel {
    public var newsDriver : Driver<NewsModel> {
        return newsBehavior.asDriver()
    }
    public var newsObservable : Observable<NewsModel> {
        return newsBehavior.share().asObservable()
    }

    //界面绑定
    public var newsTitle : Driver<String> {
        return newsDriver.map {$0.Title ?? ""}.asDriver()
    }
    public var date : Driver<String> {
        return newsDriver.map {$0.updateTime ?? ""}.asDriver()
    }
    public var commentsCount : Driver<String> {
        return newsDriver.map{"\($0.commentsCount)评论"}.asDriver()
    }
    public var authorName : Driver<String> {
        return newsDriver.map{"\($0.Author ?? "")"}.asDriver()
    }
    public var thumbnails : Observable<[String]> {
        return newsObservable.map { $0.thumbnails ?? []}.asObservable()
    }
}
