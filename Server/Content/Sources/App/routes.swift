import Vapor

func routes(_ app: Application) throws {

    let gameContentController = GameContentController()
    app.get("content", use: gameContentController.all)
    app.get("content", "next", use: gameContentController.nextText)
    app.post("content", use: gameContentController.create)
    app.delete("content", ":contentId", use: gameContentController.delete)
    
    let articleController = ArticleController()
    app.get("articles", use: articleController.all)
    app.get("articles", ":articleId", use: articleController.getByID)
    app.post("articles", use: articleController.create)
    app.delete("articles", ":articleID", use: articleController.delete)
}
