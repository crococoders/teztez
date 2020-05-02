import Fluent
import Vapor

final class GameContent: Model, Content {
    static let schema = "game_contents"
    
    func makeBackwards() -> GameContent{
        let regex = try! NSRegularExpression(pattern: "([A-Za-z])\\w+")

        let words = self.text.split(separator: " ")
        var backwardsWords:[String] = []
        for var word in words {
            let results = regex.matches(in: String(word), range: NSRange(location: 0,length: word.count))
            
            for result in results {
                word.replaceSubrange(Range(result.range, in: word)!, with: word[Range(result.range, in: word)!].reversed())
            }
            backwardsWords.append(String(word))
        }
        
        self.text = backwardsWords.joined(separator:" ")
        
        return self
    }
    
    func makeShuffle()  -> GameContent{
        let regex = try! NSRegularExpression(pattern: "(?<=[A-Za-z])([A-Za-z]){2,}(?=[a-zA-Z])")

        let words = self.text.split(separator: " ")
        var shuffledWords:[String] = []
        for var word in words {
            let results = regex.matches(in: String(word), range: NSRange(location: 0,length: word.count))
            
            for result in results {
                word.replaceSubrange(Range(result.range, in: word)!, with: word[Range(result.range, in: word)!].shuffled())
            }
            shuffledWords.append(String(word))
        }

        self.text = shuffledWords.joined(separator:" ")

        return self
    }
    
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "text")
    var text: String

    init() { }

    init(id: UUID? = nil, title: String, text: String) {
        self.id = id
        self.title = title
        self.text = text
    }
}
