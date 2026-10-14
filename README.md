# MapLibre Native for iOS with the plugin API

[![SPM compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-FA7343.svg?style=flat&logo=Swift)](https://swift.org/package-manager/)

> **Note**
> This repository only exists for binary distribution of a **plugin-enabled** build of MapLibre Native for iOS.
> Please use the [main MapLibre Native repository](https://github.com/maplibre/maplibre-native) to report issues or ask for help.
> The standard SDK is distributed through [maplibre/maplibre-gl-native-distribution](https://github.com/maplibre/maplibre-gl-native-distribution).

The XCFramework in this package is built from the same sources as the standard MapLibre iOS SDK, with the
experimental C plugin API enabled (`--//:plugins=true`). It is otherwise identical: the framework and module are
both called `MapLibre`, so application code keeps using `import MapLibre` or `#import <MapLibre/MapLibre.h>`.
The framework additionally exports `mln_plugin_register_v1`.

The plugin API is experimental. Its ABI can change between pre-releases; build plugins against the same version
of this package that the application uses.

## MapLibre iOS distributions

MapLibre iOS is distributed as two Swift packages, both built from the same [MapLibre Native](https://github.com/maplibre/maplibre-native) releases. Use one of them per application.

| Distribution | Swift package | Releases |
| --- | --- | --- |
| MapLibre iOS | [maplibre/maplibre-gl-native-distribution](https://github.com/maplibre/maplibre-gl-native-distribution) | [Releases](https://github.com/maplibre/maplibre-gl-native-distribution/releases) |
| MapLibre iOS with the experimental C plugin API | [maplibre/maplibre-ios-with-plugin-api](https://github.com/maplibre/maplibre-ios-with-plugin-api) | [Releases](https://github.com/maplibre/maplibre-ios-with-plugin-api/releases) |

## Products

| Product | Use it in | Contents |
| --- | --- | --- |
| `MapLibre` | Applications | The plugin-enabled `MapLibre.xcframework`. Replaces the standard `MapLibre` product. |
| `MapLibrePluginApi` | Plugin packages | Header-only C API, included as `<mln/plugin/plugin_api.h>`. No binary. |

Plugin packages should depend only on `MapLibrePluginApi`, never on `MapLibre`, so the application decides which
MapLibre framework it links. Because both products come from this package, Swift Package Manager resolves the
header and the binary to the same version.

Use only one MapLibre package per application. This package and `maplibre-gl-native-distribution` both provide a
`MapLibre` module with the same Objective-C classes, so a dependency graph that contains both cannot link.

## Add it to your project

In Xcode, select File > Add Package Dependencies and enter `https://github.com/maplibre/maplibre-ios-with-plugin-api`.
In a `Package.swift`:

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

See [louwers/maplibre-native-plugin-template](https://github.com/louwers/maplibre-native-plugin-template) for
example plugins.

## Releases

Releases are made by the [`release`](.github/workflows/release.yml) workflow, which the MapLibre iOS release
workflow in `maplibre/maplibre-native` dispatches with the release's `MapLibre.dynamic.plugins.xcframework.zip`. It points the binary target at
that asset, copies `include/mln/plugin/plugin_api.h` from the matching `ios-v<version>` tag, and tags the version.

## Test MapLibre with a Swift Playground

Open `Package.swift` in Xcode, then run `MapLibreTest.playground` with Editor > Run Playground.
