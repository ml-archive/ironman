import Console
import MySQL

public final class PoiSeeder: Command {
    public let id = "seeder:poi"
    
    public let help: [String] = [
        "Seeds the database with pois"
    ]
    
    public let console: ConsoleProtocol
    
    public init(console: ConsoleProtocol) {
        self.console = console
    }
    
    public func run(arguments: [String]) throws {
        
        console.info("Started the seeder for pois");
        
        let mysql = try MySQL.Database(
            host: "127.0.0.1",
            user: "root",
            password: "secret",
            database: "ironman-old"
        )
        
        let result = try mysql.execute("SELECT * FROM pois")
        
        try result.forEach({
            let item = $0;
            
            let raceId = try MigrateHelper.oldRaceIdToNew(oldRaceId: item["race_id"]?.int ?? 0)
            
            let name = item["name"]?.string ?? "";
            let type = item["type"]?.string ?? "start"
            let showOn = item["show_on"]?.string ?? "all"
            let lat = item["lat"]?.double ?? 0
            let lng = item["lng"]?.double ?? 0
            let description = item["description"]?.string ?? ""
            
            let isActive = item["is_active"]?.bool ?? false
            let updatedAt = item["modified"]?.string ?? "1970-01-01 00:00:00"
            let createdAt = item["created"]?.string ?? "1970-01-01 00:00:00"
            
            do {
                var poi: Poi = try Poi(node: Node([
                    "race_id": Node(raceId),
                    "title": Node(name),
                    "description": Node(description),
                    "type": Node(type),
                    "show_on": Node(showOn),
                    "lat": Node(lat),
                    "lng": Node(lng),
                    "is_active": Node(isActive),
                    "updated_at": Node(updatedAt),
                    "created_at": Node(createdAt)
                ]))
                
                try poi.save()
            } catch
            {
                drop.console.error("Could not save pois entry: \(error)")
            }
        })
        
        
        console.info("Finished the seeder for pois");
    }
}
