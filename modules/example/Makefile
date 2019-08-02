.PHONY=create_keyring create_key create_secret create_bucket encryption init plan apply destroy

REGION?=europe-west1
PROJECT?=shp-x-10
GCLOUD?=gcloud
GSUTIL?=gsutil
TERRAFORM?=terraform
OPENSSL?=openssl
TAG?=shipperizer-
KEY?=$(TAG)tfstate-1
KEYRING?=$(TAG)tf
BUCKET?=$(TAG)tf-bucket
SECRET?=
ENCRYPTION_KEY?=<encryption_key>
AUTO?=-auto-approve
PARALLELISM?=20


create_keyring:
	@echo "Always double check that an existing keyring is not there with the name $(KEYRING)"
	$(GCLOUD) kms keyrings create $(KEYRING) --location $(REGION) --project $(PROJECT)

create_key:
	@echo "Always double check that an existing key is not there with the name $(KEY) in the keyring $(KEYRING)"
	$(GCLOUD) kms keys create $(KEY) --purpose=encryption --keyring=$(KEYRING) --location $(REGION) --project $(PROJECT)

create_secret:
	@echo "Store the generated key in a safe place, it's a one off key so keep it tight "
	$(OPENSSL) rand -base64 32 | \
	tr -d '\n' | \
	$(GCLOUD) kms encrypt \
	--project $(PROJECT) --location $(REGION) --keyring=$(KEYRING) --key=$(KEY) \
	--plaintext-file - --ciphertext-file - | \
	base64 | \
	tr -d '\r\n'

create_bucket:
	$(GSUTIL) mb -p $(PROJECT) -c REGIONAL -l $(REGION) gs://$(BUCKET)

encryption:
	@echo "Store the following output in the env var ENCRYPTION_KEY"
	echo -n $(SECRET) | \
	base64 --decode | \
	$(GCLOUD) kms decrypt --project $(PROJECT) --location $(REGION) --keyring=$(KEYRING) --key=$(KEY) --plaintext-file - --ciphertext-file -

init:
	@echo "Make sure to run 'make encryption' and store the output in the env var ENCRYPTION_KEY"
	$(TERRAFORM) init -backend-config="bucket=$(BUCKET)" -backend-config="encryption_key=$(ENCRYPTION_KEY)"

plan: init
	$(TERRAFORM) plan

apply: plan
	$(TERRAFORM) apply -parallelism=$(PARALLELISM) $(AUTO)

destroy: init
	$(TERRAFORM) destroy -parallelism=$(PARALLELISM)
