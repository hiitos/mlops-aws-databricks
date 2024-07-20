.PHONY terraform-plan terraform-apply

terraform-plan:
	cd terraform && terraform plan

terraform-apply:
	cd terraform && terraform apply