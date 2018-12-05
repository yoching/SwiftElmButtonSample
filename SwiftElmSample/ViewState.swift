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
    }
    
    mutating func update(_ message: Message) {
        switch message {
        case .increment:
            value = value + 1
        }
    }
    
    // VIEW
    var viewController: ViewController<Message> {
        return ._viewController(.button(text: "\(value)", onTap: .increment))
    }
}
