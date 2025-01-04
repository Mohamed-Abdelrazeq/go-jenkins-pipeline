package handlers

import (
	"github.com/Mohamed-Abdelrazeq/go-pipeline-demo/app/src/models"
	"github.com/gofiber/fiber/v2"
)

func FiberHealthCheckHandler(c *fiber.Ctx) error {
	response := models.Response{
		Message: "I'm alive!",
		Status:  200,
		Data:    nil,
	}
	return c.JSON(response)
}
