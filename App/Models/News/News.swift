import Vapor
import Fluent

final class News: Model {
    
    static var entity = "news"
    
    var id: Node?
    var raceId: Int
    var externalId: String?
    var title: String
    var description: String
    var url: String?
    var imagePath: String?
    var type: String
    var isPushSent: Bool
    
    var isActive: Bool
    var createdAt: String
    var updatedAt: String
    
    /*
     extension Rss {
     func race() throws -> Parent<Race> {
     return try parent(raceId)
     }
     }
     */
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        raceId = try node.extract("race_id")
        externalId = try? node.extract("external_id")
        title = try node.extract("title")
        description = try node.extract("description")
        url = try? node.extract("url")
        type = try node.extract("type")
        
        isPushSent = try node.extract("is_push_sent")
        isActive = try node.extract("is_active")
        createdAt = try node.extract("created_at")
        updatedAt = try node.extract("updated_at")
    }
    
    func makeNode() throws -> Node {
        return try Node(node: [
            "id": id,
            "race_id": raceId,
            "external_id": externalId,
            "title": title,
            "description": description,
            "url": url,
            "type": type,
            "is_push_sent": isPushSent,
            "is_active": isActive,
            "created_at": createdAt,
            "updated_at": updatedAt
        ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("news") { news in
            news.id()
            news.int("race_id");
            news.string("external_id", optional: true)
            news.string("title")
            news.string("description")
            news.string("url", optional: true)
            news.string("type")
            news.bool("is_push_sent")
            news.bool("is_active")
            news.string("created_at", optional: true)
            news.string("updated_at", optional: true)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("news")
    }
}
