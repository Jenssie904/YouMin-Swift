//
//  GameRecommendResult.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/26.
//

import Foundation
import HandyJSON

struct GameRecommendMoudleModel : HandyJSON {
    var id : Int = 0                        //游戏gameId
    var coverImageUrl : String?             //封面图
    var title : String?                     //标题
    var platforms : String?                 //游戏平台
    var publishTime : String?               //发布时间
    var tags : String?                      //关键字集
    var isFree : Bool = false               //是否免费
    var isSaleable : Bool = false           //是否可售
    var pricePlatform : String?             //价格？平台？
    var priceOriginally : Float = 0.0       //原价
    var price : Float = 0.0                 //现价
    var priceDiscount : Float = 0.0         //价格折扣率
    var isPriceLowest : Bool = false        //是否是历史低价
    var userScore : Float    = 0.0          //玩家评分 10分满分
    var userCount_Score : Int = 0           //玩家评分总分?
    var userCount_WantToPlay : Int = 0      //多少玩家想玩
    var userCount_Played : Int = 0          //多少玩家已玩
    var rencentHotValue : Int = 0           //近期热度?
    var uiSubtitleType : String?            //卡片类型?
    var themeColor : String?                //详情页主题色，渐变
}

struct GameRecommendMoudleBody : HandyJSON {
    var channelName : String?
    var games : [GameRecommendMoudleModel]?
}

struct GameRecommendMoudle : HandyJSON {
    var sectionId : Int = 0
    var title : String?
    var moreUrl : String?
    var channelGames : [GameRecommendMoudleBody]?
}

struct GameNavigationMoudle : HandyJSON {
    var sectionId : Int = 0
    var title : String?
    var moreUrl : String?
}

struct RecommendResult : HandyJSON {
    var sections : [AnyObject]?
}
