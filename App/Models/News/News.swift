import Vapor
import Fluent
import Foundation

final class News: Model {
    
    static var entity = "news"
    
    var id: Node?
    var raceId: Node
    var externalId: String?
    var title: String?
    var description: String?
    var url: String?
    var imagePath: String?
    var type: String
    var isPushSent: Bool
    
    var isActive: Bool
    var createdAt: String
    var updatedAt: String

    
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
    
    init(node: Node, raceId: Node) throws {
        self.raceId = raceId
        externalId = try? node.extract("id")
        
        let message: String? = try? node.extract("message") ?? node.extract("story")
        guard let m = message else {
            throw Abort.badRequest
        }
        title = m.substring(to: m.index(m.startIndex, offsetBy: m.characters.count >= 40 ? 40 : m.characters.count)).utf8.string
        description = message?.utf8.string
        
        url = ""
        type = "facebook"
        
        isPushSent = false  
        isActive = true;
        createdAt = ""
        updatedAt = ""
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
    
    func update(news : News) throws {
        self.description = news.description
        self.title = news.title
        
        
        var copy = self;
        try copy.save()
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


 extension News {
    func race() throws -> Parent<Race> {
        return try parent(raceId)
    }
 }
 
