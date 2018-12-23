//
//  Subscription.swift
//  SwiftElmButtonSample
//
//  Created by Yoshikuni Kato on 2018/12/23.
//

import Foundation

enum Subscription<Message> {
    case notification(name: Notification.Name, (Notification) -> Message)
}

final class SubscriptionManager<Message> {
    private let callback: (Message) -> ()
    private var observers: [Any] = []
    
    init(_ callback: @escaping (Message) -> ()) {
        self.callback = callback
    }
    
    func update(subscriptions: [Subscription<Message>]) {
        var newObservers: [Any] = []
        for subscription in subscriptions {
            switch subscription {
            case let .notification(name , handle):
                let observer = NotificationCenter.default.addObserver(
                    forName: name,
                    object: nil,
                    queue: nil) { [weak self] notification in
                        self?.callback(handle(notification))
                }
                newObservers.append(observer)
            }
        }
        
        for observer in observers {
            NotificationCenter.default.removeObserver(observer)
        }
        
        self.observers = newObservers
    }
}
