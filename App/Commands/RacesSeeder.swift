import Vapor
import Console

public final class RacesSeeder: Command {
    public let id = "seeder:races"

    public let help: [String] = [
        "Seeds the database with races"
    ]

    public let console: ConsoleProtocol

    public init(console: ConsoleProtocol) {
        self.console = console
    }

    public func run(arguments: [String]) throws {
        
        console.info("Started the seeder for races");
        
        let races = [
            Race(
                name: "Copenhagen",
                startAt: "2016-08-21 07:00:00",
                isActive: 1
            ),
            Race(
                name: "Aarhus",
                startAt: "2016-08-21 07:00:00",
                isActive: 1
            ),
            Race(
                name: "Kronborg",
                startAt: "2016-08-21 07:00:00",
                isActive: 1
            )
        ]
        
        races.forEach({
            var race = $0
            do {
                try race.save()
            } catch {
                console.error("Failed to store \(race.name)")
            }
        })
        
        console.info("Finished the seeder for races");
    }
}
