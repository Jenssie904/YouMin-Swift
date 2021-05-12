//
//  GameRecommendBannerResult.swift
//  YouMin-Swift
//
//  Created by admin on 2021/5/12.
//  find game banner

import Foundation
import HandyJSON

struct GameRecommendBannerModel : HandyJSON {
    var type : String?
    var contentType : String?
    var contentId : Int         = 0
    var title : String?
    var description : String?
    var thumbnailURLs : [String]?
    var authorName : String?
    var authorHeadImageURL : String?
    var readingCount : Int      = 0
    var commentsCount : Int     = 0
    var contentURL : String?
    var adId : Int              = 0
    var updateTime : Double     = 0.0
    var duration : String?
    var sourceName : String?
    var childElements : String?
}

struct GameRecommendBannerResult : HandyJSON {
    var result : [GameRecommendBannerModel]?
}

