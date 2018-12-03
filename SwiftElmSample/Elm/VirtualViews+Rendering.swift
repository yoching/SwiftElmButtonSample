//
//  VirtualViews+Rendering.swift
//  SwiftElmSample
//
//  Created by Yoshikuni Kato on 2018/12/03.
//

import UIKit

extension ViewController {
    func render(change: inout UIViewController) {
        switch self {
        case ._viewController(let view):
            let renderer = Renderer<Message>()
            let newView = renderer.update(view: view)
            change.view.addSubview(newView)
            newView.translatesAutoresizingMaskIntoConstraints = false
            
            change.view.addConstraints([
                newView.topAnchor.constraint(equalTo: change.view.topAnchor),
                newView.bottomAnchor.constraint(equalTo: change.view.bottomAnchor),
                newView.leadingAnchor.constraint(equalTo: change.view.leadingAnchor),
                newView.trailingAnchor.constraint(equalTo: change.view.trailingAnchor),
                ])
        }
    }
}

struct Renderer<Message> {
    func update(view: View<Message>) -> UIView {
        switch view {
        case let ._label(label):
            let uiLabel = UILabel()
            uiLabel.text = label.text
            uiLabel.textAlignment = .center
            return uiLabel
        }
    }
}
