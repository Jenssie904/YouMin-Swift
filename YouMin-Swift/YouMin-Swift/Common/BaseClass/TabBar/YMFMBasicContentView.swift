//
//  TSFMBasicContentView.swift
//  SuperColor_Swift
//
//  Created by admin on 2021/2/2.
//

import ESTabBarController_swift

class YMFMBasicContentView: ESTabBarItemContentView {
    override init(frame:CGRect) {
        super.init(frame: frame)
        renderingMode = .alwaysOriginal
        imageView.contentMode = .scaleAspectFit
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
