import Vapor
import HTTP

final class DashboardController {
    
    let drop: Droplet
    
    init(droplet: Droplet) {
        drop = droplet
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        return try drop.view.make("base", [
            "name": "Leaf 🍃"
        ])
    }
    
}
