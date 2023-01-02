// swift-tools-version:5.5

import PackageDescription

let package = Package(
  
  name: "ClipIt",

  platforms: [
    .macOS(.v10_15), .iOS(.v13)
  ],
  
  products: [
    .executable(name: "ClipIt", targets: [ "ClipIt" ]),
  ],
  
  dependencies: [
    .package(url: "https://github.com/SwiftBlocksUI/SwiftBlocksUI.git",
             from: "0.9.4")
  ],
  
  targets: [
    .executableTarget(name: "ClipIt", dependencies: [ "SwiftBlocksUI" ])
  ]
)
