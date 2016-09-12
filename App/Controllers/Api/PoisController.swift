import Vapor
import HTTP

final class PoisController: ResourceRepresentable {
    typealias Item = Poi
    
    let drop: Droplet
    init(droplet: Droplet) {
        drop = droplet
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        guard let raceId = request.parameters["w0"]?.int ?? request.parameters["raceId"]?.int else {
            throw Abort.custom(status: .notFound, message: "Race was not found")
        }
        
        let activePois = try Poi.query()
            .filter("is_active", .equals, 1)
            .filter("race_id", .equals, raceId)
            //.sort("position")
            .all()
        
        return try JSON(node: activePois)
    }
    
    func makeResource() -> Resource<Poi> {
        return Resource(
            index: index
        )
    }
}
