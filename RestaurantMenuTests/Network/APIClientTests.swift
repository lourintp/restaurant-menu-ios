//
//  APIClientTests.swift
//  RestaurantMenuTests
//
//  Created by Thiago Lourin on 20/12/21.
//

import XCTest
@testable import RestaurantMenu

class APIClientTests: XCTestCase {
    
    private var sut: APIClient!
    private var requestBodyCreator: RequestBodyCreatorMock!
    private var networkAdapter: NetworkAdapterMock!

    override func setUpWithError() throws {
        requestBodyCreator = RequestBodyCreatorMock()
        networkAdapter = NetworkAdapterMock()
        sut = APIClient(networkAdapter: networkAdapter, requestBody: requestBodyCreator)
    }

    override func tearDownWithError() throws {
        requestBodyCreator = nil
        networkAdapter = nil
        sut = nil
    }

    func testApiGetWithInvalidUrlReturnsInvalidUrlStringError() {
        let expectation = expectation(description: "requestExpectation")
        requestBodyCreator.shouldRaiseError = true
        
        sut.get(MockRequest()) { response in
            guard case .failure(.invalidUrlString(url: "https://api.documenu.com/v2")) = response else {
                XCTFail("Request should return failure with invalid string")
                return
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertEqual(requestBodyCreator.createRequestCalled, 1)
        XCTAssertEqual(networkAdapter.callerCounterSpy, 0)
    }
    
    func testApiGetWithValidUrlReturnsSuccess() {
        let expectation = expectation(description: "requestExpectation")
        sut.get(MockRequest()) { response in
            guard case .success = response else {
                XCTFail("Request should return success")
                return
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertEqual(requestBodyCreator.createRequestCalled, 1)
        XCTAssertEqual(networkAdapter.callerCounterSpy, 1)
    }

}

class RequestBodyCreatorMock: RequestBodyCreatorProtocol {
    
    private(set) var createRequestCalled: Int = 0
    public var shouldRaiseError: Bool
    
    init(shouldRaiseError: Bool = false) {
        self.shouldRaiseError = shouldRaiseError
    }
    
    func create<T>(for request: T, url: String) throws -> URLRequest where T : APIRequest {
        createRequestCalled += 1
        
        if shouldRaiseError {
            throw NetworkError.invalidUrlString(url: url)
        }
        return URLRequest(url: URL(string: "http://a-url.com")!)
    }
            
}

class NetworkAdapterMock: NetworkAdapter {
    
    private(set) var callerCounterSpy: Int = 0
    
    func get(destination: URLRequest, responseHandler: @escaping (Data) -> ()) {
        callerCounterSpy += 1
        
        let json = "{ \"anyField\": \"\" }"
        let serializedJson = Data(json.utf8)
        responseHandler(serializedJson)
    }
    
}

struct NetworkMockRequest: Encodable {
    let anyField: String
}
