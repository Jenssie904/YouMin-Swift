//
//  GameModel.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/26.
//

import Foundation
import HandyJSON

/*
 "gameId": 304810,
 "gameName": "命运石之门",
 "coverImageURL": "https://imgs.gamersky.com/ku/2013/ku_steinsgate.jpg",
 "DeputyNodeId": "20053",
 "Position": "",
 "AllTimeT": "2016/9/9 0:00:00",
 "AllTime": "2016-09-09",
 "PCTime": "2016-09-09",
 "PCTimeT": "2016/9/9 0:00:00",
 "OnLine": "62",
 "PS5Time": "",
 "PS5TimeT": "",
 "XboxSeriesXTime": "",
 "XboxSeriesXTimeT": "",
 "PS4Time": "",
 "PS4TimeT": "",
 "NintendoSwitchTime": "",
 "NintendoSwitchTimeT": "",
 "XboxOneTime": "",
 "XboxOneTimeT": "",
 "SteamInitial": "90",
 "SteamFinal": "90",
 "DiscountPercent": "",
 "IsFree": "False",
 "SteamPrice": "36",
 "DiscountText": "",
 "FhPrice": "",
 "FhOriginalPrice": "",
 "gsScore": "9.7",
 "gameTag": ["冒险", "视觉小说", "日本动画", "剧情丰富", "时空旅行", "2016-09-09上市"],
 "playCount": 17394,
 "expectCount": 5688
 */

struct GameModel : HandyJSON{
    var gameId : Int = 0
    var gameName : String?
    var coverImageURL : String?
    var DeputyNodeId : String?
    var Position : String?
    var AllTimeT : String?
    var AllTime : String?
    var PCTime : String?
    var PCTimeT : String?
    var OnLine : String?
    var PS5Time : String?
    var PS5TimeT : String?
    var XboxSeriesXTime : String?
    var XboxSeriesXTimeT : String?
    var PS4Time : String?
    var PS4TimeT : String?
    var NintendoSwitchTime : String?
    var NintendoSwitchTimeT : String?
    var XboxOneTime : String?
    var XboxOneTimeT : String?
    var SteamInitial : String?
    var SteamFinal : String?
    var DiscountPercent : String?
    var IsFree : String?
    var SteamPrice : String?
    var DiscountText : String?
    var FhPrice : String?
    var FhOriginalPrice : String?    
    var gsScore : String?
    var gameTag : [String]?
    var playCount : Int = 0
    var expectCount : Int = 0
}

struct GameListBody : HandyJSON {
    var gamesCount : Int = 0
    var games : [GameModel]?
}

struct GameListResult : HandyJSON{
    var result : GameListBody?
}
