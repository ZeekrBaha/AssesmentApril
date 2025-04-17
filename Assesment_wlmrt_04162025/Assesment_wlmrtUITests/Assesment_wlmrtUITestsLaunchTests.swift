//
//  Assesment_wlmrtUITestsLaunchTests.swift
//  Assesment_wlmrtUITests
//
//  Created by Baha Sadyr on 4/16/25.
//

import XCTest

final class Assesment_wlmrtUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()


        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
