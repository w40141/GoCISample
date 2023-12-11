.PHONY: build test clean static_analysis lint vet fmt chkfmt

### コマンドの定義
GO          = go
GO_BUILD    = $(GO) build
GO_FORMAT   = $(GO) fmt
GOFMT       = gofmt
GO_LIST     = $(GO) list
GOLINT      = golint
GO_TEST     = $(GO) test -v
GO_VET      = $(GO) vet
GO_LDFLAGS  = -ldflags="-s -w"
GOOS        = linux

### ターゲットパラメータ
EXECUTABLES = bin/main
TARGETS     = $(EXECUTABLES)
GO_PKGROOT  = ./...
GO_PACKAGES = $(shell $(GO_LIST) $(GO_PKGROOT) | grep -v vendor)

### PHONY ターゲットのビルドルール

build: $(TARGETS)
test:
    env GOOS=$(GOOS) $(GO_TEST) $(GO_PKGROOT)
clean:
    rm -rf $(TARGETS) ./vendor Gopkg.lock

static_analysis: chkfmt lint vet

lint:
    $(GOLINT) -set_exit_status $(GO_PACKAGES)
vet:
    $(GO_VET) $(GO_PACKAGES)
fmt:
    $(GO_FORMAT) $(GO_PKGROOT)
chkfmt:
    bash -c "diff -u <(echo -n) <($(GOFMT) -d $(shell git ls-files | grep ".go$$"))"

### 実行ファイルのビルドルール

bin/main:
    env GO111MODULE=on GOOS=$(GOOS) $(GO_BUILD) $(GO_LDFLAGS) -o $@

#   gopls
#   gotests
#   gomodifytags
#   impl
#   goplay
#   dlv
#   staticcheck