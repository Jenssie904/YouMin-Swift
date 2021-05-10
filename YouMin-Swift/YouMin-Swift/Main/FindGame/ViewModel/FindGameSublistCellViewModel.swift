//
//  FindGameSublistCellViewModel.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/28.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftHEXColors

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
    public var gsScore : Observable<Float> {
        modelDriver.map{
            guard let score = $0.gsScore else {return 0.0}
            return Float(score) ?? 0.0
        }.asObservable()
    }
    
    //多少人想玩
    public var wantPlay : Driver<String?> {
        modelDriver.map{return ($0.expectCount == 0 ? nil : "\($0.expectCount)人想玩")}.asDriver()
    }
    
    //游戏tag
    public var gameTag : Driver<String> {
        modelDriver.map{
            guard let tags = $0.gameTag else {return ""}
            var resultStr = ""
            for tag in tags { resultStr.append("\(tag)/ ") }
            resultStr.remove(at: resultStr.index(resultStr.startIndex, offsetBy: (resultStr.count-2)))
            return resultStr
        }.asDriver()
    }
    
    //价格
    public var price : Driver<NSAttributedString> {
        modelDriver.map {
            var attribute = [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x666666)!,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 10)] as [NSAttributedString.Key : Any]
            guard let price = $0.FhPrice,price.count != 0 else {return NSAttributedString(string: "暂无价格", attributes: attribute as [NSAttributedString.Key : Any])}
            let priceAttrString = NSMutableAttributedString(string: price, attributes: attribute)
            
            //添加头部图片
            let attachment = NSTextAttachment(data: nil, ofType: nil)
            attachment.image = UIImage(named: "icon_Steam_BlackIconWhiteBG_12x12_12x12_")
            attachment.bounds = CGRect(x: 0, y: 0, width: 12, height: 12)
            let attrString = NSAttributedString(attachment: attachment)
            priceAttrString.insert(attrString, at: 0)

            //价格相同也不显示折扣划扣价格
            guard let originalPrice = $0.FhOriginalPrice,originalPrice.count != 0,originalPrice != price else {return priceAttrString}
            
            let blankAttributeStr = NSMutableAttributedString(string: " ", attributes: attribute)
            priceAttrString.append(blankAttributeStr)
            
            attribute[NSAttributedString.Key.strikethroughStyle] = NSUnderlineStyle.single.rawValue as NSObject
            attribute[NSAttributedString.Key.foregroundColor] = UIColor(hex: 0x999999)
            let originalPriceAttrString = NSAttributedString(string: originalPrice,attributes: attribute)
            priceAttrString.append(originalPriceAttrString)
            return priceAttrString
        }
    }
    
    //图片
}
