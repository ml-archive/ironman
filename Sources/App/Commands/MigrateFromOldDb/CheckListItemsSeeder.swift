import Console
import MySQL

public final class CheckListItemsSeeder: Command {
    public let id = "seeder:checklist"

    public let help: [String] = [
            "Seeds the database with checlist items"
    ]

    public let console: ConsoleProtocol

    public init(console: ConsoleProtocol) {
        self.console = console
    }

    public func run(arguments: [String]) throws {

        console.info("Started the seeder for checklists");
        
        let mysql = try MySQL.Database(
            host: "127.0.0.1",
            user: "root",
            password: "secret",
            database: "ironman-old"
        )
        
        let result = try mysql.execute("SELECT * FROM checklist_items")
        
        try result.forEach({
            let item = $0;
            
            let raceId = try MigrateHelper.oldRaceIdToNew(oldRaceId: item["race_id"]?.int ?? 0)
            
            let title = item["title"]?.string ?? "";
            let type = item["type"]?.string ?? "registration"
            let position = item["position"]?.int ?? 0
            let isActive = item["is_active"]?.bool ?? false
            let updatedAt = item["modified"]?.string ?? "1970-01-01 00:00:00"
            let createdAt = item["created_at"]?.string ?? "1970-01-01 00:00:00"
            
            do {
                var checkListItem: CheckListItem = try CheckListItem(node: Node([
                    "race_id": Node(raceId),
                    "title": Node(title),
                    "type": Node(type),
                    "position": Node(position),
                    "is_active": Node(isActive),
                    "updated_at": Node(updatedAt),
                    "created_at": Node(createdAt)
                ]))
                    
                try checkListItem.save()
            } catch
            {
                drop.console.error("Could not save checklist")
            }
        })
        

        console.info("Finished the seeder for checklists");
    }
}
