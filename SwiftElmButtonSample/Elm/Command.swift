//
//  Command.swift
//  SwiftElmButtonSample
//
//  Created by Yoshikuni Kato on 2018/12/20.
//

import UIKit

struct Context<Message> {
    let viewController: UIViewController
    let send: (Message) -> ()
}

struct Command<Message> {
    let run: (Context<Message>) -> ()
}

extension Command {
    static func save(value: Int) -> Command {
        return Command { _ in
            UserDefaults.standard.set(value, forKey: "value")
        }
    }
    
    static func load(available: @escaping (Int) -> Message) -> Command {
        return Command { context in
            let value = UserDefaults.standard.integer(forKey: "value")
            context.send(available(value))
        }
    }
}
