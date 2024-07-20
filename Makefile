.PHONY: terraform-plan terraform-apply

terraform-plan:
	cd terraform && terraform plan

terraform-apply:
	cd scripts && ./register_tfvars_to_ssm.sh && cd ../terraform && terraform apply