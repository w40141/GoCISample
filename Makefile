.PHONY: setup

NAME          := GoCISample

### PHONY ターゲットのビルドルール
all: setup
setup: ## install tools for development
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	go install golang.org/x/vuln/cmd/govulncheck@latest
	go install github.com/cosmtrek/air@latest
	go install golang.org/x/tools/cmd/goimports@latest
	go install github.com/zoncoen/scenarigo/cmd/scenarigo@latest
