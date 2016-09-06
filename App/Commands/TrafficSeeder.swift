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
        
        /*
        let mysql = try MySQL.Database(
            host: "127.0.0.1",
            user: "root",
            password: "secret",
            database: "ironman-old"
        )
        
        let result = try mysql.execute("SELECT * FROM trafic_items")
        */
        let result = [["read_more_url": Node.string("http://kmdironmancopenhagen.com/trafik/"), "modified": Node.string("2015-08-17 22:33:44"), "id": Node.number(3), "created": Node.string("2014-06-02 11:06:37"), "is_active": Node.number(1), "race_id": Node.number(26), "title": Node.string("Traffic information")], ["read_more_url": Node.string("http://kmdironmancopenhagen.com/trafik-strandvejen-gennem-hellerup/"), "modified": Node.string("2014-08-11 22:32:11"), "id": Node.number(6), "created": Node.string("2014-06-02 11:06:57"), "is_active": Node.number(0), "race_id": Node.number(26), "title": Node.string("Strandvejen i Hellerup")], ["read_more_url": Node.string("http://kmdironman703aarhus.com/trafik/"), "modified": Node.string("2014-06-15 15:24:22"), "id": Node.number(8), "created": Node.string("2014-06-15 15:24:22"), "is_active": Node.number(1), "race_id": Node.number(31), "title": Node.string("Traffic information")], ["read_more_url": Node.string("http://kmdironman703kronborg.com/da/trafik-information/"), "modified": Node.string("2014-09-13 09:00:12"), "id": Node.number(10), "created": Node.string("2014-09-13 09:00:12"), "is_active": Node.number(1), "race_id": Node.number(33), "title": Node.string("Trafik")]]
        
        try result.forEach({
            let item = $0;
            
            let raceId = try MigrateHelper.oldRaceIdToNew(oldRaceId: item["race_id"]?.int ?? 0)
            
            do {
                let node: [String: Node] = [
                    "race_id": Node(raceId),
                    "title": Node(item["title"]?.string ?? ""),
                    "url": Node(item["read_more_url"]?.string ?? ""),
                    "is_active": Node(item["is_active"]?.bool ?? false),
                    "updated_at": Node("1970-01-01 00:00:00"), // item["modified"]?.string ??
                    "created_at": Node("1970-01-01 00:00:00") // item["created"]?.string ??
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
