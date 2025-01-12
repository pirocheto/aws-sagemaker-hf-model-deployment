ENV = dev

.PHONY: init
init:
	terraform -chdir=terraform init

.PHONY: validate
validate:
	terraform -chdir=terraform validate

.PHONY: plan
plan:
	terraform -chdir=terraform plan

.PHONY: apply
apply:
	terraform -chdir=terraform apply -auto-approve

.PHONY: destroy
destroy:
	terraform -chdir=terraform destroy

.PHONY: workspace
workspace:
	terraform -chdir=terraform workspace select -or-create ${ENV}
