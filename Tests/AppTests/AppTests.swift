import XCTest

class AppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    static let allTests = [
        ("testIronman", testIronman),
        ]
    
    func testIronman() {
        let bool = true;
        XCTAssertTrue(bool, "Ironman is true")
    }
}
