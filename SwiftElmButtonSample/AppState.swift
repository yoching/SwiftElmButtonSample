//
//  AppState.swift
//  SwiftElmButtonSample
//
//  Created by Yoshikuni Kato on 2018/12/03.
//

import UIKit

struct AppState {
    
    // MODEL
    var value: Int
    
    // UPDATE
    enum Message {
        case increment
        case decrement
        case save
        case load
        case loaded(Int)
    }
    
    mutating func update(_ message: Message) -> [Command<Message>] {
        switch message {
        case .increment:
            value = value + 1
            return []
        case .decrement:
            value = value - 1
            return []
        case .save:
            return [.save(value: value)]
        case .load:
            return [.load(available: { .loaded($0) })]
        case .loaded(let value):
            self.value = value
            return []
        }
    }
    
    // SUBSCRIPTIONS
    var subscriptions: [Subscription<Message>] {
        return [
            .notification(
                name: UIApplication.didBecomeActiveNotification,
                { notification -> Message in
                    return .load
            })
        ]
    }
    
    // VIEW
    var viewController: ViewController<Message> {
        return ._viewController(
            .stackView(
                views: [
                    .button(text: "-", onTap: .decrement),
                    .label(text: "\(value)"),
                    .button(text: "+", onTap: .increment),
                    .button(text: "save", onTap: .save),
                    .button(text: "load", onTap: .load)
                ],
                axis: .vertical,
                distriburtion: .fillEqually
            )
        )
    }
}
