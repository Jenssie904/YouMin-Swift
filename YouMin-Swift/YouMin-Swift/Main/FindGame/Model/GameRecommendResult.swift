//
//  GameRecommendResult.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/26.
//

import Foundation
import HandyJSON

struct GameRecommendMoudleModel : HandyJSON {
    var id : Int = 0
    var coverImageUrl : String?
    var title : String?
    var platforms : String?
    var publishTime : String?
    var tags : String?
    var isFree : Bool = false
    var isSaleable : Bool = false
    var pricePlatform : String?
    var priceOriginally : Float = 0.0
    var price : Float = 0.0
    var priceDiscount : Float = 0.0
    var isPriceLowest : Bool = false
    var userScore : Float    = 0.0
    var userCount_Score : Int = 0
    var userCount_WantToPlay : Int = 0
    var userCount_Played : Int = 0
    var rencentHotValue : Int = 0
    var uiSubtitleType : String?
    var themeColor : String?
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

struct GameRecommendResult : HandyJSON {
    var result : RecommendResult?
}
