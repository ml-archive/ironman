import Foundation

class FacebookPosts {
    func retrieve(race: Race) throws {
        if(race.fbPage.isEmpty){
            return
        }
        
        try retrieve(fbPage: race.fbPage)
    }
    
    func retrieve(fbPage: String) throws {
        
        let url = "https://graph.facebook.com/v2.7/\(fbPage)/posts?access_token=EAACEdEose0cBANPcBvyVDF43JTDDRufZAsMpMKN2jeRRYvbAV7VHi8C3SZC371q8Yl39bj4BzwguqpJjZAPZAZAmkMX1JfFtMjCep9ZBX76SYRQUIqyZAb2vOHDLvdXvF0PPlH1kOPw8hZApcB7dQoGTrK32axbrrbozUCqzQd2nHAZDZD"
        
        print(url);
    }
}
