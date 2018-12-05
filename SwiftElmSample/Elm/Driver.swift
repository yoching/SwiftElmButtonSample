//
//  Driver.swift
//  SwiftElmSample
//
//  Created by Yoshikuni Kato on 2018/12/03.
//

import UIKit

final class Driver<Model, Message> {
    private var model: Model
    private var strongReferences = StrongReferences()
    private(set) var viewController: UIViewController = UIViewController()
    
    private let updateState: (inout Model, Message) -> Void
    private let computeView: (Model) -> ViewController<Message>
    init(
        _ initial: Model,
        update: @escaping (inout Model, Message) -> Void,
        view: @escaping (Model) -> ViewController<Message>
        ) {
        self.model = initial
        self.updateState = update
        self.computeView = view
        
        strongReferences = computeView(model)
            .render(callback: asyncSend, change: &viewController)
    }
    
    func asyncSend(action: Message) {
        DispatchQueue.main.async { [unowned self] in
            self.run(action: action)
        }
    }
    
    func run(action: Message) {
        updateState(&model, action)
        refresh()
    }
    
    func refresh() {
        strongReferences = computeView(model)
            .render(callback: asyncSend, change: &viewController)
    }
}
