//
//  ChannelModel.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/7.
//

import Foundation
import HandyJSON

struct ChannelModel : HandyJSON {
    var channelId : Int = 0
    var channelButtonWidth : Int = 0
    var name : String?
    var isForAllUsers : Bool = true
    var isDefaultChannel : Bool = true
    var coverImageUrl : String?
    var isNeedShowWatchBar : Bool = false
    var adBeginTime : Int = 0
    var adEndTime : Int = 0
    var validBeginTime : Int = 0
    var validEndTime : Int = 0
    var sliderCoverUrl : String?
    var sliderContentUrl : String?
    var sliderTitle : String?
    var userDefineContentHeight : Int = 0
    var userDefineContentHTML : String?
    var contentAppId : String?
    var contentNodeId : String?
    var contentTopicId : String?
    var contentGameId : Int = 0
    var contentTagNames : String?
    var contentH5Url : String?
    var statisticsCMSId_ShowChannel : String?
    var statisticsCMSId_OpenContent : String?
    var updateTime : Int = 0
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &channelId, name: "id")
    }
}

struct ChannelResult : HandyJSON {
    var channels : [ChannelModel]?
}
