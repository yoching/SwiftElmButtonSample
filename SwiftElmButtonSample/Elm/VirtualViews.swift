//
//  VirtualViews.swift
//  SwiftElmSample
//
//  Created by Yoshikuni Kato on 2018/12/03.
//

import UIKit

indirect enum View<Message> {
    case _label(Label)
    case _button(Button<Message>)
    case _stackView(StackView<Message>)
    
    static func label(text: String) -> View {
        return ._label(Label(text: text))
    }
    
    static func button(text: String, onTap: Message? = nil) -> View {
        return ._button(Button(text: text, onTap: onTap))
    }
    
    static func stackView(
        views: [View<Message>],
        axis: NSLayoutConstraint.Axis,
        distriburtion: UIStackView.Distribution
        ) -> View {
        return ._stackView(StackView(views: views, axis: axis, distriburtion: distriburtion))
    }
}

struct Label {
    let text: String
}

struct Button<Message> {
    let text: String
    let onTap: Message?
    
    init(text: String, onTap: Message? = nil) {
        self.text = text
        self.onTap = onTap
    }
}

struct StackView<Message> {
    let views: [View<Message>]
    let axis: NSLayoutConstraint.Axis
    let distriburtion: UIStackView.Distribution
    
    init(
        views: [View<Message>],
        axis: NSLayoutConstraint.Axis,
        distriburtion: UIStackView.Distribution
        ) {
        self.views = views
        self.axis = axis
        self.distriburtion = distriburtion
    }
    
}
