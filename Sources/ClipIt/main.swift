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
