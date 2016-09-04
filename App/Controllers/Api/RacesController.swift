import Vapor
import HTTP

final class RacesController: ResourceRepresentable {
    typealias Item = Race
    
    let drop: Droplet
    init(droplet: Droplet) {
        drop = droplet
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        let activeRaces = try Race.query().filter("is_active", .equals, 1).all()
        return try JSON(activeRaces)
    }
    
    func show(request: Request, item race: Race) throws -> ResponseRepresentable {
        return race
    }
    
    func videos(request: Request, item race: Race) throws -> ResponseRepresentable {
       let videos = try YoutubeVideoRetriever(drop: drop).retrieve(race: race)
        return try JSON(node: videos)
    }
    
    func makeResource() -> Resource<Race> {
        return Resource(
            index: index,
            show: show
//            ,
//            videos: videos
        )
    }
}
