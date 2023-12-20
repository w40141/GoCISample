// Package main is the main package.
package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/labstack/echo/v4"
)

func setupGinRouter() *gin.Engine {
	router := gin.Default()
	router.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, "Hello World by gin!")
	})

	return router
}

func setupEchoRouter() *echo.Echo {
	router := echo.New()
	router.GET("/", func(c echo.Context) error {
		a := c.String(http.StatusOK, "Hello World by echo!")

		return a
	})

	return router
}

func main() {
	port, ok := os.LookupEnv("APP_PORT")
	if !ok {
		panic("APP_PORT is not set")
	}
	port = fmt.Sprintf(":%s", port)

	http.HandleFunc("/", func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write([]byte("Hello World"))
	})
	log.Fatal(http.ListenAndServe(port, nil))
	// }
}
