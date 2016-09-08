import Vapor
import HTTP

public final class UsersController {
    
    public let drop: Droplet
    
    public init(droplet: Droplet) {
        drop = droplet
    }
    
    /**
     * List all backend users
     *
     * - param: Request
     * - return: View
     */
    public func index(request: Request) throws -> ResponseRepresentable {
        let users = try BackendUser.all()
        let userNodes = try users.map({ try $0.makeNode() })
        
        
        return try drop.view.make("Users/index", [
            "users": Node(userNodes)
        ])
    }

    /**
     * Create user form
     *
     * - param: Request
     * - return: View
     */
    public func create(request: Request) throws -> ResponseRepresentable {
        return try drop.view.make("Users/edit")
    }
    
    /**
     * Save new user
     *
     * - param: Request
     * - return: View
     */
    public func store(request: Request) throws -> ResponseRepresentable {
        var backendUser = try BackendUser(request: request, hash: drop.hash)
        try backendUser.save()
        
        return Response(redirect: "/admin/users")
    }
    
    /*
    public func edit(request: Request, user: BackendUser) throws -> ResponseRepresentable {
        return try drop.view.make("Users/edit", [
            "backendUser": user
        ])
     }
     */
}
