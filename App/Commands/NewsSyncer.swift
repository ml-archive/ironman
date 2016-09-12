import Console
import Fluent
import Vapor

public final class NewsSyncer: Command {
    public let id = "sync:news"
    
    public let help: [String] = [
        "Sync news"
    ]
    
    public let console: ConsoleProtocol
    let drop: Droplet
    
    public init(drop: Droplet) {
        self.console = drop.console
        self.drop = drop
    }
    
    public func run(arguments: [String]) throws {
        
        console.info("Started news syncer")
        
        let races = try Race.query().all()
        console.info("Found \(races.count) races... now loop them")
        
        races.forEach({
            let race = $0
            
            console.info("Looping race: \(race.id!.int)")
            // FB
            do {
                try syncFb(race: race)
            } catch {
                console.error("Failed to sync facebook for \(race.id!.int)")
            }
            
            // Rss
            do {
                try race.rss().all().forEach({
                    let rss = $0
                    do {
                        try syncRss(rss: rss)
                    } catch {
                        print(error)
                        console.error("Failed to sync rss \(rss.url)")
                    }
                })
            } catch {
                console.error("Failed to rss for \(race.id)")
            }
        })
        
        console.info("Finished news syncer");
    }
    
    private func syncRss(rss: Rss) throws {
        console.info("Started rss sync \(rss.url)")
        let rssNews = try RssRetriever(drop: drop).retrieve(rss: rss)
        
        rssNews.forEach({
            var rssItem = $0
            guard let externalId = rssItem.externalId?.string else {
                print("no externalId")
                return;
            }
            
            do {
                let existingItem = try News.query()
                    .filter("external_id", .equals, externalId)
                    .filter("type", .equals, "rss")
                    .filter("race_id", .equals, rss.raceId)
                    .first()
                
                
                if let existingItemUnwrapped: News = existingItem {
                    try existingItemUnwrapped.update(news: rssItem)
                }else {
                    try rssItem.save()
                }
                
            } catch {
                console.error("Failed to store \(externalId)")
            }
            
        })
        
        console.info("Finished Fb sync")
    }
    
    private func syncFb(race: Race) throws {
        console.info("Started Fb sync \(race.fbPage)")
        let fbNews = try FacebookPostsRetriever(drop: drop).retrieve(race: race)
        fbNews.forEach({
            var fbNewsItem = $0
            
            guard let externalId = fbNewsItem.externalId?.string else {
                return;
            }
            
            do {
                let existingItem = try News.query()
                    .filter("external_id", .equals, externalId)
                    .filter("type", .equals, "facebook")
                    .filter("race_id", .equals, 1)
                    .first()
                
                
                if let existingItemUnwrapped: News = existingItem {
                    try existingItemUnwrapped.update(news: fbNewsItem)
                }else {
                    try fbNewsItem.save()
                }
                
            } catch {
                console.error("Failed to store \(externalId) \(error)")
            }
            
        })
        
        console.info("Finished Fb sync")
    }
}
