import Vapor
import JSON
import Foundation
import SWXMLHash

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
        
        let xml = SWXMLHash.parse(xmlString)
    
        var array: [News] = [];
        xml["rss"]["channel"]["item"].all.forEach({
            do {
                array.append(try News(rssElement: $0, raceId: rss.raceId, drop: drop))
            } catch
            {
                drop.console.error("Could not parse entry")
            }
        })
        
        return array
    }
    
 
    
   
}
