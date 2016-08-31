import Vapor
import HTTP
import Routing

struct DashboardRoutes: RouteCollection, EmptyInitializable {
    
    typealias Wrapped = Responder
    
    func build<Builder: RouteBuilder>(_ builder: Builder) where Builder.Value == Wrapped {
        
        let controller = DashboardController(droplet: drop)
        
        builder.get("/", handler: controller.index);
    }
}
