OS ?= $(shell uname)
ARCH ?= amd64

BIN_DIR = bin
KIND := $(BIN_DIR)/kind
KIND_VERSION ?= v0.10.0

all: e2e-test

e2e-test: $(KIND)
	$(KIND) create cluster
	$(KIND) export kubeconfig
	kubectl apply -f test-pod.yaml

clean:
	rm -rf $(BIN_DIR)

$(KIND): $(BIN_DIR)
	curl -fsSL https://github.com/kubernetes-sigs/kind/releases/download/$(KIND_VERSION)/kind-$(OS)-$(ARCH) > $(KIND)
	chmod +x $(KIND)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)
