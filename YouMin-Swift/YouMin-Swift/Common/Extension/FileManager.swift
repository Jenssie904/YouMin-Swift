//
//  FileManager.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/7.
//

import UIKit

public extension FileManager {
    static func fileExistInMainBundle(fileName:String) -> Bool {
        return FileManager.default.fileExists(atPath: Bundle.main.bundlePath.appending("/\(fileName)"))
    }
}
