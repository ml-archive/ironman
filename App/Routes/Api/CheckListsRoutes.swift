import Vapor
import HTTP
import Routing

struct CheckListsRoutes: RouteCollection, EmptyInitializable {
    
    typealias Wrapped = Responder
    
    func build<Builder: RouteBuilder>(_ builder: Builder) where Builder.Value == Wrapped {
        
        let controller = CheckListController(droplet: drop)
        
        builder.get("/", handler: controller.index);
        builder.get("/", CheckListItem.self, handler: controller.show);
    }
}
