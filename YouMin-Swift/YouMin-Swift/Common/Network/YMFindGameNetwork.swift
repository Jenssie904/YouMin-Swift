//
//  YMFineGameNetwork.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/27.
//

import Foundation
import Moya

let YMFindGameApiProvider = MoyaProvider<YMFindGameApiManager>(stubClosure:MoyaProvider.delayedStub(1))

enum YMFindGameApiManager {
    case GetGameRecommend
    case GetGameCategory(_ channelIndex:Int,_ categoryIndex:Int)
}

extension YMFindGameApiManager : TargetType {
    var baseURL: URL {
        return URL(string: "http://appapi2.gamersky.com")!
    }
    
    var path: String {
        switch self {
            case .GetGameRecommend:
                return "/v5/GetChannels"
            case .GetGameCategory:
                return "/v5/GetAttention"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        switch self {
            case .GetGameRecommend:
                return stubbedResponse("recommend_recommend")
            case .GetGameCategory(let channelIndex,let categoryIndex):
                return stubbedResponse(getCategoryJsonName(channelIndex: channelIndex, categoryIndex: categoryIndex))
        }
    }
    
    var task: Task {
        switch self {
            case .GetGameRecommend,.GetGameCategory:
                return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    //获取json文件名
    fileprivate func getCategoryJsonName(channelIndex:Int,categoryIndex:Int) -> String{
        var jsonName : String
        if 0 == channelIndex {
            if 0==categoryIndex {
                jsonName = "recommend_hot"
            }else if 1==categoryIndex {
                jsonName = "recommend_highest"
            }else if 2==categoryIndex {
                jsonName = "recommend_newest"
            }else{
                jsonName = "recommend_upcoming"
            }
        } else {
            if 0==categoryIndex {
                jsonName = "category_hot"
            }else if 1==categoryIndex {
                jsonName = 1 == channelIndex ? "category_online" : "category_highest"
            }else if 2==categoryIndex {
                jsonName = 1 == channelIndex ? "category_highest" : "category_newest"
            }else if 3==categoryIndex {
                jsonName = 1 == channelIndex ? "category_newest" : "category_upcoming"
            }else{
                jsonName = "category_upcoming"
            }
        }
        return jsonName
    }
    
    func stubbedResponse(_ filename : String) -> Data {
        guard FileManager.fileExistInMainBundle(fileName: "\(filename).json") else {return Data([])}
        guard let path = Bundle.main.url(forResource: filename, withExtension: "json") else {return Data([])}
        guard let data = try? Data(contentsOf: path) else {return Data([])}
        return data
    }
}
