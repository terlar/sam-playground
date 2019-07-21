NAME := sam-playground

S3_BUCKET := $(NAME)
S3_PREFIX := ''
AWS_REGION := eu-west-1
STACK_NAME := $(NAME)

.DEFAULT_GOAL := help
.PHONY: help
help: ## Show this help message.
	$(info $(NAME) $(TAG))
	@echo "Usage: make [target] ..."
	@echo
	@echo "Targets:"
	@egrep '^(.+)\:[^#]*##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

.PHONY: create-s3-bucket
create-s3-bucket: ## Create S3 bucket provided by S3_BUCKET
	bin/aws s3 mb s3://$(S3_BUCKET)

.PHONY: package
package: ## Package artifacts.
package: tmp/packaged.yaml

.PHONY: deploy
deploy: ## Deploy service.
deploy: tmp/packaged.yaml
	$(info --- Deploying service)
	$(AWS) cloudformation deploy \
	  --template-file $< \
	  --stack-name $(STACK_NAME) \
	  --capabilities CAPABILITY_IAM \
	  --no-fail-on-empty-changeset

tmp/packaged.yaml: app/template.yaml
	$(info --- Packaging $< into $@)
	$(AWS) cloudformation package \
	  --template-file $< \
	  --s3-bucket $(S3_BUCKET) \
	  --s3-prefix $(S3_PREFIX) \
	  --output-template-file $@
