import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    let textController = TextController()
    app.get("texts", use: textController.all)
    app.get("texts", ":textID", use: textController.getById)
    app.post("texts", use: textController.create)
    app.delete("texts", ":textID", use: textController.delete)
    
    let articleController = ArticleController()
    app.get("articles", use: articleController.index)
    app.get("articles", ":textID", use: articleController.getById)
    app.post("articles", use: articleController.create)
    app.delete("articles", ":articleID", use: articleController.delete)
}
