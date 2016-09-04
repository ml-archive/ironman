import Vapor
import JSON
import Foundation

class RssRetriever {
    let drop: Droplet
    
    init(drop: Droplet) {
        self.drop = drop
    }
    
    func retrieve(rss: Rss) throws -> [News] {
        if(rss.url.isEmpty){
            throw Abort.custom(status: .badRequest, message: "Rss passed does not have a url")
        }

        let response = try drop.client.get("http://www.ibtimes.co.uk/rss/feed")
        
        guard let xmlString = response.body.bytes?.string else {
            throw Abort.custom(status: .badRequest, message: "Could not retrieve xml string")
        }
        
        RssParser().parseRss(string: xmlString) { (items) in
            print( items )
        }

        
        //print(parser)
        

        
//        guard let data = postResponse.json?["data"] else {
//            throw Abort.custom(status: .badRequest, message: "Data could not be parsed")}
        
        var array: [News] = [];
//        data.makeNode().pathIndexableArray?.forEach({
//            do {
//                array.append(try News(node: $0, raceId: raceId))
//            } catch
//            {
//                drop.console.error("Could not parse entry")
//            }
//        })
        
        return array
    }
    
 
    
   
}
