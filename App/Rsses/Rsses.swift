import Vapor
import Fluent

final class Race: Model {
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
            "btn_image_path": btnImagePath,
            
            "start_at": startAt,
            "live_data_provider": liveDataProvider,
            "live_data_event_id": liveDataEventId,
            "live_stream_url": liveStreamUrl,
            "youtube_channel": youtubeChannel,
            
            "is_live_stream_enabled": isLiveStreamEnabled,
            "is_live_stream_active": isLiveStreamActive,
            "is_geo_tracking_enabled": isGeoTrackingEnabled,
            
            "sponsor_image_path": sponsorImagePath,
            "event_info_image_path": eventInfoImagePath,
            "event_text": eventText,
            "tourist_app_link_ios": touriestAppLinkIos,
            "tourist_app_link_android": touriestAppLinkAndroid,
            "fb_page": fbPage,
            "hashtag": hashtag,
            "is_active": isActive,
            "created_at": createdAt,
            "updated_at": updatedAt
        ])
    }
    
    
    static func prepare(_ database: Database) throws {
        try database.create("rss") { rsses in
            rsses.id()
            rsses.integer("race_id");
            races.string("name")
            races.string("url")
            
            races.bool("is_active")
            races.bool("is_for_live_ticker")
        
            races.string("created_at", optional: true)
            races.string("updated_at", optional: true)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("rsses")
    }
}
