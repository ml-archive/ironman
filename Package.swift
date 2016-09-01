import PackageDescription

let package = Package(
    name: "ironman",
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
        "node_modules",
        "bower_components"
    ]
)

