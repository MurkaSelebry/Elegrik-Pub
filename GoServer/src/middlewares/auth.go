package middlewares

import (
	"context"
	"log"
	"main/src/models"
	"net/http"
	"strings"
)

func AuthMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		token := r.Header.Get("Authorization")
		if token == "" {
			http.Error(w, "Unauthorized to perform request. Please get a valid API key", http.StatusUnauthorized)
			return
		}

		// Extract Bearer token
		const bearerPrefix = "Bearer "
		splitToken := strings.Split(token, bearerPrefix)
		var reqToken = splitToken[1]

		if reqToken == "" {
			http.Error(w, "Invalid token format. Bearer token required", http.StatusUnauthorized)
			return
		}

		claims, err := models.DecodeToken(reqToken)
		if err != nil {
			log.Printf("Error decoding token: %v\n", err)
			// http.Error(w, "Unauthorized to perform request. Invalid token", http.StatusUnauthorized)
			return
		}

		log.Printf("Claims: %v\n", claims)

		// Set userId in context
		ctx := context.WithValue(r.Context(), "userId", 1)
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}
