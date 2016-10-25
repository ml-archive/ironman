import Vapor
import JSON
class FacebookPostsRetriever {
    
    let drop: Droplet
    
    init(drop: Droplet) {
        self.drop = drop
    }
    
    func retrieve(race: Race) throws -> [News] {
        if(race.fbPage.isEmpty){
            throw Abort.custom(status: .badRequest, message: "Race passed does not have a fb page")
        }
        
        guard let raceId = race.id else {
            throw Abort.custom(status: .badRequest, message: "Race does not have an Id")
        }
        
        return try retrieve(fbPage: race.fbPage, raceId: raceId)
    }
    
    func retrieve(fbPage: String, raceId: Node) throws -> [News] {
        let tokenResponse = try drop.client.get("https://graph.facebook.com/v2.7/oauth/access_token", headers: [
            "Accept":"application/json"
            ], query: [
            "client_id": "x",
            "client_secret": "x",
            "grant_type": "client_credentials"
        ])
        guard let token = tokenResponse.json?["access_token"]?.string else {
            throw Abort.custom(status: .unauthorized, message: "Token was not returned")}
        
        let url = "https://graph.facebook.com/v2.7/\(fbPage)/posts"
        
        let postResponse = try drop.client.get(url, headers:[
                "Accept":"application/json"
            ], query: [
            "access_token": token,
            "limit": 50
        ])
        
        guard let data = postResponse.json?["data"] else {
            throw Abort.custom(status: .badRequest, message: "Data could not be parsed")}
        
        var array: [News] = [];
        data.makeNode().pathIndexableArray?.forEach({
            do {
                array.append(try News(fbNode: $0, raceId: raceId))
            } catch
            {
                drop.console.error("Could not parse entry")
            }
        })
        
        return array
    }
}
