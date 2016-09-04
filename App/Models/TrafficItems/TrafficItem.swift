import Vapor
import Fluent

final class TrafficItem: Model {
    
    static var entity = "traffic_items"
    
    var id: Node?
    var raceId: Node

    var title: String
    var url: String
    var isActive: Bool
    
    var createdAt: String
    var updatedAt: String
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        raceId = try node.extract("race_id")
        title = try node.extract("title")
        url = try node.extract("url")
        
        isActive = try node.extract("is_active")
        createdAt = try node.extract("created_at")
        updatedAt = try node.extract("updated_at")
    }
    
    func makeNode() throws -> Node {
        return try Node(node: [
            "id": id,
            "race_id": raceId,
            "title": title,
            "url": url,
            "is_active": isActive,
            "created_at": createdAt,
            "updated_at": updatedAt
        ])
    }
    
    func makeJSON() throws -> JSON {
        return try JSON(node: [
            "id": id,
            "title": title,
            "url": url
        ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("traffic_items") { checkListItem in
            checkListItem.id()
            checkListItem.int("race_id");
            checkListItem.string("title")
            checkListItem.string("url")
            checkListItem.bool("is_active")
            checkListItem.string("created_at", optional: true)
            checkListItem.string("updated_at", optional: true)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("traffic_items")
    }
}

extension TrafficItem {
    func race() throws -> Parent<Race> {
        return try parent(raceId)
    }
}
