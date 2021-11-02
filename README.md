# CodeWarsTracker-iOS

## Overview

codewars

       

## Features

### Browsing 

Scroll Users           | Search User             | Change Color Theme
---------------------- | ----------------------- | -----------------------
![gif](CodeWarsTracker/Assets.xcassets/MyGifAnimation.xcassets/BrowseFellows.dataset/BrowseFellows.gif) | ![gif](CodeWarsTracker/Assets.xcassets/MyGifAnimation.xcassets/SearchFellow.dataset/SearchFellow.gif) | ![gif](CodeWarsTracker/Assets.xcassets/MyGifAnimation.xcassets/ChangeTheme.dataset/ChangeTheme.gif)

### Creating an Account & User Details 
![CreateAccount](CodeWarsTracker/Assets.xcassets/CreateAccount.imageset/CreateAccount.png) ![DetailFellow](CodeWarsTracker/Assets.xcassets/DetailFellow.imageset/DetailFellow.png)      

### Menu for Further App Assistance
![MenuClosed](CodeWarsTracker/Assets.xcassets/MenuClosed.imageset/MenuClosed.png) ![MenuOpened](CodeWarsTracker/Assets.xcassets/MenuOpened.imageset/MenuOpened.png)
![FindAPairing](CodeWarsTracker/Assets.xcassets/FindAPairing.imageset/FindAPairing.png)
![HowToPair](CodeWarsTracker/Assets.xcassets/HowToPair.imageset/HowToPair.png)
![HowToUse](CodeWarsTracker/Assets.xcassets/HowToUse.imageset/HowToUse.png)

## Code Block

### Asynchronous Test

```Swift
func testFetchUserById() {
    let exp = XCTestExpectation(description: "fetched a user by id")
    CWTAPIClient.fetchUserById(id: "5") { (result) in
        switch result {
        case .failure(let appError):
            print(appError)
            XCTFail("\(appError)")
        case .success(let userById):
            exp.fulfill()
            XCTAssertEqual(userById.id, 5)
        }
    } 
    wait(for: [exp], timeout: 5.0)
}
```

## Installation

### Clone

* Clone this repo to your local machine using

### Setup

* Add a Swift file named Secrets to project directory.

* in file add following code

```swift

```

## Built With

* XCode
* Swift
* SnapKit
* Safari Services
* DropDown
* XCTest
* UIKit
* Foundation
* MVC Architecture, Programmatic UI

## Collaborators

[Juan Ceballos](https://github.com/Juan-Ceballos)

[![Juan](https://avatars1.githubusercontent.com/u/55723135?s=250&u=cce4396e360011123eebd2f52323aa6248023ef0&v=4)](https://github.com/Juan-Ceballos)

