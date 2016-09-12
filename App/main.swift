import Vapor
import VaporBackend
import VaporMySQL
import HTTP


/**
    Droplets are service containers that make accessing
    all of Vapor's features easy. Just call
    `drop.serve()` to serve your application
    or `drop.client()` to create a client for
    request data from other servers.
*/
let drop = Droplet(
    view: LeafRenderer(
        viewsDir: Droplet().workDir + "VaporBackend/Resources/Views"
    ),
    preparations: [
        Race.self,
        Rss.self,
        News.self,
        CheckListItem.self,
        TrafficItem.self,
        Poi.self
    ],
    providers: [
        VaporMySQL.Provider.self
    ]
)


// Registering commands
drop.commands.append(Seeder(console: drop.console))
drop.commands.append(RacesSeeder(console: drop.console))
drop.commands.append(RssSeeder(console: drop.console))
drop.commands.append(CheckListItemsSeeder(console: drop.console))
drop.commands.append(TrafficSeeder(console: drop.console))

drop.commands.append(NewsSyncer(drop: drop))


/**
    Vapor configuration files are located
    in the root directory of the project
    under `/Config`.

    `.json` files in subfolders of Config
    override other JSON files based on the
    current server environment.

    Read the docs to learn more
*/
let _ = drop.config["app", "key"]?.string ?? ""

/**
    Routes
*/
// API
drop.grouped("/api/races").collection(RacesRoutes.self)
drop.grouped("/api/news").collection(NewsRoutes.self)
drop.grouped("/api/races").collection(CheckListsRoutes.self)
drop.grouped("/api/races").collection(TrafficItemsRoutes.self)

// Backend
drop.grouped("/admin/dashboard").collection(VaporBackend.DashboardRoutes(droplet: drop))
drop.grouped("/admin/users").collection(VaporBackend.UsersRoutes(droplet: drop))


let port = drop.config["app", "port"]?.int ?? 80

// Print what link to visit for default port
drop.serve()
