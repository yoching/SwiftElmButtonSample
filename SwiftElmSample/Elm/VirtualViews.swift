//
//  VirtualViews.swift
//  SwiftElmSample
//
//  Created by Yoshikuni Kato on 2018/12/03.
//

import Foundation

indirect enum View<Message> {
    case _label(Label)
    case _button(Button<Message>)
    
    static func label(text: String) -> View {
        return ._label(Label(text: text))
    }
    
    static func button(text: String, onTap: Message? = nil) -> View {
        return ._button(Button(text: text, onTap: onTap))
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
