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
            url: "https://github.com/maplibre/maplibre-native/releases/download/ios-v7.0.0-pre1/MapLibre.dynamic.plugins.xcframework.zip",
            checksum: "62ef0cadc4b80c26dbd0bce245c5c25cf8bc4d6b648b5bf4659f41b32177051b"),
        .target(
            name: "MapLibrePluginApi",
            path: "Sources/MapLibrePluginApi")
    ]
)
