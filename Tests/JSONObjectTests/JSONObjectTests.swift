import Testing
@testable import JSONObject

@Test func String() async throws {
    #expect(JSONObject(dict: ["name": "value"]).value(key: "name", defaultValue: "") == "value")
}

@Test func Int() async throws {
    #expect(JSONObject(dict: ["name": 10]).value(key: "name", defaultValue: 0) == 10)
    #expect(JSONObject(dict: ["name": "10"]).value(key: "name", defaultValue: 0) == 10)
}

@Test func Double() async throws {
    #expect(JSONObject(dict: ["name": 10.10]).value(key: "name", defaultValue: 0.0) == 10.10)
    #expect(JSONObject(dict: ["name": "10.10"]).value(key: "name", defaultValue: 0.0) == 10.10)
}

@Test func Int2Double() async throws {
    #expect(JSONObject(dict: ["name": 10]).value(key: "name", defaultValue: 0.0) == 10.0)
    #expect(JSONObject(dict: ["name": "10"]).value(key: "name", defaultValue: 0.0) == 10.0)
}

@Test func Double2IntExact() async throws {
    #expect(JSONObject(dict: ["name": 10.0]).value(key: "name", defaultValue: 0) == 10)
    #expect(JSONObject(dict: ["name": "10.0"]).value(key: "name", defaultValue: 0) == 10)
}

@Test func Double2IntTrunc() async throws {
    #expect(JSONObject(dict: ["name": 10.99]).value(key: "name", defaultValue: 0) == 10)
    #expect(JSONObject(dict: ["name": "10.99"]).value(key: "name", defaultValue: 0) == 10)
}

@Test func RawNameTest() async throws {
    let json1 = JSONObject(dict: ["first": ["second": 1]])
    #expect(json1.value(key: "first.second", defaultValue: 0) == 1)
    #expect(json1.value(key: "first.second", defaultValue: 0, rawName: true) == 0)

    let json2 = JSONObject(dict: ["first.second": 1])
    #expect(json2.value(key: "first.second", defaultValue: 0) == 0)
    #expect(json2.value(key: "first.second", defaultValue: 0, rawName: true) == 1)
    
    let json3 = JSONObject(dict: ["first": ["second": ["three": 1]]])
    #expect(json3.object(key: "first.second").value(key: "three", defaultValue: 0) == 1)
    #expect(json3.object(key: "first.second", rawName: true).value(key: "three", defaultValue: 0) == 0)

}
