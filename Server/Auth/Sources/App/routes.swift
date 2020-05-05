import Vapor

func configureRoutes(for app: Application) throws {
    let authController = AuthController()
    try app.register(collection: authController)
}
