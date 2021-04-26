//
//  Author.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/7.
//

import Foundation
import HandyJSON

struct AuthorModel : HandyJSON {
    var userId : Int = 0
    var userName : String?
    var userHeadImageUrl : String?
    var userGroupId : Int = 0
    var userAuthentication : String?
    var fansCount : Int = 0
    var praisesCount : Int = 0
}

struct AllAuthors : HandyJSON {
    var userInfes : [AuthorModel]?
}
