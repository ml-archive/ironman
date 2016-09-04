import Vapor
import JSON
class YoutubeVideoRetriever {
    
    let drop: Droplet
    
    init(drop: Droplet) {
        self.drop = drop
    }
    
    func retrieve(race: Race) throws -> [Node] {
        if(race.youtubeChannel.isEmpty){
            throw Abort.custom(status: .badRequest, message: "Race passed does not have a youtube channel")
        }
        
        return try retrieve(youtubeChannel: race.youtubeChannel)
    }
    
    func retrieve(youtubeChannel: String) throws -> [Node] {
        let url = "https://www.googleapis.com/youtube/v3/search"
        let response = try drop.client.get(url, headers:[
            "Accept":"application/json"
            ], query: [
                "key": "AIzaSyAEhtTAYnHPA30TIym6U8HHDJFs2dZLmHY",
                "channelId": youtubeChannel,
                "part": "snippet,id",
                "order": "date",
                "maxResults": 20
            ])

        if(response.status != .ok) {
            throw Abort.custom(status: .badRequest, message: "Youtube api failed")
        }

        guard let data = response.json?["items"] else {
            throw Abort.custom(status: .badRequest, message: "Data could not be parsed")}
        
        var array: [Node] = [];
        
        data.makeNode().pathIndexableArray?.forEach({
            let item = $0;
            
            do {
                
                let thumbnail: [String:String] = [
                    "hqDefault" : try item.extract("snippet", "thumbnails", "high", "url"),
                    "sqDefault" : try item.extract("snippet", "thumbnails", "medium", "url")
                ]
                
                let id: String = try item.extract("id", "videoId")
                let videoUrl: String = "https://m.youtube.com/watch?v='" + id
                
                array.append(try Node([
                    "id": id.makeNode(),
                    "title": item.extract("snippet", "title"),
                    "description": item.extract("snippet", "description"),
                    "thumbnail": thumbnail.makeNode(),
                    "player": [
                        "mobile": videoUrl.makeNode()
                    ]
                ]))
            } catch
            {
                drop.console.error("Could not parse entry")
            }
        })
        
        return array
    }
}
