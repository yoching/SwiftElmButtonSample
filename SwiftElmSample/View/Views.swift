//
//  Views.swift
//  SwiftElmSample
//
//  Created by Yoshikuni Kato on 2018/12/03.
//

import UIKit

extension AppState {
    var viewController: ViewController<Message> {
        return ViewController._viewController(.label(text: "label text"))
    }
}
