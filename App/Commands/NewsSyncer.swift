import Console
import Fluent

public final class NewsSyncer: Command {
    public let id = "sync:news"
    
    public let help: [String] = [
        "Sync news"
    ]
    
    public let console: ConsoleProtocol
    
    public init(console: ConsoleProtocol) {
        self.console = console
    }
    
    public func run(arguments: [String]) throws {
        
        console.info("Started news syncer")
        
        try FacebookPosts().retrieve(fbPage: "IronmanCopenhagen")
        
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
