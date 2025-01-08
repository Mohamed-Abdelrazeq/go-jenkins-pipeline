package main

import (
	"github.com/Mohamed-Abdelrazeq/go-pipeline-demo/app/src/handlers"
	"github.com/gofiber/fiber/v2"
)

func main() {
	app := fiber.New()

	app.Get("/", func(c *fiber.Ctx) error {
		return c.SendString("Hello, World!")
	})

	// add handler for health check
	app.Get("/health", handlers.FiberHealthCheckHandler)

	app.Listen(":3000")
}
