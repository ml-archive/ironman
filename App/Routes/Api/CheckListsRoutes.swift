import Vapor
import HTTP
import Routing

struct CheckListsRoutes: RouteCollection, EmptyInitializable {
    
    typealias Wrapped = Responder
    
    func build<Builder: RouteBuilder>(_ builder: Builder) where Builder.Value == Wrapped {
        
        let controller = CheckListController(droplet: drop)
        
        builder.get(":raceId", "/checklists", handler: controller.index);
        //builder.get("/checklists", CheckListItem.self, handler: controller.show);
    }
}
