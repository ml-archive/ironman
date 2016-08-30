import Vapor
import VaporMySQL
import Fluent

final class Race: Model {
    var id: Node?
    var name: String
    var start_at: String
    var is_active: Int
    
    init(name: String, startAt: String, isActive: Int) {
        self.name = name
        self.start_at = startAt
        self.is_active = isActive
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        start_at = try node.extract("start_at")
        is_active = try node.extract("is_active")
    }
    
    func makeNode() throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name,
            "start_at": start_at,
            "is_active": is_active
        ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("races") { races in
            races.id()
            races.string("name")
            races.string("start_at", optional: true)
            races.string("live_data_provider", optional: true)
            races.string("live_data_event_id", optional: true)
            races.string("live_stream_url", optional: true)
            races.string("youtube_channel", optional: true)
            races.bool("is_live_stream_enbled", optional: true)
            races.bool("is_live_stream_active", optional: true)
            races.bool("is_geo_tracking_enabled", optional: true)
            races.string("sponsor_image_path", optional: true)
            races.string("event_info_image_path", optional: true)
            races.data("event_text", optional: true)
            races.string("tourist_app_link_ios", optional: true)
            races.string("tourist_app_link_android", optional: true)
            races.string("fb_page", optional: true)
            races.string("hashtag", optional: true)
            races.bool("is_active", optional: true)
            races.string("created_at", optional: true)
            races.string("updated_at", optional: true)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("races")
    }
}
