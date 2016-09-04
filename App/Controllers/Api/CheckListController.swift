import Vapor
import HTTP

final class CheckListController: ResourceRepresentable {
    typealias Item = CheckListItem
    
    let drop: Droplet
    init(droplet: Droplet) {
        drop = droplet
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        let activeCheckLists = try CheckListItem.query().filter("is_active", .equals, 1).all()
        return try JSON(activeCheckLists)
    }
    
    func show(request: Request, item checklistItem: CheckListItem) throws -> ResponseRepresentable {
        return try JSON([checklistItem])
    }
    
    func makeResource() -> Resource<CheckListItem> {
        return Resource(
            index: index,
            show: show
        )
    }
}
