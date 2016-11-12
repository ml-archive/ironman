import Vapor
import HTTP

final class NewsController: ResourceRepresentable {
    typealias Item = Race
    
    let drop: Droplet
    init(droplet: Droplet) {
        drop = droplet
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        let activeNews = try News.query().filter("is_active", .equals, 1).all()
        return try JSON(node: activeNews)
    }
    
    func show(request: Request, item news: News) throws -> ResponseRepresentable {
        return try JSON(node: [news])
    }
    
    func makeResource() -> Resource<News> {
        return Resource(
            index: index,
            show: show
        )
    }
}
