# Setup

## GCS bucket setup

Create a GCS bucket for terraform state with:

`gsutil mb -p <project_id> -c REGIONAL -l <region> gs://<bucket_name>/`



## KMS setup.

* Create new keyring with:

`gcloud --project <project_id> kms keyrings create <keyring> --location <region>`

* Check https://cloud.google.com/kms/docs/locations#hsm_regions to see where Cloud HSM
  (Hardware Security Module) is enabled, europe-west1 is good

* Create key with:

`gcloud --project <project_id> kms keys create <key> --purpose=encryption --keyring=terraform --location=<region>`

* Create encryption key for the state file with:

```
 openssl rand -base64 32 | tr -d '\n' | \
 gcloud kms encrypt \
   --project <project_id>  --location <region> --keyring <keyring> --key <key>  \
   --plaintext-file - --ciphertext-file - | \
 base64 | tr -d '\r\n'
```
