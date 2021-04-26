//
//  NewsModel.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/8.
//

import Foundation
import HandyJSON

//两种news数据结构????? why
struct NewsModel : HandyJSON {
    var newsId : Int = 0
    var type : String?
    var thumbnails : [String]?
    var contentType : String?
    var contentURL : String?
    var contentId : Int = 0
    var authorHeadImageURL : String?
    var commentsCount : Int = 0
    var Title : String?
    var Author : String?
    var ThumbnailsPicUrl : String?
    var updateTime : String?
    var RedirectLink : String?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &newsId, name: "id")
    }
}

/*
 "type": "santu",
 "contentType": "URL",
 "contentId": 1376828,
 "title": "《漫威复仇者》开发组访谈：缺憾用心弥补，展望未来",
 "description": "",
 "thumbnailURLs": ["https://img1.gamersky.com/upimg/users/2021/04/06/origin_b_202104061507327970_b.jpg", "https://img1.gamersky.com/upimg/users/2021/04/06/origin_b_202104061507353621_b.jpg", "https://img1.gamersky.com/upimg/users/2021/04/06/origin_b_202104061507389478_b.jpg"],
 "authorName": "篝火营地",
 "authorHeadImageURL": "https://image.gamersky.com/gameshd/2020/20200518_gtz_412_1.jpg",
 "badges": [],
 "readingCount": 529,
 "commentsCount": 0,
 "contentURL": "https://club.gamersky.com/activity/457761?club=163",
 "adId": 0,
 "updateTime": 1617703721600.0,
 "duration": "",
 "sourceName": null,
 "childElements": null
 */


//两种news数据结构????? why
struct News2Model : HandyJSON {
    var newsId : Int = 0
    var type : String?
    var contentType : String?
    var contentId : Int = 0
    var title : String?
    var description : String?
    var thumbnailURLs : [String]?
    var authorName : String?
    var authorHeadImageURL : String?
    var readingCount : Int = 0
    var commentsCount : Int = 0
    var contentURL : String?
    var updateTime : Float = 0.0
    mutating func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &newsId, name: "id")
    }
}

struct NewsResult : HandyJSON {
    var errorCode : Int = 0
    var errorMessage : String?
    var result : [NewsModel]?
}

