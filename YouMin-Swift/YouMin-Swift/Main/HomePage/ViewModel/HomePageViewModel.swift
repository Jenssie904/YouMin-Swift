//
//  HomePageViewModel.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/7.
//  homePage首页应该只需要获取分类列表即可，具体分类再获取具体的数据

import Foundation
import RxSwift
import RxCocoa
import Moya
import HandyJSON

class HomePageViewModel {
    private var channels : BehaviorRelay<[ChannelModel]> = BehaviorRelay(value: [])
    public var dataSourceDriver : Driver<[ChannelModel]> {
        return channels.asDriver()
    }
    public func requestData() {
        let observable = YMHomeApiProvider.rx.request(.GetChannels).asObservable()
        _ = observable.subscribe(onNext: {[weak self]  (response:Moya.Response) in
            guard let `self` = self else {return}
            //这里只能转unicode才能获取到数据，utf8会变成nil WTF???可能string里有转义导致转换失败？？尤其是HTML结构
            guard let jsonStr = String(data: response.data, encoding: .unicode) else {return}
            guard let result = JSONDeserializer<ChannelResult>.deserializeFrom(json: jsonStr, designatedPath: "result"),let models = result.channels else {return}
            self.channels.accept(models)
        })
    }
    
}
