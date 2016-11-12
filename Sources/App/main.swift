import Vapor
import VaporMySQL

let drop = Droplet()

try drop.addProvider(VaporMySQL.Provider.self)

// Move these somewhere else later
drop.preparations.append(Race.self)
drop.preparations.append(Rss.self)
drop.preparations.append(News.self)
drop.preparations.append(CheckListItem.self)
drop.preparations.append(TrafficItem.self)
drop.preparations.append(Poi.self)
drop.preparations.append(ImportantTime.self)

// Registering commands
drop.commands.append(Seeder(console: drop.console))
drop.commands.append(RacesSeeder(console: drop.console))
drop.commands.append(RssSeeder(console: drop.console))
drop.commands.append(CheckListItemsSeeder(console: drop.console))
drop.commands.append(TrafficSeeder(console: drop.console))
drop.commands.append(PoiSeeder(console: drop.console))
drop.commands.append(ImportantTimesSeeder(console: drop.console))
drop.commands.append(NewsSyncer(drop: drop))

// Register routes
drop.grouped("/api/races").collection(RacesRoutes.self)
//drop.grouped("/api/news").collection(NewsRoutes.self)
//drop.grouped("/api/races").collection(CheckListsRoutes.self)
//drop.grouped("/api/races").collection(TrafficItemsRoutes.self)
//drop.grouped("/api/races").collection(PoisRoutes.self)
//drop.grouped("/api/races").collection(ImporantTimesRoutes.self)

drop.get("admin/seed") { req in
    do {
        try Seeder(console: drop.console).run(arguments: [])
    } catch {
        print(error);
    }

    return "Seeded"
}

drop.get("admin/news") { req in
    do {
        try NewsSyncer(drop: drop).run(arguments: [])
    } catch {
        print(error);
    }


    return "News"
}



drop.run()
