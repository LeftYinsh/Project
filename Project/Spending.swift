//
//  Spending.swift
//  Project
//
//  Created by HongRuWu on 2018/1/12.
//  Copyright © 2018年 HongRuWu. All rights reserved.
//

import Foundation
import UIKit

struct Spending: Codable {
    var title: String
    var date: String
    var amount: String
    var imageName: String?
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func saveToFile(spendings: [Spending]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(spendings) {
            let url = Spending.documentsDirectory.appendingPathComponent("spending")
            try? data.write(to: url)
        }
    }
    
    static func readLoversFromFile() -> [Spending]? {
        let propertyDecoder = PropertyListDecoder()
        let url = Spending.documentsDirectory.appendingPathComponent("spending")
        if let data = try? Data(contentsOf: url), let spendings = try? propertyDecoder.decode([Spending].self, from: data) {
            return spendings
        } else {
            return nil
        }
    }
    
    
    var image: UIImage? {
        if let imageName = imageName {
            let url = Spending.documentsDirectory.appendingPathComponent(imageName)
            return UIImage(contentsOfFile: url.path)
        } else {
            return #imageLiteral(resourceName: "spending book")
        }
    }
    
}
