//
//  photosServiceTest.swift
//  photosDemoTests
//
//  Created by dmatiaz on 20/3/22.
//

import XCTest
@testable import photosDemo

class photosServiceTest: XCTestCase {

    private var photoService: PhotoService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        photoService = PhotoService()
    }

    override func tearDownWithError() throws {
        photoService = nil
        try super.tearDownWithError()
    }

    func testPhotoService() throws {
        let promise = expectation(description: "API Call Result")
        photoService.getPhotos { result in
            guard let downloadedPhotos = try? result.get() as? [Photo] else {
                promise.fulfill()
                XCTFail("Test Error: Couldn't Parse Photos")
                return
            }
            promise.fulfill()
            XCTAssert(downloadedPhotos.count > 0, "Test Error: No Photos Available")
        }
        wait(for: [promise], timeout: 6)
    }
}
