import Foundation

struct JSONMenu: Codable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
}

struct MenuItem: Codable, Hashable, Identifiable {
    let id = UUID()
    let title: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case price = "price"
    }
}


func decodeMenu(from jsonData: Data) throws -> JSONMenu {
    let decoder = JSONDecoder()
    let menu = try decoder.decode(JSONMenu.self, from: jsonData)
    return menu
}



// Call the main function

