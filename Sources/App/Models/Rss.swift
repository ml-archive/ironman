import Vapor
import Fluent

final class Rss: Model {
    
    static var entity = "rss"
    var exists: Bool = false
    
    var id: Node?
    var raceId: Node
    var name: String
    var url: String
    
    var isForLiveTicker: Bool
    var isActive: Bool
    var createdAt: String
    var updatedAt: String
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        raceId = try node.extract("race_id")
        name = try node.extract("name")
        url = try node.extract("url")
        
        isForLiveTicker = try node.extract("is_for_live_ticker")
        isActive = try node.extract("is_active")
        createdAt = try node.extract("created_at")
        updatedAt = try node.extract("updated_at")
    }
    
    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "race_id": raceId,
            "name": Node(name),
            "url": Node(url),
            "is_for_live_ticker": Node(isForLiveTicker),
            "is_active": Node(isActive),
            "created_at": Node(createdAt),
            "updated_at": Node(updatedAt)
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

extension Rss {
    func race() throws -> Parent<Race> {
        return try parent(raceId)
    }
}
