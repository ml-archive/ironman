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
                isActive: true,
                liveDataProvider: "ultimate",
                liveDataEventId: "1",
                liveStreamUrl: nil
            ),
            Race(
                name: "Aarhus",
                startAt: "2016-09-10 13:00:00",
                isActive: true,
                liveDataProvider: "ultimate",
                liveDataEventId: "1",
                liveStreamUrl: nil
            ),
            Race(
                name: "Kronborg",
                startAt: "2016-06-19 08:00:00",
                isActive: true,
                liveDataProvider: "ultimate",
                liveDataEventId: "1",
                liveStreamUrl: nil
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
