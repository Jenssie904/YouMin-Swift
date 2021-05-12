//
//  FindGameRecommendChildViewModel.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/27.
//  找游戏-首页推荐列表

import Foundation
import RxSwift
import RxCocoa
import Moya
import HandyJSON

class FindGameRecommendChildViewModel {
    
    //主列表数据
    private var dataSourceBehavior : BehaviorRelay<[Any]> = BehaviorRelay(value: [])
    public var dataSourceDriver : Driver<[Any]> {
        return dataSourceBehavior.asDriver()
    }
    public var dataSource : [Any] {
        return dataSourceBehavior.value
    }
    
    public func requestData() {
        
        //获取主列表数据
        let observable = YMFindGameApiProvider.rx.request(.GetGameRecommend).asObservable()
        _ = observable.subscribe(onNext: {[weak self]  (response:Moya.Response) in
            guard let `self` = self else {return}
            //这里只能转unicode才能获取到数据，utf8会变成nil WTF???可能string里有转义导致转换失败？？尤其是HTML结构
            guard let jsonStr = String(data: response.data, encoding: .unicode) else {return}
            guard let result = JSONDeserializer<RecommendResult>.deserializeFrom(json: jsonStr, designatedPath: "result"),let models = result.sections else {return}
            var array = self.archiveModuleModels(models: models)
            
            //这里再次获取卡片列表数据
            let bannerCardObservable = YMFindGameApiProvider.rx.request(.GetGameRecommendBanner).asObservable()
            _ = bannerCardObservable.subscribe(onNext: {(bannerResponse:Moya.Response) in
                guard let jsonStr = String(data: bannerResponse.data, encoding: .unicode) else {return}
                guard let result = JSONDeserializer<GameRecommendBannerResult>.deserializeFrom(json: jsonStr, designatedPath: "result"),let bannerModels = result.result else {return}
                array[2] = bannerModels
                self.dataSourceBehavior.accept(array)
            })
        })
        
    }
    
    //数据解析
    fileprivate func archiveModuleModels(models:[AnyObject]) ->[Any] {
        var array = [Any]()
        for i in 0..<models.count{
            if 0 == i || 2 == i || 9 == i {
                if let model = JSONDeserializer<GameNavigationMoudle>.deserializeFrom(dict: (models[i] as? Dictionary)) {
                    array.append(model)
                }
            }else{
                if let model = JSONDeserializer<GameRecommendMoudle>.deserializeFrom(dict: (models[i] as? Dictionary)) {
                    array.append(model)
                }
            }
        }
        return array
    }
}
