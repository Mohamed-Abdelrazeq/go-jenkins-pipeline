package main

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/Mohamed-Abdelrazeq/go-pipeline-demo/src/handlers"
	"github.com/gofiber/fiber/v2"
)

func TestFiberHealthCheckHandler(t *testing.T) {
	app := fiber.New()
	app.Get("/health", handlers.FiberHealthCheckHandler)

	req := httptest.NewRequest("GET", "/health", nil)
	resp, err := app.Test(req)
	if err != nil {
		t.Fatalf("Failed to send request: %v", err)
	}

	if resp.StatusCode != http.StatusOK {
		t.Errorf("Expected status code %d but got %d", http.StatusOK, resp.StatusCode)
	}
}
