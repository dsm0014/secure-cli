# secure-cli
A very basic Golang cli tool utilizing Cobra. This repo is meant to showcase
a small example of a secure software supply chain.

# Build Process
## Docker Build && Sigstore approach
Github Actions produces SLSA lvl3 provenance

^^ The above also produces golang executable

docker build taking project executable/files as input (this way those things are documented in SBOM)


## Signing
generate some keys `cosign generate-key-pair` and follow prompts

sign the image with `cosign sign $(cat image.txt) --key cosign.key`

verify image before pulling SBOM by running `cosign verify $(cat image.txt) --key cosign.pub`

retrieve SBOM with `cosign download sbom $(cat image.txt) > sbom.yaml`






