//
//  Driver.swift
//  SwiftElmButtonSample
//
//  Created by Yoshikuni Kato on 2018/12/03.
//

import UIKit

final class Driver<State, Message> {
    private var state: State
    private var strongReferences = StrongReferences()
    private(set) var viewController: UIViewController = UIViewController()
    
    private let updateState: (inout State, Message) -> [Command<Message>]
    private let computeView: (State) -> ViewController<Message>
    init(
        _ initial: State,
        update: @escaping (inout State, Message) -> [Command<Message>],
        view: @escaping (State) -> ViewController<Message>
        ) {
        self.state = initial
        self.updateState = update
        self.computeView = view
        
        refresh()
    }
    
    func asyncSend(message: Message) {
        DispatchQueue.main.async { [unowned self] in
            self.run(message: message)
        }
    }
    
    func run(message: Message) {
        let commands = updateState(&state, message)
        refresh()
        for command in commands {
            interpret(command)
        }
    }
    
    func interpret(_ command: Command<Message>) {
        command.run(Context(
            viewController: viewController,
            send: self.asyncSend
        ))
    }
    
    func refresh() {
        strongReferences = computeView(state)
            .render(callback: asyncSend, change: &viewController)
    }
}
