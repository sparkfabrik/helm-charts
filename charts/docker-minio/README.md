# docker-minio

![Version: 0.5.0](https://img.shields.io/badge/Version-0.5.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

A Helm chart for deploying SparkFabrik Docker-MinIO application on Kubernetes.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.registry | string | `"ghcr.io"` | The image registry (e.g. docker.io, quay.io, ghcr.io). |
| image.repository | string | `"sparkfabrik/docker-minio"` | The image repository. |
| image.fullRepositoryImage | string | `""` | The image repository full url (e.g. docker.io/namespace/image, quay.io/namespace/image, ghcr.io/namespace/image) and repository together as single string. If set, it takes precedence over registry and repository. |
| image.tag | string | `""` | The image tag. If not defined, the appVersion will be used. |
| image.pullPolicy | string | `"IfNotPresent"` | The image pull policy. |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| env | object | `{}` | The environment variables to pass to the MinIO container. |
| envFrom | string | `nil` | The environment variables to pass to the MinIO container using the envFrom configuration. You can use this to load environment variables from a ConfigMap or a Secret. |
| console.enabled | bool | `false` | Enable the MinIO console. |
| console.port | int | `9001` | The port on which the console will be available. |
| console.ingress.enabled | bool | `false` | Enable the console Ingress. ATTENTION: this will create an Ingress resource dedicated to the console, so the console will be available from outside the cluster. |
| console.ingress.className | string | `""` | The Ingress class to use. |
| console.ingress.annotations | object | `{}` | The annotations to add to the console Ingress. |
| console.ingress.hosts | list | `[{"host":"console.chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]` | The hosts to use for the console Ingress. |
| console.ingress.tls | list | `[]` | The TLS configuration to use for the console Ingress. |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created. |
| serviceAccount.automount | bool | `true` | Specifies if automatically mount a ServiceAccount's API credentials. |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account. |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template. |
| podAnnotations | object | `{}` | The annotations to add to the MinIO pod. |
| podLabels | object | `{}` | The labels to add to the MinIO pod. |
| podSecurityContext | object | `{}` | The security context to add to the MinIO pod. |
| securityContext | object | `{}` | The security context to add to the MinIO container. |
| service.type | string | `"ClusterIP"` | The type of MinIO service to create. This is the service for the S3 API. |
| service.port | int | `9000` | The port on which the service will be available. This is the service for the S3 API. |
| ingress.enabled | bool | `false` | Enable the Ingress for the MinIO service. |
| ingress.className | string | `""` | The Ingress class to use. |
| ingress.annotations | object | `{}` | The annotations to add to the Ingress. |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]` | The hosts to use for the Ingress. |
| ingress.tls | list | `[]` | The TLS configuration to use for the Ingress. |
| resources.requests.memory | string | `"128Mi"` | The amount of memory that the MinIO container will need. |
| resources.requests.cpu | string | `"50m"` | The amount of CPU that the MinIO container will need. |
| livenessProbe.httpGet.path | string | `"/minio/health/live"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| readinessProbe.httpGet.path | string | `"/minio/health/live"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| persistence.enabled | bool | `false` | Enable persistence using Persistent Volume Claims. |
| persistence.mountPath | string | `"/data"` | The path where the volume will be mounted. ATTENTION: this path must be the same as the one used to store the data in the MinIO container. The `BUCKET_ROOT` environment variable will automatically be set to this path. |
| persistence.size | string | `"1Gi"` | The size of the Persistent Volume to request. |
| persistence.storageClass | string | `""` | The storage class to use for the Persistent Volume. If not set, the default storage class will be used. |
| persistence.accessMode | string | `"ReadWriteOnce"` | The access mode of the Persistent Volume. |
| persistence.annotations | object | `{}` | The annotations to add to the Persistent Volume Claim. |
| persistence.labels | object | `{}` | The labels to use for the Persistent Volume Claim. |
| volumes | list | `[]` | Additional volumes on the output Deployment definition. |
| volumeMounts | list | `[]` | Additional volumeMounts on the output Deployment definition. |
| nodeSelector | object | `{}` | Node selector for MinIO pod assignment. |
| tolerations | list | `[]` | Tolerations for MinIO pod assignment. |
| affinity | object | `{}` | Affinity for MinIO pod assignment. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
