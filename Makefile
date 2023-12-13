.PHONY: build vet fmt test run clean download lint setup generate coverage help vuln all hotload

NAME          := GoCISample

### コマンドの定義
GO        := go
GO_BUILD  := $(GO) build
GO_VET    := $(GO) vet
FMT       := goimports
GO_FORMAT := $(FMT) -w
GO_TEST   := $(GO) test -v
GO_RUN    := $(GO) run -v
LINT      := golangci-lint
GO_LINT   := $(LINT) run
RUNNER    := air
HOTRELOAD := $(RUNNER) -c .air.toml
VULNCHECK := govulncheck
GO_VULN   := $(VULNCHECK)

### ターゲットパラメータ
EXECUTABLES := bin/main
MAIN        := main.go
GO_PKGROOT  := ./...

### Tools
LINTER      := github.com/golangci/golangci-lint/cmd/golangci-lint@latest
VULNCHECKER := golang.org/x/vuln/cmd/govulncheck@latest
HOTRELOADER := github.com/cosmtrek/air@latest
FORMATTER   := golang.org/x/tools/cmd/goimports@latest

### PHONY ターゲットのビルドルール
all: build fmt lint test ## run all commands
build: download generate ## build the executable file
	@$(GO_BUILD) -o $(EXECUTABLES) $(MAIN)
vet: ## vet the packages
	@$(GO_VET) $(GO_PKGROOT)
fmt: ## format the packages
	@hash $(FMT) > /dev/null 2>&1; if [ $$? -ne 0 ]; then \
		$(GO) install $(FORMATTER); \
	fi
	@$(GO_FORMAT) .
test: ## run the tests
	@$(GO_TEST) $(GO_PKGROOT)
run: ## run the main.go
	@$(GO_RUN) $(MAIN)
hotload: ## hot reload
	@hash $(RUNNER) > /dev/null 2>&1; if [ $$? -ne 0 ]; then \
		$(GO) install $(HOTRELOADER); \
	fi
	@$(HOTRELOAD)
clean: ## remove output files and clean cache
	@rm -rf $(EXECUTABLES)
	@$(GO) clean
download: ## download dependencies
	@$(GO) mod tidy
	@$(GO) mod download
	@$(GO) mod verify
lint: ## lint the packages
	@hash $(LINT) > /dev/null 2>&1; if [ $$? -ne 0 ]; then \
		$(GO) install $(LINTER); \
	fi
	@$(GO_LINT) $(GO_PKGROOT)
setup: ## install tools for development
	@$(GO) install $(FORMATTER)
	@$(GO) install $(LINTER)
	@$(GO) install $(HOTRELOADER)
	@$(GO) install $(VULNCHECKER)
generate: ## code generate
	@# コード生成処理があれば
vuln: ## check vulnerabilities
	@hash $(VULNCHECK) > /dev/null 2>&1; if [ $$? -ne 0 ]; then \
		$(GO) install $(VULNCHECKER); \
	fi
	@$(GO_VULN) $(GO_PKGROOT)
coverage: cover.html ## test-coverage displays code coverage per package
	@$(GO) tool cover -func cover.out
cover.out:
	@$(GO) test -race -timeout 30m -cover ./... -coverprofile=cover.out
	@echo "create cover.out"
cover.html: cover.out
	@$(GO) tool cover -html=cover.out -o cover.html
	@echo "create cover.html"
help: ## display this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
%:
	@echo 'command "$@" is not found.'
	@$(MAKE) help
	@exit 2
