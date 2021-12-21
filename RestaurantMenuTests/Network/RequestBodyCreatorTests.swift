//
//  RequestBodyCreatorTests.swift
//  RestaurantMenuTests
//
//  Created by Thiago Lourin on 20/12/21.
//

import XCTest
@testable import RestaurantMenu

class RequestBodyCreatorTests: XCTestCase {
    
    var sut: RequestBodyCreator!

    override func setUpWithError() throws {
        sut = RequestBodyCreator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testRequestBodyCreatorWithInvalidUrlStringThrowsError() {
        let emptyString = ""
        
        XCTAssertThrowsError(try sut.create(for: EmptyEndpointPathMockRequest(), url: emptyString), "RequestBodyCreator.create should raise an error when using an invalid url string. ") { error in
            XCTAssertEqual(error as? NetworkError, .invalidUrlString(url: emptyString))
        }
    }
    
    func testRequestBodyCreatorWithInvalidURLThrowsError() {
        let validUrlString = "http://a-url.com"
        
        XCTAssertThrowsError(try sut.create(for: EmptyEndpointPathMockRequest(), url: validUrlString), "RequestBodyCreator.create should raise an error when using an invalid path.") { error in
            XCTAssertEqual(error as? NetworkError, .emptyPath)
        }
    }
    
    func testRequestBodyCreatorWithGetMethodOnRequestReturnsGetMethod() {
        let validUrlString = "http://a-url.com"
        
        let requestData = try! sut.create(for: MockRequest(), url: validUrlString)
        
        XCTAssertEqual(requestData.httpMethod!, HttpMethod.get.rawValue)
    }

}

struct EmptyEndpointPathMockRequest: APIRequest {
    typealias Response = MockResponse
    var resourcePath: String {
        return ""
    }
    
    var method: HttpMethod {
        return .get
    }
    
}

struct MockRequest: APIRequest {
    typealias Response = MockResponse
    
    var resourcePath: String {
        return "/some-endpoint"
    }
    
    var method: HttpMethod {
        return .get
    }
}

struct MockResponse: APIResponse {
    let anyField: String
}
