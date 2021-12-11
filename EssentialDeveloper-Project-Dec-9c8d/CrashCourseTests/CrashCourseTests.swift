//
// Copyright © Essential Developer. All rights reserved.
//

@testable import CrashCourse
import XCTest

class TestFriends: XCTestCase {
    func test_reload_friends_asPremiumUser_withoutConnection_showError() {
        // Arrange (Given)
        let service = FriendsAPIStub(result: .success([
            makeFriend(),
            makeFriend(),
        ]))
        let sut = TestableListViewController()
        sut.fromFriendsScreen = true
        sut.user = makePremiumUser()
        sut.friendsService = service

        // Act (When)
        sut.simulateFirstRequest()
        service.result = .failure(AnyError())
        sut.simulateReloadRequest()

        // Assert (Then)
        XCTAssertTrue(sut.presentedVC is UIAlertController)
    }
}

private struct AnyError: Error {
}

private class TestableListViewController: ListViewController {
    var presentedVC: UIViewController?
    override func present(_ vc: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedVC = vc
    }
}

private extension ListViewController {
    func simulateFirstRequest() {
        loadViewIfNeeded()
        beginAppearanceTransition(true, animated: false)
    }

    func simulateReloadRequest() {
        refreshControl?.sendActions(for: .valueChanged)
    }
}

private func makePremiumUser() -> User {
    User(id: UUID(), name: "a name", isPremium: true)
}

private func makeFriend() -> Friend {
    Friend(id: UUID(), name: "friend1", phone: "phone1")
}

private class FriendsAPIStub: FriendService {
    var result: Result<[Friend], Error>

    init(result: Result<[Friend], Error>) {
        self.result = result
    }

    func loadFriends(completion: @escaping (Result<[Friend], Error>) -> Void) {
        completion(result)
    }
}
