//
//  FindGameRecommendChildViewModel.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/27.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import HandyJSON

class FindGameRecommendChildViewModel {
    private var dataSourceBehavior : BehaviorRelay<[AnyObject]> = BehaviorRelay(value: [])
    public var dataSourceDriver : Driver<[AnyObject]> {
        return dataSourceBehavior.asDriver()
    }
    public var dataSource : [AnyObject] {
        return dataSourceBehavior.value
    }
    public func requestData() {
        let observable = YMFindGameApiProvider.rx.request(.GetGameRecommend).asObservable()
        _ = observable.subscribe(onNext: {[weak self]  (response:Moya.Response) in
            guard let `self` = self else {return}
            //这里只能转unicode才能获取到数据，utf8会变成nil WTF???可能string里有转义导致转换失败？？尤其是HTML结构
            guard let jsonStr = String(data: response.data, encoding: .unicode) else {return}
            guard let result = JSONDeserializer<RecommendResult>.deserializeFrom(json: jsonStr, designatedPath: "result"),let models = result.sections else {return}
            
            
            
            print("models:\(models)")
            
            self.dataSourceBehavior.accept(models)
        })
    }
    
    fileprivate func archiveModuleModels(models:[AnyObject]) ->[AnyObject] {
        var array = [AnyObject]()
        for var i in 0...models.count{
            if 0 == i || 2 == i || 9 == i {
                if let model = JSONDeserializer<GameNavigationMoudle>.deserializeFrom(dict: (models[i] as? Dictionary)) {
                    array.append(model)
                }
            }else{
                
            }
        }
        
        
        return array
    }
}
