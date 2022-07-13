# secure-cli
A very basic Golang cli tool utilizing Cobra. This repo is meant to showcase
a small example of a secure software supply chain.

# How the Build Process Works
Using the [slsa-github-generator](https://github.com/slsa-framework/slsa-github-generator) 
project's [Github Action for SLSA Level 3 provenance in Golang]((https://github.com/slsa-framework/slsa-github-generator/.github/workflows/builder_go_slsa3.yml@v1.1.1)) 
will produce a Golang binary and an SLSA Level 3 provenance document.
Both of these artifacts are uploaded to the Release which triggered the Github Action.`

Build the application docker image with the produced Golang binary and push the image to the target registry.

Sign the docker image with help from the 
[Sigstore cosign-installer Github Action](https://github.com/sigstore/cosign-installer).

Finally, generate an SBOM for the docker image in SPDX.json format and upload it to the 
Github Release Artifacts with [Anchore's github action](https://github.com/anchore/sbom-action).

# Verify SLSA Level 3 Provenance
To verify our SLSA provenance, you'll need to download the golang binary and 
corresponding`*.intoto.jsonl` files from the Github Release Actifacts page.

Install the [slsa-verifier](https://github.com/slsa-framework/slsa-verifier) cli tool.

Run the following command:
```
slsa-verifier \
  -artifact-path ./filepath/<golang-binary> \
  -provenance ./filepath/<provenance-file>.intoto.jsonl \
  -source github.com/dsm0014/secure-cli \
  -branch master \
  -tag <tag release i.e 'v0.1.2'>          
```

Successful SLSA verification will produce an output message similar to the following:
```
Verified signature against tlog entry index <index-number> at URL: https://rekor.sigstore.dev/api/v1/log/entries/<log-entry-hash>
Signing certificate information:
 {
        "caller": "dsm0014/secure-cli",
        "commit": "<commit-hash>",
        "job_workflow_ref": "/slsa-framework/slsa-github-generator/.github/workflows/builder_go_slsa3.yml@refs/tags/v1.1.1",
        "trigger": "push",
        "issuer": "https://token.actions.githubusercontent.com"
}
PASSED: Verified SLSA provenance
```


# Verify Signed Image
Prior to utilizing 
verify image before pulling SBOM by running `cosign verify <image-name:tag> --key cosign.pub`

retrieve an SBOM stored in an OCI registry with `cosign download sbom <image-name:tag> > sbom.yaml`






