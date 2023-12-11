// Package main is the main package.
package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/labstack/echo/v4"
)

func setupGinRouter() *gin.Engine {
	router := gin.Default()
	router.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, "Hello World by Gin!")
	})

	return router
}

func setupEchoRouter() *echo.Echo {
	router := echo.New()
	router.GET("/", func(c echo.Context) error {
		a := c.String(http.StatusOK, "Hello World by Echo!")

		return a
	})

	return router
}

func main() {
	ginRouter := setupGinRouter()
	log.Fatal(ginRouter.Run(":8080"))

	// http.HandleFunc("/", func(w http.ResponseWriter, _ *http.Request) {
	// 	_, _ = w.Write([]byte("Hello World by Def!"))
	// })
	// log.Fatal(http.ListenAndServe(":8080", nil))

	// echoRouter := setupEchoRouter()
	// log.Fatal(echoRouter.Start(":8080"))
}
