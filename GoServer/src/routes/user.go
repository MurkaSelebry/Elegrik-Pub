package routes

import (
	"main/src/controllers"
	"main/src/middlewares"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

func startupsGroupRouter(r chi.Router) {
	r.Route("/auth", func(r chi.Router) {
		r.Group(func(r chi.Router) {
			r.Use(middlewares.AuthMiddleware)
			r.Get("/profile", controllers.GetProfile)
		})
		// r.Get("/profile", controllers.GetProfile)

		r.Post("/login", controllers.Login)
		r.Post("/register", controllers.Register)
	})

}

func SetupRoutes() *chi.Mux {
	r := chi.NewRouter()
	r.Use(middleware.Logger)

	// CORS configuration
	// cors := cors.New(cors.Options{
	// 	AllowedOrigins:   []string{"*"},
	// 	AllowedMethods:   []string{"GET", "POST", "PUT", "DELETE"},
	// 	AllowedHeaders:   []string{"Origin", "Content-Type", "Accept"},
	// 	ExposedHeaders:   []string{"Content-Length"},
	// 	AllowCredentials: true,
	// 	MaxAge:           int(12 * time.Hour / time.Second),
	// })
	// r.Use(cors.Handler)

	r.Route("/api", func(r chi.Router) {
		startupsGroupRouter(r)
	})

	return r
}
