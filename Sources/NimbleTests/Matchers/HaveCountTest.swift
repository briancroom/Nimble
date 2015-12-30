import XCTest
import Nimble

class HaveCountTest: XCTestCase, XCTestCaseProvider {
    var allTests: [(String, () -> Void)] {
        return [
            ("testHaveCountForArray", testHaveCountForArray),
            ("testHaveCountForDictionary", testHaveCountForDictionary),
            ("testHaveCountForSet", testHaveCountForSet),
        ]
    }

    func testHaveCountForArray() {
        expect([1, 2, 3]).to(haveCount(3))
        expect([1, 2, 3]).notTo(haveCount(1))

        failsWithErrorMessage("expected to have [1, 2, 3] with count 1, got 3") {
            expect([1, 2, 3]).to(haveCount(1))
        }

        failsWithErrorMessage("expected to not have [1, 2, 3] with count 3, got 3") {
            expect([1, 2, 3]).notTo(haveCount(3))
        }
    }

    func testHaveCountForDictionary() {
        let dict = ["1":1, "2":2, "3":3]

        expect(dict).to(haveCount(3))
        expect(dict).notTo(haveCount(1))

        failsWithErrorMessage("expected to have \(dict) with count 1, got 3") {
            expect(dict).to(haveCount(1))
        }

        failsWithErrorMessage("expected to not have \(dict) with count 3, got 3") {
            expect(dict).notTo(haveCount(3))
        }
    }

    func testHaveCountForSet() {
        expect(Set([1, 2, 3])).to(haveCount(3))
        expect(Set([1, 2, 3])).notTo(haveCount(1))

        failsWithErrorMessage("expected to have [2, 3, 1] with count 1, got 3") {
            expect(Set([1, 2, 3])).to(haveCount(1))
        }

        failsWithErrorMessage("expected to not have [2, 3, 1] with count 3, got 3") {
            expect(Set([1, 2, 3])).notTo(haveCount(3))
        }
    }
}
