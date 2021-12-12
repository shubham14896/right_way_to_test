//
// Copyright © Essential Developer. All rights reserved.
//

@testable import CrashCourse
import XCTest

class FriendsTests: XCTestCase {
    func test_viewDidLoad_doesNotLoadFromFriendsAPI() {
        // Arrange
        let service = FriendsServiceSpy()
        let sut = FriendsViewController(service: service)

        // Act
        sut.loadViewIfNeeded()

        // Assert
        XCTAssertEqual(service.loadFriendsCallCount, 0)
    }

    func test_viewWillAppear_loadsFromFriendsAPI() {
        // Arrange
        let service = FriendsServiceSpy()
        let sut = FriendsViewController(service: service)

        // Act
        sut.simulateViewWillAppear()

        // Assert
        XCTAssertEqual(service.loadFriendsCallCount, 1)
    }

    func test_viewWillAppear_successfulAPIResponse_showsFriends() {
        // Arrange
        let friend1 = Friend(id: UUID(), name: "f1", phone: "")
        let friend2 = Friend(id: UUID(), name: "f2", phone: "")
        let service = FriendsServiceSpy(result: [friend1, friend2])
        let sut = FriendsViewController(service: service)

        // Act
        sut.simulateViewWillAppear()

        // Assert
        sut.assert(isRendering: [friend1, friend2])
    }

    func test_viewWillAppear_failedAPIResponse_3times_showsError() {
        // Arrange
        let service = FriendsServiceSpy(results: [
            .failure(AnyError(errorDescription: "1st error")),
            .failure(AnyError(errorDescription: "2nd error")),
            .failure(AnyError(errorDescription: "3rd error")),
        ])
        let sut = TestableFriendsViewController(service: service)

        // Act
        sut.simulateViewWillAppear()

        // Assert
        XCTAssertEqual(sut.errorMessage(), "3rd error")
    }

    func test_viewWillAppear_successAfterAPIResponse_1times_showsFriends() {
        // Arrange
        let friend = Friend(id: UUID(), name: "f1", phone: "")
        let service = FriendsServiceSpy(results: [
            .failure(AnyError(errorDescription: "1st error")),
            .success([friend]),
        ])
        let sut = TestableFriendsViewController(service: service)

        // Act
        sut.simulateViewWillAppear()

        // Assert
        sut.assert(isRendering: [friend])
    }

    func test_viewWillAppear_successAfterAPIResponse_2times_showsFriends() {
        // Arrange
        let friend = Friend(id: UUID(), name: "f1", phone: "")
        let service = FriendsServiceSpy(results: [
            .failure(AnyError(errorDescription: "1st error")),
            .failure(AnyError(errorDescription: "2nd error")),
            .success([friend]),
        ])
        let sut = TestableFriendsViewController(service: service)

        // Act
        sut.simulateViewWillAppear()

        // Assert
        sut.assert(isRendering: [friend])
    }

    func test_friendSelection_showFriendDetails() {
        // Arrange
        let friend = Friend(id: UUID(), name: "a friend", phone: "")
        let service = FriendsServiceSpy(results: [
            .success([friend]),
        ])
        let sut = FriendsViewController(service: service)
        let navigation = NonAnimatedUINavigationController(rootViewController: sut)
        // Act
        sut.simulateViewWillAppear()
        sut.selectFriend(at: 0)

        // Assert
        let detail = navigation.topViewController as? FriendDetailsViewController
        XCTAssertEqual(detail?.friend, friend)
    }
}

private struct AnyError: LocalizedError {
    var errorDescription: String?
}

private class NonAnimatedUINavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}

private class TestableFriendsViewController: FriendsViewController {
    var presentedVC: UIViewController?
    override func present(_ vc: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedVC = vc
    }

    func errorMessage() -> String? {
        let alert = presentedVC as? UIAlertController
        return alert?.message
    }
}

private extension FriendsViewController {
    func simulateViewWillAppear() {
        loadViewIfNeeded()
        beginAppearanceTransition(true, animated: false)
    }

    func assert(isRendering friends: [Friend]) {
        XCTAssertEqual(numberOfFriends(), friends.count)

        for (index, friend) in friends.enumerated() {
            XCTAssertEqual(friendName(at: index), friend.name)
            XCTAssertEqual(friendPhone(at: index), friend.phone)
        }
    }

    func selectFriend(at row: Int) {
        let indexPath = IndexPath(row: row, section: friendsSection)
        tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }

    func numberOfFriends() -> Int {
        tableView.numberOfRows(inSection: friendsSection)
    }

    func friendName(at row: Int) -> String? {
        friendCell(at: row)?.textLabel?.text
    }

    func friendPhone(at row: Int) -> String? {
        friendCell(at: row)?.detailTextLabel?.text
    }

    private func friendCell(at row: Int) -> UITableViewCell? {
        let indexPath = IndexPath(row: row, section: friendsSection)
        return tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath)
    }

    private var friendsSection: Int { 0 }
}

class FriendsServiceSpy: FriendService {
    private(set) var loadFriendsCallCount = 0
    private var results: [Result<[Friend], Error>]
    init(result: [Friend] = []) {
        results = [.success(result)]
    }

    init(results: [Result<[Friend], Error>]) {
        self.results = results
    }

    func loadFriends(completion: @escaping (Result<[Friend], Error>) -> Void) {
        loadFriendsCallCount += 1
        completion(results.removeFirst())
    }
}
