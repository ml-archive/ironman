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
        .Package(url: "https://github.com/vapor/leaf.git", majorVersion: 0, minor: 2),
        .Package(url: "https://github.com/vapor/mysql-provider.git", majorVersion: 0),
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

