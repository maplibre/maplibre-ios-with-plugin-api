// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MapLibre Native with Plugin API",
    products: [
        // Drop-in replacement for the standard MapLibre product: `import MapLibre`.
        .library(
            name: "MapLibre",
            targets: ["MapLibre"]),
        // C plugin API for plugin packages: <mln/plugin/plugin_api.h>. Applications link `MapLibre`.
        .library(
            name: "MapLibrePluginApi",
            targets: ["MapLibrePluginApi"])
    ],
    dependencies: [
    ],
    targets: [
        // Both binary targets point at assets of the same MapLibre iOS release; release.yml updates them.
        .binaryTarget(
            name: "MapLibre",
            url: "https://github.com/maplibre/maplibre-native/releases/download/ios-v7.0.0-pre2/MapLibre.dynamic.plugins.xcframework.zip",
            checksum: "0000000000000000000000000000000000000000000000000000000000000000"),
        .binaryTarget(
            name: "MapLibrePluginApi",
            url: "https://github.com/maplibre/maplibre-native/releases/download/ios-v7.0.0-pre2/MapLibrePluginApi.xcframework.zip",
            checksum: "0000000000000000000000000000000000000000000000000000000000000000")
    ]
)
