//
//  HomeSubViewModel.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/7.
//  分类列表数据视图模型

import Foundation
import RxCocoa
import RxSwift
import HandyJSON
import Moya

class HomeAttentionListViewModel {
    
    fileprivate var attentionAuthors : BehaviorRelay<HomeSubListAuthorTableCellViewModel> = BehaviorRelay(value: HomeSubListAuthorTableCellViewModel(authorCellViewModels: []))
    public var attentionAuthorsDriver : Driver<HomeSubListAuthorTableCellViewModel> {
        return attentionAuthors.asDriver()
    }
    public var authorsCellViewModels : HomeSubListAuthorTableCellViewModel {
        return attentionAuthors.value
    }
        
    //请求类型
    enum RequestType {
        case GetAttention
    }
    
    public func requestData(type:RequestType) {
        var api:YMHomeApiManager = .GetAttentionList
        var keyPath : String = "result"
        switch type {
        case .GetAttention:
            api = .GetAttentionList
            keyPath = "result"
        }
        
        let observable = YMHomeApiProvider.rx.request(api).asObservable()
        _ = observable.subscribe(onNext: {[weak self]  (response:Moya.Response) in
            guard let `self` = self else {return}
            //这里只能转unicode才能获取到数据，utf8会变成nil WTF???可能string里有转义导致转换失败？？尤其是HTML结构
            guard let jsonStr = String(data: response.data, encoding: .unicode) else {return}
            guard let result = JSONDeserializer<AllAuthors>.deserializeFrom(json: jsonStr, designatedPath: keyPath),let models = result.userInfes else {return}
            
            //遍历数据
            let authorCellViewModels = models.map { (author:AuthorModel) -> HomeAuthorCollectionCellViewModel in
                let clickAttentionEvent = BehaviorRelay(value: author)
                let loadUserPageEvent = BehaviorRelay(value: author)
                return HomeAuthorCollectionCellViewModel(author: author, clickAttentionEvent: clickAttentionEvent, loadUserPageEvent: loadUserPageEvent)
            }
            self.attentionAuthors.accept(HomeSubListAuthorTableCellViewModel(authorCellViewModels: authorCellViewModels))
        })
        
    }
}
