import Vapor

func configureRoutes(for app: Application) throws {
    let gameContentController = GameContentController()
    try app.register(collection: gameContentController)

    let articleController = ArticleController()
    try app.register(collection: articleController)
}
