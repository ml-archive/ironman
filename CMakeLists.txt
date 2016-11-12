cmake_minimum_required(VERSION 3.6)
project(ops-dashboard)
file(GLOB opsDashSrc
        "*.swift"
        "Sources/*.swift"
        "Sources/*/*.swift"
        "Sources/*/*/*.swift"
        "Sources/*/*/*/*.swift"
        "Sources/*/*/*/*/*.swift"
        "Sources/*/*/*/*/*/*.swift"
        "Sources/*/*/*/*/*/*/*.swift"
        "Sources/*/*/*/*/*/*/*/*.swift"
        "Sources/*/*/*/*/*/*/*/*/*.swift"
        "Sources/*/*/*/*/*/*/*/*/*/*.swift"
        "Packages/*.swift"
        "Packages/*/*.swift"
        "Packages/*/*/*.swift"
        "Packages/*/*/*/*.swift"
        "Packages/*/*/*/*/*.swift"
        "Packages/*/*/*/*/*/*.swift"
        "Packages/*/*/*/*/*/*/*.swift"
        "Packages/*/*/*/*/*/*/*/*.swift"
        "Packages/*/*/*/*/*/*/*/*/*.swift"
        "Packages/*/*/*/*/*/*/*/*/*/*.swift"
        )
add_custom_target(ops-dashboard
        COMMAND /swift-3.0/usr/bin/swift build
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        SOURCES ${opsDashSrc})