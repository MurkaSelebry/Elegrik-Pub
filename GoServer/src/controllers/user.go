package controllers

import (
	"encoding/json"
	"net/http"

	"main/src/models"
)

func Login(w http.ResponseWriter, r *http.Request) {
	var input models.User
	if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	loggedUser, err := input.Login()
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(map[string]interface{}{
		"status":  "success",
		"message": "Startup saved successfully",
		"data":    loggedUser,
	})
}

func Register(w http.ResponseWriter, r *http.Request) {
	var input models.User
	if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	loggedUser, err := input.Register()
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(map[string]interface{}{
		"status":  "success",
		"message": "Startup saved successfully",
		"data":    loggedUser,
	})
}

func GetProfile(w http.ResponseWriter, r *http.Request) {
	// userId := 1
	// // if userId == nil {
	// //  http.Error(w, "Startup ID is required", http.StatusBadRequest)
	// //  return
	// // }
	// startup, err := models.FetchUser(userId)
	// if err != nil {
	//  http.Error(w, err.Error(), http.StatusBadRequest)
	//  return
	// }
	// w.Header().Set("Content-Type", "application/json")
	// w.WriteHeader(http.StatusOK)
	// json.NewEncoder(w).Encode(map[string]interface{}{
	//  "status":  "success",
	//  "message": "Startup fetched successfully",
	//  "data":    startup,
	// })
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]interface{}{
		"status": "success123",
	})
}
