import Console

public final class RssSeeder: Command {
    public let id = "seeder:rss"
    
    public let help: [String] = [
        "Seeds the database with rss"
    ]
    
    public let console: ConsoleProtocol
    
    public init(console: ConsoleProtocol) {
        self.console = console
    }
    
    public func run(arguments: [String]) throws {
        
        console.info("Started the seeder for rss");
        /*
        let rss = [
            try Rss(node: [
                
                "name": "Copenhagen",
                "btn_image_path": nil,
                
                "start_at": "2016-08-21 07:00:00",
                "live_data_provider": "ultimate",
                "live_data_event_id": 3326,
                "live_stream_url": nil,
                "youtube_channel": "IRONMANCopenhagen",
                
                "is_live_stream_enabled": false,
                "is_live_stream_active": false,
                "is_geo_tracking_enabled": true,
                
                "sponsor_image_path": nil,
                "event_info_image_path": nil,
                "event_text": "KMD IRONMAN Copenhagen - “the most spectacular race course in the world”",
                "tourist_app_link_ios": nil,
                "tourist_app_link_android": nil,
                "fb_page": "IronmanCopenhagen",
                "hashtag": "#kmdironmancopenhagen",
                "is_active": true,
                "created_at": "2013-10-19 22:30:58",
                "updated_at": "2016-07-20 15:24:38"
                ]),
            ]
        
        rss.forEach({
            var rss = $0
            console.info("Looping \(rss.id)")
            do {
                try rss.save()
            } catch {
                console.error("Failed to store \(rss.name)")
                print(error)
            }
        })
        */
        
        console.info("Finished the seeder for rss");
    }
}
