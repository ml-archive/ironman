import Vapor
import Fluent

final class Race: Model {
    var id: Node?
    var name: String
    var btnImagePath: String?
    
    var startAt: String
    var liveDataProvider: String
    var liveDataEventId: String?
    var liveStreamUrl: String?
    var youtubeChannel: String?
    
    var isLiveStreamEnabled: Bool
    var isLiveStreamActive: Bool
    var isGeoTrackingEnabled: Bool
    
    var sponsorImagePath: String?
    var eventInfoImagePath: String?
    var eventText: String?
    
    var touriestAppLinkIos: String?
    var touriestAppLinkAndroid: String?
    var fbPage: String?
    var hashtag: String?
    
    var isActive: Bool
    var createdAt: String
    var updatedAt: String
 
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        btnImagePath = try? node.extract("btb_image_path");

        startAt = try node.extract("start_at")
        liveDataProvider = try node.extract("live_data_provider")
        liveDataEventId = try? node.extract("live_data_event_id")
        liveStreamUrl = try? node.extract("live_stream_url")
        youtubeChannel = try? node.extract("youtube_channel")
        
        isLiveStreamEnabled = try node.extract("is_live_stream_enabled")
        isLiveStreamActive = try node.extract("is_live_stream_active")
        isGeoTrackingEnabled = try node.extract("is_geo_tracking_enabled")
        
        sponsorImagePath = try? node.extract("sponsor_image_path")
        eventInfoImagePath = try? node.extract("event_info_image_path")
        eventText = try? node.extract("event_text")
        
        touriestAppLinkIos = try? node.extract("tourist_app_link_ios")
        touriestAppLinkAndroid = try? node.extract("tourist_app_link_android")
        fbPage = try? node.extract("fb_page")
        hashtag = try? node.extract("hashtag")
        
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
    
    
    func makeJSON() throws -> JSON {
        let data = try Node(node: [
            "id": id,
            "name": name,
            "btn_image_url": nil,
            "sponsor_image_url": nil,
            "event_info_image_url" : nil,
            "event_text": eventText,
            "start_datetime": startAt,
            "live_data_provider": liveDataProvider,
            "live_data_provider_event_id": liveDataEventId,
            "is_geo_tracking_enabled": isGeoTrackingEnabled,
            "is_live_stream_enabled": isLiveStreamEnabled,
            "is_live_stream_active": isLiveStreamActive,
            "hash_tag": hashtag,
            "live_stream_url": liveStreamUrl,
            "youtube_channel": youtubeChannel,
            "tourist_app_link_ios": touriestAppLinkIos,
            "tourist_app_link_android": touriestAppLinkAndroid,
            
        ])
        return try JSON(node: data)
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("races") { races in
            races.id()
            races.string("name")
            races.string("btn_image_path", optional: true)
            
            races.string("start_at")
            races.string("live_data_provider", optional: true)
            races.string("live_data_event_id", optional: true)
            races.string("live_stream_url", optional: true)
            races.string("youtube_channel", optional: true)
            
            races.bool("is_live_stream_enabled", optional: true)
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
