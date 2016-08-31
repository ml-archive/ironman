import Vapor
import Fluent

final class Race: Model {
    var id: Node?
    var name: String
    var startAt: String
    var isActive: Bool
    var liveDataProvider: String
    var liveDataEventId: String?
    var liveStreamUrl: String?
    
    init(name: String, startAt: String, isActive: Bool, liveDataProvider: String, liveDataEventId: String?, liveStreamUrl: String?) {
        self.name = name
        self.startAt = startAt
        self.isActive = isActive
        self.liveDataProvider = liveDataProvider
        self.liveDataEventId = liveDataEventId
        self.liveStreamUrl = liveStreamUrl
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        startAt = try node.extract("start_at")
        isActive = try node.extract("is_active")
        liveDataProvider = try node.extract("live_data_provider")
        liveDataEventId = try? node.extract("live_data_event_id")
        liveStreamUrl = try? node.extract("live_stream_url")
    }
    
    func makeNode() throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name,
            "start_at": startAt,
            "is_active": isActive,
            "live_data_provider" : liveDataProvider,
            "live_data_event_id" : liveDataEventId,
            "live_stream_url" : liveStreamUrl
        ])
    }
    
    
    func makeJSON() throws -> JSON {
        let data = try Node(node: [
            "id": id,
            "name": name,
            "startAt": startAt,
            "isActive": isActive,
            "liveDataProvider": liveDataProvider,
            "liveDataEventId": liveDataEventId,
            "liveStreamUrl": liveStreamUrl
        ])
        return try JSON(node: data)
    }
    
    
    static func prepare(_ database: Database) throws {
        try database.create("races") { races in
            races.id()
            races.string("name")
            races.string("start_at")
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
