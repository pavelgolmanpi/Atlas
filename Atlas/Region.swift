import Foundation

struct Region {
    let name: String
    
    init?(object: [String: Any]) {
        guard let name = object["name"] as? String else {
            return nil
        }
        self.name = name
    }
    
    init(_ name: String) {
        self.name = name
    }
}
