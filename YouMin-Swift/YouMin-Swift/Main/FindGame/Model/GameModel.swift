//
//  GameModel.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/26.
//

/*
 "gameId": 1322128,
 "gameName": "怪物猎人：崛起",
 "coverImageURL": "https://imgs.gamersky.com/upimg/new_preview/2020/09/18/origin_b_202009180929218397.jpg",
 "DeputyNodeId": "20042",
 "Position": "首页-发售表",
 "AllTimeT": "2021/3/26 0:00:00",
 "AllTime": "2021-03-26",
 "PCTime": "未知",
 "PCTimeT": "2022/12/31 0:00:00",
 "OnLine": "",
 "PS5Time": "",
 "PS5TimeT": "",
 "XboxSeriesXTime": "",
 "XboxSeriesXTimeT": "",
 "PS4Time": "",
 "PS4TimeT": "",
 "NintendoSwitchTime": "2021-03-26",
 "NintendoSwitchTimeT": "2021/3/26 0:00:00",
 "XboxOneTime": "",
 "XboxOneTimeT": "",
 "gsScore": "9.4",
 "gameTag": ["动作", "狩猎", "合作", "多人", "第三人称视角", "2021-03-26上市"],
 "playCount": 10587,
 "expectCount": 20130
 */


import Foundation
import HandyJSON

struct GameModel {
    var gameId : Int = 0
    var gameName : String?
    var coverImageURL : String?
    var DeputyNodeId : String?
    var Position : String?
    var AllTimeT : String?
    var AllTime : String?
    var PCTime : String?
    var NintendoSwitchTime : String?
    var NintendoSwitchTimeT : String?
    var gsScore : String?
    var gameTag : [String]?
    var playCount : Int = 0
    var expectCount : Int = 0
}
