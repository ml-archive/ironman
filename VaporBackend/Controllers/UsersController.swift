import Vapor
import HTTP

public final class UsersController {
    
    public let drop: Droplet
    
    public init(droplet: Droplet) {
        drop = droplet
    }
    
    public func index(request: Request) throws -> ResponseRepresentable {
        return try drop.view.make("Users/index", [
            
        ])
    }

    public func create(request: Request) throws -> ResponseRepresentable {
        return try drop.view.make("Users/edit", [
            
        ])
    }
    
}
