# Elm Button Sample implemented in Swift

Very simple sample of The Elm Architecture.  
For simplicity, [commands and subscriptions](https://guide.elm-lang.org/effects/) are not included.  
Also, incremental update of views is not implemented.  
This is a implementation of [Buttons sample](https://guide.elm-lang.org/architecture/buttons.html) in Elm Official Guide.

![](./ButtonsSample.gif)

## AppState
This corresponds to the [Buttons sample](https://guide.elm-lang.org/architecture/buttons.html) in Elm Official Guide.
```swift
struct AppState {

    // MODEL
    var value: Int

    // UPDATE
    enum Message {
        case increment
        case decrement
    }

    mutating func update(_ message: Message) {
        switch message {
        case .increment:
            value = value + 1
        case .decrement:
            value = value - 1
        }
    }

    // VIEW
    var viewController: ViewController<Message> {
        return ._viewController(
            .stackView(
                views: [
                    .button(text: "-", onTap: .decrement),
                    .label(text: "\(value)"),
                    .button(text: "+", onTap: .increment)
                ],
                axis: .vertical,
                distriburtion: .fillEqually
            )
        )
    }
}
```


## References
- App Architecture from objc.io
 - [book & video](https://www.objc.io/books/app-architecture/)
 - [sample codes](https://github.com/objcio/app-architecture)
   - especially, Recordings-TEA & One-App-Eight-Architectures
