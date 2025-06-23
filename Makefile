.PHONY: all fmt output

all:

fmt:
	terraform fmt -recursive

output:
	terraform output -raw talosconfig > talosconfig
	terraform output -raw kubeconfig > kubeconfig
