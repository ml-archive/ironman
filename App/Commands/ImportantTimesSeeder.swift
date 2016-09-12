import Console
import MySQL
import Vapor

public final class ImportantTimesSeeder: Command {
    public let id = "seeder:important-time"
    
    public let help: [String] = [
        "Seeds the database with important time"
    ]
    
    public let console: ConsoleProtocol
    
    public init(console: ConsoleProtocol) {
        self.console = console
    }
    
    public func run(arguments: [String]) throws {
        
        console.info("Started the seeder for important-time");
        
        
        let mysql = try MySQL.Database(
            host: "127.0.0.1",
            user: "root",
            password: "secret",
            database: "ironman-old"
        )
        
        let result = try mysql.execute("SELECT * FROM important_times")
        
        try result.forEach({
            let item = $0;
            
            let raceId = try MigrateHelper.oldRaceIdToNew(oldRaceId: item["race_id"]?.int ?? 0)
            
            do {
                let date = item["date"]?.string ?? ""
                let timeStart = item["time_start"]?.string ?? ""
                let timeStop = item["time_stop"]?.string ?? ""
                
                let title = item["title"]?.string ?? ""
                let description = item["description"]?.string ?? ""
                
                let poiId = item["poi_id"]?.int ?? -1
                let showOnMap = item["show_on_map"]?.bool ?? false
                
                let isActive = item["is_active"]?.bool ?? false
                let updatedAt = item["modified"]?.string ?? "1970-01-01 00:00:00"
                let createdAt = item["created"]?.string ?? "1970-01-01 00:00:00"

                var importantTime: ImportantTime = try ImportantTime(node: [
                    "race_id": raceId,
                    
                    "date": Node(date),
                    "time_start": Node(timeStart),
                    "time_stop": Node(timeStop),
                    
                    "title": Node(title),
                    "description": Node(description),
                    
                    "poi_id": Node(poiId),
                    "show_on_map": Node(showOnMap),
                    
                    "is_active": Node(isActive),
                    "updated_at": Node(updatedAt),
                    "created_at": Node(createdAt)
                ])
                try importantTime.save()
            } catch
            {
                drop.console.error("Could not save important time: \(error)")
            }
        })
        
        
        console.info("Finished the seeder for important time");
    }
}
