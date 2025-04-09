//
//  Users.swift
//  LeagueiOSChallenge
//
//  Created by Basivi Reddy on 08/04/25.
//

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

struct ApiKey: Codable {
    let apiKey: String?

    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
    }
}

