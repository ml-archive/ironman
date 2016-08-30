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
        let races = [
            Race(
                name: "Copenhagen",
                startAt: "2016-08-20",
                isActive: 1
            ),
            Race(
                name: "Aarhus",
                startAt: "2016-08-20",
                isActive: 1
            ),
            Race(
                name: "Kronborg",
                startAt: "2016-08-20",
                isActive: 1
            )
        ]
        
        try races.forEach({
            var race = $0
            try race.save()
        })
    }
}
