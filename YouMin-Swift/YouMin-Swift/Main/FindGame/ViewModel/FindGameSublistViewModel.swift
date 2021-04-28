//
//  YMFindGameSublistViewModel.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/27.
//  找游戏-子分类数据列表

import Foundation
import RxSwift
import RxCocoa
import Moya
import HandyJSON

class FindGameSublistViewModel {
    private var dataSourceBehavior : BehaviorRelay<[GameModel]> = BehaviorRelay(value: [])
    public var dataSourceDriver : Driver<[GameModel]> {
        return dataSourceBehavior.asDriver()
    }
    public var dataSource : [GameModel] {
        return dataSourceBehavior.value
    }
    public func requestData(channelIndex:Int,categoryIndex:Int) {
        let observable = YMFindGameApiProvider.rx.request(.GetGameCategory(channelIndex, categoryIndex)).asObservable()
        _ = observable.subscribe(onNext: {[weak self]  (response:Moya.Response) in
            guard let `self` = self else {return}
            //这里只能转unicode才能获取到数据，utf8会变成nil WTF???可能string里有转义导致转换失败？？尤其是HTML结构
            guard let jsonStr = String(data: response.data, encoding: .unicode) else {return}
            guard let result = JSONDeserializer<GameListResult>.deserializeFrom(json: jsonStr, designatedPath: "result"),let models = result.result?.games else {return}
            self.dataSourceBehavior.accept(models)
        })
    }
}
