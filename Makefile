
# VARIABLES
PREFIX := bygui86
NAME := go-fileserver
VERSION := 0.0.1
PORT := 8080


# DEFAULTS
.PHONY: help
DEFAULT: help
.DEFAULT_GOAL := help


# ACTIONS
build :     ## Build Docker image
    docker build . -t $(PREFIX)/$(NAME):$(VERSION)

run :       ## Run on Docker
    docker run --name $(NAME) -d -p $(PORT):$(PORT) $(PREFIX)/$(NAME):$(VERSION) && docker ps -a --format "{{.ID}}\t{{.Names}}" | grep $(NAME)

stop :      ## Stop Docker container
    docker rm $$(docker stop $$(docker ps -a -q --filter "ancestor=$(PREFIX)/$(NAME):$(VERSION)" --format="{{.ID}}"))

push :      ## Push Docker image
    docker push $(PREFIX)/$(NAME):$(VERSION)

deploy :        ## Deploy on Kubernetes
    kubectl apply -k kube/

clean :     ## Clean environment
    @rm -f main


# HELPERS
help :		## Help
	@echo ""
	@echo "*** \033[33mMakefile help\033[0m ***"
	@echo ""
	@echo "Targets list:"
	@grep -E '^[a-zA-Z_-]+ :.*?## .*$$' $(MAKEFILE_LIST) | sort -k 1,1 | awk 'BEGIN {FS = ":.*?## "}; {printf "\t\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo ""

print-variables :		## Print variables values
	@echo ""
	@echo "*** \033[33mMakefile variables\033[0m ***"
	@echo ""
	@echo "- - - makefile - - -"
	@echo "MAKE: $(MAKE)"
	@echo "MAKEFILES: $(MAKEFILES)"
	@echo "MAKEFILE_LIST: $(MAKEFILE_LIST)"
	@echo "- - - general - - -"
	@echo "PREFIX: $(PREFIX)"
	@echo "NAME: $(NAME)"
	@echo "VERSION: $(VERSION)"
	@echo "PORT: $(PORT)"
	@echo ""
