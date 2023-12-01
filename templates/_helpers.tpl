{{/*
Expand the name of the chart.
*/}}
{{- define "bci-services-provider.name" -}}
{{- default .Chart.Name .Values.service.metadata.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bci-services-provider.fullname" -}}
{{- if .Values.service.metadata.name }}
{{- .Values.service.metadata.name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bci-services-provider.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bci-services-provider.labels" -}}
helm.sh/chart: {{ include "bci-services-provider.chart" . }}
{{ include "bci-services-provider.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bci-services-provider.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bci-services-provider.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "bci-services-provider.serviceAccountName" -}}
{{- if .Values.service.spec.security.serviceAccount.create }}
{{- default (include "bci-services-provider.fullname" .) "" }}
{{- else }}
{{- default "default" (include "bci-services-provider.fullname" .) }}
{{- end }}
{{- end }}
