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
        
        
        let rss = [
            try Rss(node: [
                "race_id": 1,
                "name": "Copenhagen",
                "url": "http://kmdironmancopenhagen.com/feed/",
                "is_for_live_ticker": false,
                "is_active": true,
                "created_at": "2013-10-19 22:30:58",
                "updated_at": "2016-07-20 15:24:38"
            ]),
            try Rss(node: [
                "race_id": 1,
                "name": "Politiken",
                "url": "http://politiken.dk/motion/triatlon/?service=rss2feed&timer=750&arttypes=default,rating,tjek_default,r_normal,r_debatarticle,images_graphics,gallery,guidefeature&imgversion=y",
                "is_for_live_ticker": false,
                "is_active": true,
                "created_at": "2013-10-19 22:30:58",
                "updated_at": "2016-07-20 15:24:38"
            ]),
            try Rss(node: [
                "race_id": 2,
                "name": "Ironman",
                "url": "http://kmdironman703aarhus.com/feed",
                "is_for_live_ticker": false,
                "is_active": true,
                "created_at": "2013-10-19 22:30:58",
                "updated_at": "2016-07-20 15:24:38"
            ]),
            try Rss(node: [
                "race_id": 3,
                "name": "Ironman",
                "url": "http://kmdironman703kronborg.com/feed",
                "is_for_live_ticker": false,
                "is_active": true,
                "created_at": "2013-10-19 22:30:58",
                "updated_at": "2016-07-20 15:24:38"
            ]),
        ]
        
        rss.forEach({
            var rss = $0
            console.info("Looping \(rss.url)")
            do {
                try rss.save()
            } catch {
                console.error("Failed to store \(rss.name)")
                print(error)
            }
        })
 
        
        console.info("Finished the seeder for rss");
    }
}
