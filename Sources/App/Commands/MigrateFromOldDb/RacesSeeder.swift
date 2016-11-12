import Console
import Fluent

public final class RacesSeeder: Command {
    public let id = "seeder:races"

    public let help: [String] = [
        "Seeds the database with races"
    ]

    public let console: ConsoleProtocol

    public init(console: ConsoleProtocol) {
        self.console = console
    }

    public func run(arguments: [String]) throws {
        
        console.info("Started the seeder for races");
        
        let races = [
            try Race(node: [
                "name": "Copenhagen",
                "btn_image_path": "",
                
                "start_at": "2016-08-21 07:00:00",
                "live_data_provider": "ultimate",
                "live_data_event_id": 3326,
                "live_stream_url": "",
                "youtube_channel": "UCCXPxwMkJUL3_HhHRdsVXRA",
          
                "is_live_stream_enabled": false,
                "is_live_stream_active": false,
                "is_geo_tracking_enabled": true,
                
                "sponsor_image_path": "",
                "event_info_image_path": "",
                "event_text": "KMD IRONMAN Copenhagen",
                "tourist_app_link_ios": "",
                "tourist_app_link_android": "",
                "fb_page": "IronmanCopenhagen",
                "hashtag": "#kmdironmancopenhagen",
                "is_active": true,
                "created_at": "2013-10-19 22:30:58",
                "updated_at": "2016-07-20 15:24:38"
            ]),
            try Race(node: [
                "name": "Aarhus",
                "btn_image_path": "",
                
                "start_at": "2016-09-10 13:00:00",
                "live_data_provider": "ultimate",
                "live_data_event_id": 2568,
                "live_stream_url": "",
                "youtube_channel": "UCCXPxwMkJUL3_HhHRdsVXRA",
                
                "is_live_stream_enabled": false,
                "is_live_stream_active": false,
                "is_geo_tracking_enabled": true,
                
                "sponsor_image_path": "",
                "event_info_image_path": "",
                "event_text": "Beautiful country side, spectacular city feel",
                "tourist_app_link_ios": "",
                "tourist_app_link_android": "https://play.google.com/store/apps/details?id=com.activewindow.visitaarhusoffline",
                "fb_page": "Ironman703Aarhus",
                "hashtag": "#IRONMAN16",
                "is_active": true,
                "created_at": "2013-10-19 22:30:58",
                "updated_at": "2016-07-20 15:24:38"
            ]),
            try Race(node: [
                "name": "Kronborg",
                "btn_image_path": "",
                
                "start_at": "2016-06-19 08:00:00",
                "live_data_provider": "ultimate",
                "live_data_event_id": 3325,
                "live_stream_url": "",
                "youtube_channel": "UCCXPxwMkJUL3_HhHRdsVXRA",
                
                "is_live_stream_enabled": false,
                "is_live_stream_active": false,
                "is_geo_tracking_enabled": true,
                
                "sponsor_image_path": "",
                "event_info_image_path": "",
                "event_text": "This is your chance to experience an amazing and unique IRONMAN 70.3 event in the beautiful surroundings of North Zealand's coastline",
                "tourist_app_link_ios": "",
                "tourist_app_link_android": "",
                "fb_page": "Ironman703Kronborg",
                "hashtag": "#kmdironmancopenhagen",
                "is_active": true,
                "created_at": "2013-10-19 22:30:58",
                "updated_at": "2016-07-20 15:24:38"
            ])
        ]
   
        try races.forEach({
            var race = $0
            console.info("Looping \(race.name)")
            do {
                try race.save()
            } catch {
                console.error("Failed to store \(race.name)")
                print(error)
            }
        })
 
        
        console.info("Finished the seeder for races");
    }
}
