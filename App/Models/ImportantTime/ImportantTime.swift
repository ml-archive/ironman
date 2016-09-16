import Vapor
import Fluent

final class ImportantTime: Model {
    
    static var entity = "important_times"
    
    var id: Node?
    var raceId: Node
    
    var date: String
    var timeStart: String
    var timeStop: String
    
    var title: String
    var description: String

    var poiId: Node
    var showOnMap: Bool
    
    var isActive: Bool
    var createdAt: String
    var updatedAt: String
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        raceId = try node.extract("race_id")
        
        date = try node.extract("date")
        timeStart = try node.extract("time_start")
        timeStop = try node.extract("time_stop")
        
        title = try node.extract("title")
        description = try node.extract("description")
    
        poiId = try node.extract("poi_id")
        showOnMap = try node.extract("show_on_map")
        
        isActive = try node.extract("is_active")
        createdAt = try node.extract("created_at")
        updatedAt = try node.extract("updated_at")
    }
    
    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "race_id": raceId,
            
            "date": Node(date),
            "time_start": Node(timeStart),
            "time_stop": Node(timeStop),
            
            "title": Node(title),
            "description": Node(description),
            
            "poi_id": poiId,
            "show_on_map": showOnMap,
            
            "is_active": Node(isActive),
            "created_at": Node(createdAt),
            "updated_at": Node(updatedAt)
        ])
    }
    
    func makeJSON() throws -> JSON {
        let poi = try self.poi()
        
        return try JSON(node: [
            "id": id,
            
            "date": date,
            "timeStart": timeStart,
            "timeStop": timeStop,
            
            "title": title,
            "description": description,
            
            "poi":  poi.get(),
            "showOnMap": showOnMap
        ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("important_times") { importantTimes in
            importantTimes.id()
            importantTimes.int("race_id")
            
            importantTimes.string("date")
            importantTimes.string("time_start")
            importantTimes.string("time_stop")
            
            importantTimes.string("title")
            importantTimes.string("description")
            
            importantTimes.int("poi_id", optional: true)
            importantTimes.bool("show_on_map")
            
            importantTimes.bool("is_active")
            importantTimes.string("created_at", optional: true)
            importantTimes.string("updated_at", optional: true)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("important_times")
    }
}

extension ImportantTime {
    func race() throws -> Parent<Race> {
        return try parent(raceId)
    }
}

extension ImportantTime {
    func poi() throws -> Parent<Poi> {
        return try parent(poiId)
    }
}
