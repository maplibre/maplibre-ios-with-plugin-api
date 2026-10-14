# MapLibre iOS with plugin API

[![SPM compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-FA7343.svg?style=flat&logo=Swift)](https://swift.org/package-manager/)

> [!WARNING]
> The plugin API is experimental.

This repository only exists for binary distribution of MapLibre iOS with plugin API as a Swift package. Please use the [main MapLibre Native repository](https://github.com/maplibre/maplibre-native) to report issues or ask for help.

## MapLibre iOS distributions

MapLibre iOS is distributed as two Swift packages, both built from the same [MapLibre Native](https://github.com/maplibre/maplibre-native) releases. Use one of them per application.

| Distribution | Package URL | Framework |
| --- | --- | --- |
| MapLibre iOS | https://github.com/maplibre/maplibre-gl-native-distribution | Dynamic XCFramework |
| MapLibre iOS with plugin API | https://github.com/maplibre/maplibre-ios-with-plugin-api | Dynamic XCFramework |

## Add MapLibre to your project

In Xcode, select File > Add Package Dependencies and enter `https://github.com/maplibre/maplibre-ios-with-plugin-api`. See [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

## Plugins

| Product | Use it in | Contents |
| --- | --- | --- |
| `MapLibre` | Applications | `MapLibre.xcframework` with the plugin API enabled. |
| `MapLibrePluginApi` | Plugin packages | The C plugin API, included as `<mln/plugin/plugin_api.h>`. |

Plugin packages should depend only on `MapLibrePluginApi`, so the application decides which MapLibre framework it links. Both products come from this package, so Swift Package Manager resolves the header and the framework to the same version.

```swift
dependencies: [
    .package(url: "https://github.com/maplibre/maplibre-ios-with-plugin-api", exact: "7.0.0-pre2"),
],
targets: [
    // Application
    .target(name: "App", dependencies: [.product(name: "MapLibre", package: "maplibre-ios-with-plugin-api")]),
    // Plugin
    .target(name: "MyLayer", dependencies: [.product(name: "MapLibrePluginApi", package: "maplibre-ios-with-plugin-api")]),
]
```

Register plugins before creating a map that loads a style using their layer types:

```objc
#import <MapLibre/MapLibre.h>
#include "my_layer.hpp" // includes <mln/plugin/plugin_api.h>

char error[512] = {};
mln_plugin_status status = my_layer_register(&mln_plugin_register_v1, error, sizeof(error));
```
