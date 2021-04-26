//
//  YMAuthorViewModel.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/7.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import HandyJSON


//单个作者卡片类型
class HomeAuthorCollectionCellViewModel {
    
    //BehaviorRelay主要用于数据交换和事件处理/传递
    fileprivate var author : BehaviorRelay<AuthorModel>
    //点击了头像
    public var loadUserPageEvent : BehaviorRelay<AuthorModel>
    //点击了关注
    public var clickAttentionEvent : BehaviorRelay<AuthorModel>
    
    //初始化
    init(author : AuthorModel,clickAttentionEvent:BehaviorRelay<AuthorModel>,loadUserPageEvent:BehaviorRelay<AuthorModel>) {
        self.author                 = BehaviorRelay(value:author)
        self.loadUserPageEvent      = loadUserPageEvent
        self.clickAttentionEvent    = clickAttentionEvent
    }
}

extension HomeAuthorCollectionCellViewModel {
    public var authorObserver : Observable<AuthorModel> {
        return author.asObservable()
    }
    public var authorDriver : Driver<AuthorModel> {
        return author.asDriver()
    }
    public var nameDriver : Driver<String> {
        return authorDriver.map {$0.userName ?? ""}.asDriver()
    }
    public var fansCountDriver : Driver<String> {
        return authorDriver.map{"\($0.fansCount)粉丝" }.asDriver()
    }
    public var avatarThumb : Observable<String?> {
        return authorDriver.map {
            guard let url = $0.userHeadImageUrl else {return nil}
            return url
        }.asObservable()
    }
}

