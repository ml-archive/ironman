import Console
import Fluent

public final class Seeder: Command {
    public let id = "seeder"
    
    public let help: [String] = [
        "Seeds the database"
    ]
    
    public let console: ConsoleProtocol
    
    public init(console: ConsoleProtocol) {
        self.console = console
    }
    
    public func run(arguments: [String]) throws {
        
        console.info("Started the seeder");
        
        try RacesSeeder(console: console).run(arguments: [])
        try RssSeeder(console: console).run(arguments: [])
        try CheckListItemsSeeder(console: console).run(arguments: [])
        try TrafficSeeder(console: console).run(arguments: [])
        try PoiSeeder(console: console).run(arguments: [])
        try ImportantTimesSeeder(console: console).run(arguments: [])
        try ImportantTimesSeeder(console: console).run(arguments: [])

        console.info("Finished the seeder");
    }
}
