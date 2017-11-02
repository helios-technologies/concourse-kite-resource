# concourse-kite-resource

## Specs

Resources config example:

```yaml
resource_types:
  - name: kite
    type: docker-image
      source:
        repository: heliostech/concourse-kite-resource

resources:
  - name: deploy
    type: kite
    source:
      # don't know what should we use here on AWS
      json_key: ((gcp_service_account_key))

      # path in repo's root
      config_path: '.kite'

      # next we can have different ways to do what we need

      # shell command
      #
      # examples:
      #   $ helm install .kite/charts/%chart_name%/
      #   $ kubectl apply -f path/to/k8s/files
      command: 'make deploy'

      # path to ruby script (maybe it can accept URLs)
      script_path: '.kite/bin/release-base-image.rb'

      # or inline script (not sure if we really need this)
      script:
        # gems to install and require before executing
        # we can require them with `-r`:
        #   $ ruby -rgoogle-cloud script.rb
        dependencies:
          - gem: google-cloud
            require: 'google/cloud/storage'
          - gem: vault
            version: 0.1.0
        source: |
          storage = Google::Cloud::Storage.new
          vault_client = Vault::Client.new(address: 'https://vault.mycompany.com')

          bucket = storage.bucket 'my-app'
          bucket.create_file(
            vault_client.logical.read('secret/something'),
            'something.txt'
          )
```
