//
//  Driver.swift
//  SwiftElmSample
//
//  Created by Yoshikuni Kato on 2018/12/03.
//

import UIKit

final class Driver<Model, Message> {
    private var model: Model
    private(set) var viewController: UIViewController = UIViewController()
    init(
        _ initial: Model,
        view: @escaping(Model) -> ViewController<Message>
        ) {
        self.model = initial
        view(model).render(change: &viewController)
    }
}
