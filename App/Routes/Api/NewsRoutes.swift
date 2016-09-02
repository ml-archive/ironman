import Vapor
import HTTP
import Routing

struct NewsRoutes: RouteCollection, EmptyInitializable {
    
    typealias Wrapped = Responder
    
    func build<Builder: RouteBuilder>(_ builder: Builder) where Builder.Value == Wrapped {
        
        let controller = NewsController(droplet: drop)
        
        builder.get("/", handler: controller.index);
        builder.get("/", News.self, handler: controller.show);
    }
}
