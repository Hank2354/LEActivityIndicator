![header](https://i.imgur.com/wfmsmS5.png)

# :large_orange_diamond: LEActivityIndicator :large_orange_diamond:
Collection of activity indicators with a beautiful and user-friendly interface 

- [About project](#About-project-warning)
- [Framework options](#Framework-options-bookmark_tabs)
- [How use](#How-Use-key)
- [Control](#Control-video_game)

## About project :warning:
LEActivityIndicator is a library containing a collection of beautiful loading indicators, using this library you can brighten up your application by spending 10 seconds to install and use the indicator.
The collection will be updated, you can always follow the updates and new indicators on this page.

## Framework options :bookmark_tabs:
`LEActivityStyle` - Sets the style of the indicator to be displayed on *LEActivityIndicatorView*


|defaultStyle                        |spinner                             |gradient                            |wave                                |
|------------------------------------|------------------------------------|------------------------------------|------------------------------------|
|![](https://i.imgur.com/Mh4EBzh.gif)|![](https://i.imgur.com/MC08Gre.gif)|![](https://i.imgur.com/IL8HCfc.gif)|![](https://i.imgur.com/M0euDfZ.gif)|

|bouble                              |line                                |cube                                |walking                             |
|------------------------------------|------------------------------------|------------------------------------|------------------------------------|
|![](https://i.imgur.com/5IyNwfc.gif)|![](https://i.imgur.com/FU6Ews3.gif)|![](https://i.imgur.com/rFXRtKr.gif)|![](https://i.imgur.com/9rWQIgl.gif)|

`LEActivitySize` - This model allows you to set the dimensions for the indicator
| LEActivitySize | Current size  |
|----------------|-------------- |
| extraSmall     |     10x10     |
| small          |     30x30     |
| medium         |     50x50     |
| large          |     70x70     |
| extraLarge     |     90x90     |
| custom         | custom CGSize |

`LEActivityColorSet` - Allows you to set the color palette for the indicator

It has three components
-   mainColor
-   secondMainColor
-   complementaryColor (optional)

## How use :key:

Firstly, import `LEActivityIndicator`

```swift
import LEActivityIndicator
```

and create LEActivityIndicatorView with choosed options

```swift
let style: LEActivityStyle = .spinner
let size: LEActivitySize = .medium
let colorSet = ColorSet(mainColor: .red, secondMainColor: .green)

let indicator = LEActivityIndicatorView(style: style, size: size, colorSet: colorSet)
```

## Installation

#### Cocoapods

[Cocoapods](https://cocoapods.org/#install) is a dependency manager for Swift and Objective-C Cocoa projects. To use LEActivityIndicator with CocoaPods, add it in your `Podfile`.

```ruby
pod 'LEActivity'
```

## Control :video_game:

Start animating.
```swift
activityIndicatorView.showActivity()
```
Stop animating.
```swift
activityIndicatorView.hideActivity()
```
