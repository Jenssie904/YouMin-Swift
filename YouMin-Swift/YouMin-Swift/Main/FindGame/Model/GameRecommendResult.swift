//
//  GameRecommendResult.swift
//  YouMin-Swift
//
//  Created by admin on 2021/4/26.
//

import Foundation
import HandyJSON


struct GameNavigationMoudle : HandyJSON {
    <#fields#>
}

struct RecommendResult : HandyJSON {
    var sections : [AnyObject]?
}

struct GameRecommendResult : HandyJSON {
    var result : RecommendResult?
}
