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
        
        
        
        let fbNews = try FacebookPosts(drop: drop).retrieve(fbPage: "IronmanCopenhagen", raceId: 1)
        fbNews.forEach({
            var fbNewsItem = $0
           
             guard let externalId = fbNewsItem.externalId?.string else {
                return;
            }
            
            do {
                // Check if the item exist
                
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
                console.error("Failed to store \(fbNewsItem.externalId)")
                print(error)
            }
 
        })
        
        /*
        let activeRaces = try Race.query().filter("is_active", .equals, 1).all()
        
        console.info("Found \(activeRaces.count)")
        
        activeRaces.forEach({
            let race = $0
            console.info("Looping \(race.id)")
            do {
                try FacebookPosts().retrieve(race: race)
            } catch {
                console.error("Failed to sync facebook for \(race.id)")
                print(error)
            }
            
            
        })*/
        
        console.info("Finished news syncer");
    }
}
