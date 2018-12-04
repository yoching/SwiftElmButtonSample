//
//  ViewState.swift
//  SwiftElmSample
//
//  Created by Yoshikuni Kato on 2018/12/03.
//

import Foundation

struct AppState {
    
    // MODEL
    var value: Int
    
    // UPDATE
    enum Message {
        case increment
        case modelNotification(Notification)
    }
    
    // VIEW
    var viewController: ViewController<Message> {
        return ._viewController(.label(text: "\(value)"))
    }
}
