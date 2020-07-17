<h2>SwiftBlocksUI: ClipIt
  <img src="https://zeezide.com/img/blocksui/SwiftBlocksUIIcon256.png"
       align="right" width="100" height="100" />
</h2>

SwiftBlocksUI is a way to write interactive Slack messages and modal dialogs
(also known as Slack "applications")
using a SwiftUI like declarative style.

Explained in blog article/tutorial: 
[Instant “SwiftUI” Flavoured Slack Apps](http://www.alwaysrightinstitute.com/swiftblocksui/).

This repository contains the ClipIt demo,
loosely based on the official Slack tutorial:
[Make your Slack app accessible directly from a message](https://api.slack.com/tutorials/message-action).

What we want to do here is work on some arbitrary message the user selects.
This is possible using "Message Actions" 
(called "Message Shortcuts" in the admin panel).

<center>
  <img src="https://www.alwaysrightinstitute.com/images/blocksui/client-clipit-menu-markup.png" 
       style="border-radius: 8px; border: 1px solid #EAEAEA; width: 75%;">
</center>

## How to Run

This demo requires a Slack bot authentication token, which can be found
on the 
<a href="https://api.slack.com/apps" target="Slack">Admin Panel</a>,
"OAuth & Permissions" section in the sidebar,
"Bot User OAuth Access Token".

If [swift-sh](https://github.com/mxcl/swift-sh) is installed,

a simple `./Sources/ClipIt/main.swift` does the job.

Alternatively: `swift run`:
```bash
Zini18:ClipIt helge$ export SLACK_ACCESS_TOKEN=xoxb-YOUR-TOKEN
Zini18:ClipIt helge$ swift run
2020-07-17T17:13:12+0200 notice μ.console : App started on port: 1337
```

## How to Build

```bash
cd ClipIt
swift build
```

Or open the `Package.swift` in Xcode and build it there.

## Full Source

```swift
#!/usr/bin/swift sh

import SwiftBlocksUI // @SwiftBlocksUI ~> 0.8.0

dotenv.config()

struct ClipItForm: Blocks {

  @State(\.messageText) var messageText
  @State var importance = "medium"
  
  var body: some Blocks {
    View("Save it to ClipIt!") {
      TextEditor("Message Text", text: $messageText)
      
      Picker("Importance", selection: $importance,
             placeholder: "Select importance")
      {
        "High 💎💎✨".tag("high")
        "Medium 💎"  .tag("medium")
        "Low ⚪️"     .tag("low")
      }
      
      Submit("CliptIt") {
        console.log("Clipping:", self.messageText, self.importance)
      }
    }
  }
}

struct ClipIt: App {
  
  var body: some Endpoints {
    Group { // only necessary w/ Swift <5.3
      Use(logger("dev"),
          bodyParser.urlencoded(),
          sslCheck(verifyToken(allowUnsetInDebug: true)))

      MessageAction("clipit") {
        ClipItForm()
      }
    }
  }
}
try ClipIt.main()
```

## Environment Variables

- `SLACK_ACCESS_TOKEN` (the token required to send requests to Slack)
- `SLACK_VERIFICATION_TOKEN` (shared secret with Slack to verify requests)
- `PORT` (the port the app is going to start on, defaults to 1337)

## Requirements

On Linux this currently requires a Swift 5.3 environment
(swiftc crash, might be [SR-12543](https://bugs.swift.org/browse/SR-12543)).

On macOS it should work with Swift 5.2 (aka Xcode 11) and up,
though 5.3 has some additional conveniences.

### Who

**SwiftBlocksUI** is brought to you by
the
[Always Right Institute](http://www.alwaysrightinstitute.com)
and
[ZeeZide](http://zeezide.de).
We like 
[feedback](https://twitter.com/ar_institute), 
GitHub stars, 
cool [contract work](http://zeezide.com/en/services/services.html),
presumably any form of praise you can think of.
