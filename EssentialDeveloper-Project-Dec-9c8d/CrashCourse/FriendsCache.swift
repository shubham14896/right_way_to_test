//
// Copyright © Essential Developer. All rights reserved.
//

import Foundation

class FriendsCache {
    private var friends: [Friend]?
    struct NoFriendsFound: Error {
    }

    func loadFriends(completion: @escaping (Result<[Friend], Error>) -> Void) {
        if let friends = friends {
            completion(.success(friends))
        } else {
            completion(.failure(NoFriendsFound()))
        }
    }

    func save(_ newFriends: [Friend]) {
        friends = newFriends
    }
}
