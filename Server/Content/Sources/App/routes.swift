import Vapor

func configureRoutes(for app: Application) throws {
    let gameContentController = GameContentController()
    try app.register(collection: gameContentController)

    let articleController = ArticleController()
    let contentRoutes = app.grouped("content")
    try contentRoutes.register(collection: articleController)
}
