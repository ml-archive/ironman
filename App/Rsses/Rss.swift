import Vapor
import Fluent

final class Rss: Model {
    var id: Node?
    var name: String
    var url: String
    
    var isForLiveTicker: Bool
    var isActive: Bool
    var createdAt: String
    var updatedAt: String
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        url = try node.extract("url")
        
        isForLiveTicker = try node.extract("is_for_live_ticker")
        isActive = try node.extract("is_active")
        createdAt = try node.extract("created_at")
        updatedAt = try node.extract("updated_at")
    }
    
    func makeNode() throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name,
            "url": url,
            
            "is_for_live_ticker": isForLiveTicker,
            "is_active": isActive,
            "created_at": createdAt,
            "updated_at": updatedAt
        ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("rss") { rsses in
            rsses.id()
            rsses.int("race_id");
            rsses.string("name")
            rsses.string("url")
            
            rsses.bool("is_active")
            rsses.bool("is_for_live_ticker")
            
            rsses.string("created_at", optional: true)
            rsses.string("updated_at", optional: true)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("rss")
    }
}
