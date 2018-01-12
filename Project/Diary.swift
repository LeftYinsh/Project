//
//  Diary.swift
//  Project
//
//  Created by HongRuWu on 2018/1/11.
//  Copyright © 2018年 HongRuWu. All rights reserved.
//

import Foundation
import UIKit

struct Diary: Codable {
    var title: String
    var date: String
    var content: String
    var imageName: String?
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func saveToFile(diaries: [Diary]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(diaries) {
            let url = Diary.documentsDirectory.appendingPathComponent("diary")
            try? data.write(to: url)
        }
    }
    
    static func readLoversFromFile() -> [Diary]? {
        let propertyDecoder = PropertyListDecoder()
        let url = Diary.documentsDirectory.appendingPathComponent("diary")
        if let data = try? Data(contentsOf: url), let diaries = try? propertyDecoder.decode([Diary].self, from: data) {
            return diaries
        } else {
            return nil
        }
    }
    
    
    var image: UIImage? {
        if let imageName = imageName {
            let url = Diary.documentsDirectory.appendingPathComponent(imageName)
            return UIImage(contentsOfFile: url.path)
        } else {
            return #imageLiteral(resourceName: "diary")
        }
    }
    
}
