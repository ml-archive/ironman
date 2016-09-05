import Vapor
import VaporBackend
//import VaporMySQL
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
        viewsDir:  Droplet.workingDirectory(from: CommandLine.arguments).finished(with: "/") + "VaporBackend/Resources/Views"
    )

)


// Registering commands
drop.commands.append(
    RacesSeeder(console: drop.console)
)

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

// Backend
drop.grouped("/admin/dashboard").collection(VaporBackend.DashboardRoutes(droplet: drop))
drop.grouped("/admin/users").collection(VaporBackend.UsersRoutes(droplet: drop))


let port = drop.config["app", "port"]?.int ?? 80

// Print what link to visit for default port
drop.serve()
