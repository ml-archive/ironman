import Console
import MySQL
import Vapor

public final class TrafficSeeder: Command {
    public let id = "seeder:traffic"
    
    public let help: [String] = [
        "Seeds the database with traffic"
    ]
    
    public let console: ConsoleProtocol
    
    public init(console: ConsoleProtocol) {
        self.console = console
    }
    
    public func run(arguments: [String]) throws {
        
        console.info("Started the seeder for traffic");
        
    
        let mysql = try MySQL.Database(
            host: "127.0.0.1",
            user: "root",
            password: "secret",
            database: "ironman-old"
        )
        
        let result = try mysql.execute("SELECT * FROM trafic_items")
    
        try result.forEach({
            let item = $0;
            
            let raceId = try MigrateHelper.oldRaceIdToNew(oldRaceId: item["race_id"]?.int ?? 0)
            
            do {
                let title = item["title"]?.string ?? ""
                let url = item["read_more_url"]?.string ?? "";
                let isActive = item["is_active"]?.bool ?? false
                let updatedAt = item["modified"]?.string ?? "1970-01-01 00:00:00"
                let createdAt = item["created"]?.string ?? "1970-01-01 00:00:00"
                
                let node: [String: Node] = [
                    "race_id": Node(raceId),
                    "title": Node(title),
                    "url": Node(url),
                    "is_active": Node(isActive),
                    "updated_at": Node(updatedAt),
                    "created_at": Node(createdAt) 
                ]
                
                var trafficItem: TrafficItem = try TrafficItem(node: node)
                try trafficItem.save()
            } catch
            {
                drop.console.error("Could not save traffic entry")
            }
        })
        
        
        console.info("Finished the seeder for traffic");
    }
}
