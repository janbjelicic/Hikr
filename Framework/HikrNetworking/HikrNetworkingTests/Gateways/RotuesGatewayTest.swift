//
//  RotuesGatewayTest.swift
//  HikrNetworkingTests
//
//  Created by Jan Bjelicic on 25/02/2021.
//

import XCTest
@testable import HikrNetworking

class RoutesGatewayTest: XCTestCase {
    
    private var sut: RoutesGateway!
    private var fakeRestApi: FakeRestApi!
    
    override func setUp() {
        super.setUp()
        
        fakeRestApi = FakeRestApi()
        sut = RoutesGateway(api: fakeRestApi)
    }
    
    func test_given_getRoutes_then_checkPathMethod() {
        let expectation = XCTestExpectation(description: #function)
        sut.get(routesData: RoutesRequest())
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Test should not fail. \(error)")
                case .finished:
                    expectation.fulfill()
                }
            } receiveValue: { _ in
                
            }.cancel()
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(fakeRestApi.method, .get)
        XCTAssertEqual(fakeRestApi.path, "routes")
    }
    
}
