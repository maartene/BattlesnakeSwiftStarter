import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // Configure custom hostname.
    app.http.server.configuration.hostname = "0.0.0.0"
    
    // Configure custom port.
    app.http.server.configuration.port = 8000
    
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // register routes
    try routes(app)
}
