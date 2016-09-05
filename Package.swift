import PackageDescription

let package = Package(
    name: "ironman",
    targets: [
        Target(name: "VaporBackend"),
        Target(name: "App", dependencies: [
            .Target(name: "VaporBackend")
        ])
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 0),
        .Package(url: "https://github.com/vapor/leaf.git", majorVersion: 0)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
        "VaporBackend/node_modules",
        "VaporBackend/bower_components"
    ]
)

