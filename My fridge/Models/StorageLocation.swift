import Foundation

enum StorageLocation: String, CaseIterable, Codable {
    case home = "Дом"
    case work = "Работа"
    case dacha = "Дача"
    case other = "Другое"
    
    static var allLocations: [StorageLocation] {
        return [.home, .work, .dacha, .other]
    }
    
    static var defaultLocation: StorageLocation {
        return .home
    }
} 