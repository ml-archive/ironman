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
    .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 1),
        .Package(url: "https://github.com/vapor/leaf.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/mysql-provider.git", majorVersion: 1, minor: 1),
        .Package(url: "https://github.com/nodes-vapor/SWXMLHash.git", majorVersion: 3)
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

