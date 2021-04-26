//
//  TSFMIrregularityBasicContentView.swift
//  SuperColor_Swift
//
//  Created by admin on 2021/2/2.
//

import UIKit
import ESTabBarController_swift

class YMFMIrregularityBasicContentView: YMFMBouncesContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = UIColor(white: 175.0/255.0, alpha: 1.0)
        highlightTextColor = UIColor(red: 128.0/255.0, green: 101.0/255.0, blue: 1.0, alpha: 1.0)
        iconColor = UIColor(white: 175.0/255.0, alpha: 1.0)
        highlightIconColor = UIColor(red: 128.0/255.0, green: 101.0/255.0, blue: 1.0, alpha: 1.0)
        
        
        self.imageView.frame = frame
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class YMFMIrregularityContentView: ESTabBarItemContentView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView.backgroundColor = UIColor.clear
        self.imageView.layer.borderWidth = 2.0
        self.imageView.layer.borderColor = UIColor.init(white: 235 / 255.0, alpha: 1.0).cgColor
        self.imageView.layer.cornerRadius = 25
        self.insets = UIEdgeInsets(top: -23, left: 0, bottom: 0, right: 0)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        self.superview?.bringSubviewToFront(self)
        
        textColor               = UIColor(white:1.0, alpha:1.0)
        highlightTextColor      = UIColor(white:1.0, alpha:1.0)
        iconColor               = UIColor(white:1.0, alpha:1.0)
        highlightIconColor      = UIColor(white:1.0, alpha:1.0)
        backdropColor           = .clear
        highlightBackdropColor  = .clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let p = CGPoint(x: point.x - imageView.frame.origin.x, y: point.y - imageView.frame.origin.y)
        return sqrt(pow(imageView.bounds.size.width / 2.0 - p.x, 2) + pow(imageView.bounds.size.height / 2.0 - p.y, 2)) < imageView.bounds.size.width / 2.0
    }
    
    override func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
    }
}
