//
//  Users.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

// MARK: - WelcomeElement
struct Users: Codable {
    let id: Int?
    let avatar: String?
    let name, username, email: String?
    let phone, website: String?
}

struct User: Equatable, Identifiable {
    typealias Identifier = Int
    let id: Identifier
    let avatar: String?
    let name, username, email: String?
    let phone, website: String?
}

struct UserDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case avatar
        case name
        case username
        case email
        case phone
        case website
    }
   
    let id: Int
    let avatar: String?
    let name, username, email: String?
    let phone: String?
    let website: String?
}

extension UserDTO {
    func toDomain() -> User {
        return .init(id: User.Identifier(id), avatar: avatar, name: name, username: username, email: email, phone: phone, website: website)
    }
}

