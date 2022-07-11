# Build 

# Setup Ko
Download Ko TODO LINK
set the `KO_DOCKER_REPO` env var to point to your registry (or use dockerhub username)

# Build Layer

## Ko for image and sbom (Golang only)
build OCI image and push it to your set docker registry using Ko
run `ko build --image-refs image.txt .`

## Docker Build && Sigstore approach
from project root Github Actions produces SLSA lvl3 provenance
^^ The above also produces golang executable

docker build taking project executable/files as input (this way those things are documented in SBOM)
continue with signing steps

## Signing
generate some keys `cosign generate-key-pair` and follow prompts
sign the image with `cosign sign $(cat image.txt) --key cosign.key`
verify image before pulling SBOM by running `cosign verify $(cat image.txt) --key cosign.pub`
retrieve SBOM with `cosign download sbom $(cat image.txt) > sbom.yaml`






