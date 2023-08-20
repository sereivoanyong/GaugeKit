// swift-tools-version: 5.8
import PackageDescription

let package = Package(
  name: "GaugeKit",
  products: [
    .library(name: "GaugeKit", targets: ["GaugeKit"])
  ],
  targets: [
    .target(name: "GaugeKit", path: "GaugeKit", exclude: ["GaugeKit.h", "Info.plist"])
  ]
)
