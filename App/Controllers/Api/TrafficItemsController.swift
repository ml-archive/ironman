import Vapor
import HTTP

final class TrafficItemsController: ResourceRepresentable {
    typealias Item = TrafficItem
    
    let drop: Droplet
    init(droplet: Droplet) {
        drop = droplet
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        print(request.parameters)
        guard let raceId = request.parameters["w0"]?.int ?? request.parameters["raceId"]?.int else {
            throw Abort.custom(status: .notFound, message: "Race was not found")
        }
        
        let activeTrafficItems = try TrafficItem.query()
            .filter("is_active", .equals, 1)
            .filter("race_id", .equals, raceId)
            .all()
        
        return try JSON(activeTrafficItems)
    }
    
    func makeResource() -> Resource<TrafficItem> {
        return Resource(
            index: index
        )
    }
}
