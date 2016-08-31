import Vapor
import Fluent

final class Race: Model {
    var id: Node?
    var name: String
    var btnImagePath: String?
    
    
    var startAt: String
    var isActive: Bool
    var liveDataProvider: String
    var liveDataEventId: String?
    var liveStreamUrl: String?
    
    
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
            "btn_image_url": nil,
            "sponsor_image_url": nil,
            "event_info_image_url" : nil,
            "event_text": nil,
            "start_datetime": startAt,
            "live_data_provider": liveDataProvider,
            "live_data_provider_event_id": liveDataEventId,
            "is_geo_tracking_enabled": false,
            "is_live_stream_enabled": false,
            "is_live_stream_active": false,
            "hash_tag":nil,
            "live_stream_url": liveStreamUrl,
            "youtube_channel": nil,
            "tourist_app_link_ios": nil,
            "tourist_app_link_android": nil,
            
        ])
        return try JSON(node: data)
    }
    
    
    static func prepare(_ database: Database) throws {
        try database.create("races") { races in
            races.id()
            races.string("name")
            races.string("btn_image_id", optional: true)
            
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
