//
//  NetWork.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/7.
//

import Foundation
import Moya

let YouMinApiProvider = MoyaProvider<YouMinApiManager>(stubClosure:MoyaProvider.delayedStub(1))

enum YouMinApiManager {
    case GetChannels
    case GetAttentionList
    case GetHeadline
    case GetRecommend       //推荐?热门?
    case GetPCGame
    case GetConsoleGame
    case GetEntertainment
    case GetTechnology
    case GetFilm
    case GetHardWare
    case GetAnime
    case GetMoblieGame
}

extension YouMinApiManager : TargetType {
    
    var baseURL: URL {
        return URL(string: "http://appapi2.gamersky.com")!
    }
    
    var path: String {
        switch self {
            case .GetChannels:
                return "/v5/GetChannels"
            case .GetAttentionList:
                return "/v5/GetAttention"
            case .GetHeadline:
                return "/v5/GetHeadline"
            case .GetRecommend:       //推荐?热门?
                return "/v5/GetRecommend"
            case .GetPCGame:
                return "/v5/GetPCGame"
            case .GetConsoleGame:
                return "/v5/GetConsoleGame"
            case .GetEntertainment:
                return "/v5/GetEntertainment"
            case .GetTechnology:
                return "/v5/GetTechnology"
            case .GetFilm:
                return "/v5/GetFilm"
            case .GetHardWare:
                return "/v5/GetHardWare"
            case .GetAnime:
                return "/v5/GetAnime"
            case .GetMoblieGame:
                return "/v5/GetMoblieGame"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        switch self {
            case .GetChannels:
                return stubbedResponse("Channels")
            case .GetAttentionList:
                return stubbedResponse("Attention")
            case .GetHeadline:
                return stubbedResponse("Headline")
            case .GetRecommend:       //推荐?热门?
                return stubbedResponse("Recommend")
            case .GetPCGame:
                return stubbedResponse("PCGame")
            case .GetConsoleGame:
                return stubbedResponse("ConsoleGame")
            case .GetEntertainment:
                return stubbedResponse("Entertainment")
            case .GetTechnology:
                return stubbedResponse("Technology")
            case .GetFilm:
                return stubbedResponse("Flim")
            case .GetHardWare:
                return stubbedResponse("Hardware")
            case .GetAnime:
                return stubbedResponse("Anime")
            case .GetMoblieGame:
                return stubbedResponse("MobileGame")
        }
    }
    
    var task: Task {
        switch self {
            case .GetChannels,.GetAttentionList,.GetHeadline,.GetRecommend,.GetPCGame,.GetConsoleGame,.GetEntertainment,.GetTechnology,.GetFilm,.GetHardWare,.GetAnime,.GetMoblieGame:
                return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    func stubbedResponse(_ filename : String) -> Data {
        guard FileManager.fileExistInMainBundle(fileName: "\(filename).json") else {return Data([])}
        guard let path = Bundle.main.url(forResource: filename, withExtension: "json") else {return Data([])}
        guard let data = try? Data(contentsOf: path) else {return Data([])}
        return data
    }
}
