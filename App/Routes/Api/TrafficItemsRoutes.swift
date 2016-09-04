import Vapor
import HTTP
import Routing

struct TrafficItemsRoutes: RouteCollection, EmptyInitializable {
    
    typealias Wrapped = Responder
    
    func build<Builder: RouteBuilder>(_ builder: Builder) where Builder.Value == Wrapped {
        
        let controller = TrafficItemsController(droplet: drop)
        
        builder.get(":raceId", "/traffic", handler: controller.index);
    }
}
