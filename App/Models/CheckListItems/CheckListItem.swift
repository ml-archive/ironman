import Vapor
import Fluent

final class CheckListItem: Model {
    
    static var entity = "check_list_items"
    
    var id: Node?
    var raceId: Node
    var type: String
    var title: String
    var position: Int
    var isActive: Bool
    
    var createdAt: String
    var updatedAt: String
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        raceId = try node.extract("race_id")
        title = try node.extract("title")
        type = try node.extract("type")
        position = try node.extract("position")
        
        isActive = try node.extract("is_active")
        createdAt = try node.extract("created_at")
        updatedAt = try node.extract("updated_at")
    }
    
    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "race_id": raceId,
            "title": Node(title),
            "type": Node(type),
            "position": Node(position),
            "is_active": Node(isActive),
            "created_at": Node(createdAt),
            "updated_at": Node(updatedAt)
        ])
    }
    
    func makeJSON() throws -> JSON {
        return try JSON(node: [
            "id": id,
            "title": title,
        ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("check_list_items") { checkListItem in
            checkListItem.id()
            checkListItem.int("race_id");
            checkListItem.string("title")
            checkListItem.string("type")
            checkListItem.int("position")
            checkListItem.bool("is_active")
            checkListItem.string("created_at", optional: true)
            checkListItem.string("updated_at", optional: true)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("check_list_items")
    }
}

extension CheckListItem {
    func race() throws -> Parent<Race> {
        return try parent(raceId)
    }
}
