//
//  HomeCommonListViewModel.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/8.
//  

import Foundation
import RxCocoa
import RxSwift
import Moya
import HandyJSON

class HomeCommonListViewModel {
    enum RequestType : Int {
        case GetHeadline    = 1
        case GetRecommend       //推荐?热门?
        case GetPCGame
        case GetConsoleGame
        case GetEntertainment
        case GetTechnology
        case GetFilm
        case GetHardWare
        case GetAnime
        case GetMobileGame
    }
    
    fileprivate var newsListBehavior : BehaviorRelay<[HomeCommonCellViewModel]>  = BehaviorRelay(value: [])
    public var newsArray : [HomeCommonCellViewModel] {
        return newsListBehavior.value
    }
    public var newsListDriver : Driver<[HomeCommonCellViewModel]> {
        return newsListBehavior.asDriver()
    }
    
    public func requestData(type:RequestType) {
        var api : YouMinApiManager = .GetHeadline
        switch type {
            case .GetHeadline:
                api = .GetHeadline
            case .GetRecommend:
                api = .GetRecommend
            case .GetPCGame:
                api = .GetPCGame
            case .GetConsoleGame:
                api = .GetConsoleGame
            case .GetEntertainment:
                api = .GetEntertainment
            case .GetTechnology:
                api = .GetTechnology
            case .GetFilm:
                api = .GetFilm
            case .GetHardWare:
                api = .GetHardWare
            case .GetAnime:
                api = .GetAnime
            case .GetMobileGame:
                api = .GetMoblieGame
        }
        
        let observable = YouMinApiProvider.rx.request(api).asObservable()
        _ = observable.subscribe(onNext: {[weak self]  (response:Moya.Response) in
            guard let `self` = self else {return}
            //这里只能转unicode才能获取到数据，utf8会变成nil WTF???可能string里有转义导致转换失败？？尤其是HTML结构
            guard let jsonStr = String(data: response.data, encoding: .unicode) else {return}
            guard let result = JSONDeserializer<NewsResult>.deserializeFrom(json: jsonStr, designatedPath: ""),let models = result.result else {return}
            
            //遍历数据
            let commonCellViewModels = models.map { (model:NewsModel) -> HomeCommonCellViewModel in
                return HomeCommonCellViewModel(model: model)
            }
            self.newsListBehavior.accept(commonCellViewModels)
        })
    }
}
