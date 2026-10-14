// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MapLibre Native with Plugin API",
    products: [
        // Drop-in replacement for the standard MapLibre product: `import MapLibre`.
        .library(
            name: "MapLibre",
            targets: ["MapLibre"]),
        // Header-only C plugin API for plugin packages. Applications link `MapLibre`.
        .library(
            name: "MapLibrePluginApi",
            targets: ["MapLibrePluginApi"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "MapLibre",
            url: "https://github.com/maplibre/maplibre-native/releases/download/ios-v7.0.0-pre2/MapLibre.dynamic.plugins.xcframework.zip",
            checksum: "42c969b952c9c76bd040212ba8ad9f693c7ee755e2fd242fba2e564767af02aa"),
        .target(
            name: "MapLibrePluginApi",
            path: "Sources/MapLibrePluginApi")
    ]
)
