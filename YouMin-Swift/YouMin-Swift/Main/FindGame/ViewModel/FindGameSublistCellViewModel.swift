//
//  FindGameSublistCellViewModel.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/28.
//

import Foundation
import RxSwift
import RxCocoa

class FindGameSublistCellViewModel {
    fileprivate var modelBehavior : BehaviorRelay<GameModel>
    init(model:GameModel) {
        modelBehavior = BehaviorRelay(value: model)
    }
}

extension FindGameSublistCellViewModel {
    public var modelDriver : Driver<GameModel> {
        return modelBehavior.asDriver()
    }
    
    //封面界面绑定
    public var coverUrl : Observable<URL?> {
        modelDriver.map { (model :GameModel) in
            guard let str = model.coverImageURL else { return nil }
            return URL(string: str) ?? nil
        }.asObservable()
    }
    
    //绑定游戏标题,如果空的那么就使用空字符
    public var title : Driver<String> {
        modelDriver.map{$0.gameName ?? ""}.asDriver()
    }
    
    //如果无评分那么就显示，想玩人数绑定想玩人数
    public var gsScore : Observable<Float> 
    
}
