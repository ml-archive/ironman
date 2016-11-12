import Vapor
import HTTP
import Routing

struct ImporantTimesRoutes: RouteCollection, EmptyInitializable {
    
    typealias Wrapped = Responder
    
    func build<Builder: RouteBuilder>(_ builder: Builder) where Builder.Value == Wrapped {
        
        let controller = ImportantTimesController(droplet: drop)
        
        builder.get(":raceId", "/important-times", handler: controller.index);
    }
}
