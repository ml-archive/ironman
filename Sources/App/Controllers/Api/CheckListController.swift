import Vapor
import HTTP

final class CheckListController: ResourceRepresentable {
    typealias Item = CheckListItem
    
    let drop: Droplet
    init(droplet: Droplet) {
        drop = droplet
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        guard let raceId = request.parameters["w0"]?.int ?? request.parameters["raceId"]?.int else {
            throw Abort.custom(status: .notFound, message: "Race was not found")
        }
        
        let activeCheckLists = try CheckListItem.query()
            .filter("is_active", .equals, 1)
            .filter("race_id", .equals, raceId)
            .all()
        
        
        // Should be possible to make more flexible
        var registrations: [Node] = []
        var checkIn: [Node] = []
        var raceMorning: [Node] = []
        
        try activeCheckLists.forEach({
            switch($0.type) {
            case "registration":
                try registrations.append($0.makeNode())
                break
            case "check_in":
                try checkIn.append($0.makeNode())
                break
            case "race_morning":
                try raceMorning.append($0.makeNode())
                break
            default:
                throw Abort.custom(status: .internalServerError, message: "Type \($0.type) is not supported")
            }
        })
        
        
        return try JSON(node: [
            "registrations": registrations.makeNode(),
            "checkIns": checkIn.makeNode(),
            "raceMorning": raceMorning.makeNode()
        ])
    }
    
    func show(request: Request, item checklistItem: CheckListItem) throws -> ResponseRepresentable {
        return try JSON(node: [checklistItem])
    }
    
    func makeResource() -> Resource<CheckListItem> {
        return Resource(
            index: index,
            show: show
        )
    }
}
