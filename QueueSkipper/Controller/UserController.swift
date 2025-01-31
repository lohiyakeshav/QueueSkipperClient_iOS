import Foundation

class UserController {
    private var _credential: [User] = []

    static let shared = UserController()

    var credential: [User] {
        return _credential
    }

    func registerUser(user: User) {
        _credential.append(user)
        saveUsers()
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }

    func loginUser(user: User) {
        _credential = [user]
        saveUsers()
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }

    func logoutUser() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        _credential.removeAll()
        saveUsers()
    }

    init() {
        loadUsers()
    }

    private func saveUsers() {
        if let data = try? JSONEncoder().encode(_credential) {
            UserDefaults.standard.set(data, forKey: "users")
        }
    }

    private func loadUsers() {
        if let data = UserDefaults.standard.data(forKey: "users"),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            _credential = users
        }
    }

    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }

    func getCurrentUser() -> User? {
        return _credential.first
    }
}
