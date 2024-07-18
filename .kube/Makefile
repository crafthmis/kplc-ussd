.PHONY: all kplc_kube clean
all: kplc_kube
kplc_kube:
	@echo "Setting kplc kubernetes environment"
	@export KUBECONFIG=~/.kube/admin
clean:
	@echo "Removing kplc kubernetes config.."
	@export KUBECONFIG=~/.kube/config

