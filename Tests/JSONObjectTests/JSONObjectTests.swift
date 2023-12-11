import XCTest
@testable import JSONObject

final class JSONObjectTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(JSONObject(dict: ["name": "value"]).value(key: "name", defaultValue: ""), "value")
    }
}
