import Vapor
import HTTP
import Routing

struct RacesRoutes: RouteCollection, EmptyInitializable {
    
    typealias Wrapped = Responder
    
    func build<Builder: RouteBuilder>(_ builder: Builder) where Builder.Value == Wrapped {
        
        let controller = RacesController(droplet: drop)
        
        builder.get("/", handler: controller.index);
        builder.get("/", Race.self, handler: controller.show);
    }
}
