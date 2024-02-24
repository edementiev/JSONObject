import XCTest
@testable import JSONObject

final class JSONObjectTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        // String
        XCTAssertEqual(JSONObject(dict: ["name": "value"]).value(key: "name", defaultValue: ""), "value")
        
        // Int
        XCTAssertEqual(JSONObject(dict: ["name": 10]).value(key: "name", defaultValue: 0), 10)
        XCTAssertEqual(JSONObject(dict: ["name": "10"]).value(key: "name", defaultValue: 0), 10)
        
        // Double
        XCTAssertEqual(JSONObject(dict: ["name": 10.10]).value(key: "name", defaultValue: 0.0), 10.10)
        XCTAssertEqual(JSONObject(dict: ["name": "10.10"]).value(key: "name", defaultValue: 0.0), 10.10)

        // Int -> Double
        XCTAssertEqual(JSONObject(dict: ["name": 10]).value(key: "name", defaultValue: 0.0), 10.0)
        XCTAssertEqual(JSONObject(dict: ["name": "10"]).value(key: "name", defaultValue: 0.0), 10.0)

        // Double -> Int (Exact)
        XCTAssertEqual(JSONObject(dict: ["name": 10.0]).value(key: "name", defaultValue: 0), 10)
        XCTAssertEqual(JSONObject(dict: ["name": "10.0"]).value(key: "name", defaultValue: 0), 10)

        // Double -> Int (Trunc)
        XCTAssertEqual(JSONObject(dict: ["name": 10.99]).value(key: "name", defaultValue: 0), 10)
        XCTAssertEqual(JSONObject(dict: ["name": "10.99"]).value(key: "name", defaultValue: 0), 10)
    }
}
