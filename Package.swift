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
            url: "https://github.com/maplibre/maplibre-native/releases/download/ios-v2026.10.19-globe/MapLibre.dynamic.plugins.xcframework.zip",
            checksum: "2b8b09b610146ea8d2b803ae8dbbace759bec71590066069b17d109d839d86b4"),
        .target(
            name: "MapLibrePluginApi",
            path: "Sources/MapLibrePluginApi")
    ]
)
