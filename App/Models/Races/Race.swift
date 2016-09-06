import Vapor
import Fluent

final class Race: Model {
    var id: Node?
    var name: String
    var btnImagePath: String

    var startAt: String
    var liveDataProvider: String
    var liveDataEventId: String
    var liveStreamUrl: String
    var youtubeChannel: String

    var isLiveStreamEnabled: Bool
    var isLiveStreamActive: Bool
    var isGeoTrackingEnabled: Bool

    var sponsorImagePath: String
    var eventInfoImagePath: String
    var eventText: String

    var touriestAppLinkIos: String
    var touriestAppLinkAndroid: String
    var fbPage: String
    var hashtag: String

    var isActive: Bool
    var createdAt: String
    var updatedAt: String


    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        isActive = try node.extract("is_active")

        btnImagePath = try node.extract("btn_image_path")

        startAt = try node.extract("start_at")
        liveDataProvider = try node.extract("live_data_provider")
        liveDataEventId = try node.extract("live_data_event_id")
        liveStreamUrl = try node.extract("live_stream_url")
        youtubeChannel = try node.extract("youtube_channel")

        isLiveStreamEnabled = try node.extract("is_live_stream_enabled")
        isLiveStreamActive = try node.extract("is_live_stream_active")
        isGeoTrackingEnabled = try node.extract("is_geo_tracking_enabled")

        sponsorImagePath = try node.extract("sponsor_image_path")
        eventInfoImagePath = try node.extract("event_info_image_path")
        eventText = try node.extract("event_text")

        touriestAppLinkIos = try node.extract("tourist_app_link_ios")
        touriestAppLinkAndroid = try node.extract("tourist_app_link_android")
        fbPage = try node.extract("fb_page")
        hashtag = try node.extract("hashtag")

        createdAt = try node.extract("created_at")
        updatedAt = try node.extract("updated_at")
    }

    func makeNode() throws -> Node {
        return try Node(node: [
            "id":  id,
            "name": Node(name),
            
            "btn_image_path": Node(btnImagePath),
            "sponsor_image_path": sponsorImagePath,
            "event_info_image_path" : Node(eventInfoImagePath),
            
            "event_text": Node(eventText),
            "start_at": Node(startAt),
            "live_data_provider": Node(liveDataProvider),
            "live_data_event_id": Node(liveDataEventId),
            "is_geo_tracking_enabled": Node(isGeoTrackingEnabled),
            "is_live_stream_enabled": Node(isLiveStreamEnabled),
            "is_live_stream_active": Node(isLiveStreamActive),
            
            "hashtag": Node(hashtag),
            "live_stream_url": Node(liveStreamUrl),
            "youtube_channel": Node(youtubeChannel),
            
            "tourist_app_link_ios": Node(touriestAppLinkIos),
            "tourist_app_link_android": Node(touriestAppLinkAndroid)
        ])
    }


    func makeJSON() throws -> JSON {
        return try JSON(node: [
            "id":  id,
            "name": Node(name),
            
            "btnImageUrl": Node(btnImagePath),
            "sponsorImageUrl": Node(sponsorImagePath),
            "eventInfoImageUrl" : Node(eventInfoImagePath),
            
            "eventText": Node(eventText),
            "startDatetime": Node(startAt),
            "liveDataProvider": Node(liveDataProvider),
            "liveDataProviderEventId": Node(liveDataEventId),
            "isGeoTrackingEnabled": Node(isGeoTrackingEnabled),
            "isLiveStreamEnabled": Node(isLiveStreamEnabled),
            "isLiveStreamActive": Node(isLiveStreamActive),
            
            "hashTag": Node(hashtag),
            "liveStreamUrl": Node(liveStreamUrl),
            "youtubeChannel": Node(youtubeChannel),
            
            "touristAppLinkIos": Node(touriestAppLinkIos),
            "touristAppLinkAndroid": Node(touriestAppLinkAndroid)
        ])
    }

    static func prepare(_ database: Database) throws {
        try database.create("races") { races in
            races.id()

            races.string("name")
            races.string("btn_image_path", optional: true)

            races.string("start_at", optional: true)
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

extension Race {
    func rss() throws -> Children<Rss> {
        return children()
    }
}
