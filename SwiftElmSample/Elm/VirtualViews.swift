//
//  VirtualViews.swift
//  SwiftElmSample
//
//  Created by Yoshikuni Kato on 2018/12/03.
//

import Foundation

indirect enum View<Message> {
    case _label(Label)
    
    static func label(text: String) -> View {
        return ._label(Label(text: text))
    }
}

struct Label {
    let text: String
}
