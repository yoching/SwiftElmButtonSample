//
//  Model.swift
//  SwiftElmSample
//
//  Created by Yoshikuni Kato on 2018/12/04.
//

import Foundation

class Model {
    static let valueDidChange = Notification.Name("valueDidChange")
    static let valueKey = "value"
    
    var value: Int {
        didSet {
            NotificationCenter.default.post(
                name: Model.valueDidChange,
                object: self,
                userInfo: [Model.valueKey: value]
            )
        }
    }
    
    init(value: Int) {
        self.value = value
    }
}
