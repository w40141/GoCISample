package main

import (
	"context"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestPingGinRouter(t *testing.T) {
	t.Parallel()

	router := setupGinRouter()

	req, _ := http.NewRequestWithContext(context.Background(), http.MethodGet, "/", nil)
	recorder := httptest.NewRecorder()
	router.ServeHTTP(recorder, req)

	if recorder.Code != 200 {
		t.Errorf("Expected status code 200, but got %d", recorder.Code)
	}

	if body := recorder.Body.String(); body != `Hello World by Gin!` {
		t.Errorf("Expected response body 'Hello World by Gin!', but got '%s'", body)
	}
}

func TestPingEchoRouter(t *testing.T) {
	t.Parallel()

	router := setupEchoRouter()

	req, _ := http.NewRequestWithContext(context.Background(), http.MethodGet, "/", nil)
	recorder := httptest.NewRecorder()
	router.ServeHTTP(recorder, req)

	if recorder.Code != 200 {
		t.Errorf("Expected status code 200, but got %d", recorder.Code)
	}

	if body := recorder.Body.String(); body != `Hello World by Echo!` {
		t.Errorf("Expected response body 'Hello World by Echo!', but got '%s'", body)
	}
}
