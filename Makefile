.DEFAULT_GOAL = all

version  := $(shell git rev-list --count HEAD).$(shell git rev-parse --short HEAD)

name     := dnsprove
package  := github.com/sbacha/$(name)
packages := $(shell go list ./... | grep -v /vendor/)

.PHONY: all
all:: dependencies
all:: build

.PHONY: dependencies
dependencies::
	dep ensure

.PHONY: test
test::
	go test -v $(packages)

.PHONY: bench
bench::
	go test -bench=. -v $(packages)

.PHONY: lint
lint::
	go vet -v $(packages)

.PHONY: check
check:: lint test

.PHONY: clean
clean::
	git clean -xddff
