# Helm charts

These software listings are packaged by Sparkfabrik. The respective trademarks mentioned in the offerings are owned by the respective companies, and use of them does not imply any affiliation or endorsement. The software is licensed to you subject to one or more open source licenses and Sparkfabrik provides the software on an AS-IS basis.

## How to use it

You just need to add the public helm chart repository to your helm installation:

```shell
helm repo add sparkfabrik-charts https://charts.sparkfabrik.cloud
```

To install a chart:

```shell
helm install blackfire-test sparkfabrik-charts/blackfire --wait --debug --namespace default -f tests/values.yaml
```

## Charts

- Unofficial Helm chart for [blackfire.io](./charts/blackfire/)
