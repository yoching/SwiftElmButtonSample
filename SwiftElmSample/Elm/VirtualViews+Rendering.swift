//
//  VirtualViews+Rendering.swift
//  SwiftElmSample
//
//  Created by Yoshikuni Kato on 2018/12/03.
//

import UIKit

extension ViewController {
    func render(
        callback: @escaping (Message) -> (),
        change: inout UIViewController
        ) -> StrongReferences {
        switch self {
        case ._viewController(let view):

            var renderer = Renderer<Message>(callback: callback)
            let newView = renderer.update(view: view)
            
            // Remove all subviews & add new views
            // This should be differential updates in production projects
            for view in change.view.subviews {
                view.removeFromSuperview()
            }
            change.view.addSubview(newView)
            
            newView.translatesAutoresizingMaskIntoConstraints = false
            
            change.view.addConstraints([
                newView.topAnchor.constraint(equalTo: change.view.topAnchor),
                newView.bottomAnchor.constraint(equalTo: change.view.bottomAnchor),
                newView.leadingAnchor.constraint(equalTo: change.view.leadingAnchor),
                newView.trailingAnchor.constraint(equalTo: change.view.trailingAnchor),
                ])
            
            return renderer.strongReferences
        }
    }
}

struct Renderer<Message> {
    
    var strongReferences = StrongReferences()
    private let callback: (Message) -> ()
    
    init(callback: @escaping (Message) -> ()) {
        self.callback = callback
    }
    
    mutating func update(view: View<Message>) -> UIView {
        switch view {
        case let ._label(label):
            let uiLabel = UILabel()
            uiLabel.text = label.text
            uiLabel.textAlignment = .center
            return uiLabel
            
        case let ._button(button):
            let uiButton = UIButton()
            
            if let action = button.onTap {
                let callback = self.callback
                let target = TargetAction {
                    callback(action)
                }
                strongReferences.append(target)
                uiButton.addTarget(
                    target,
                    action: #selector(TargetAction.performAction(sender:)),
                    for: .touchUpInside
                )
            }
            
            uiButton.setTitle(button.text, for: .normal)
            uiButton.setTitleColor(.black, for: .normal)
            return uiButton
        }
    }
}

class TargetAction: NSObject {
    var handle: () -> ()
    init(_ handle: @escaping () -> ()) {
        self.handle = handle
    }
    @objc func performAction(sender: UIButton) {
        handle()
    }
}

struct StrongReferences {
    private var handlers: [Any] = []
    init() {}
    
    mutating func append(_ obj: Any) {
        handlers.append(obj)
    }
}
