//
//  VirtualViewControllers.swift
//  SwiftElmButtonSample
//
//  Created by Yoshikuni Kato on 2018/12/03.
//

import Foundation

indirect enum ViewController<Message> {
    case _viewController(View<Message>)
}
