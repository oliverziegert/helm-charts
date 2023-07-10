{{/*
Expand the name of the chart.
*/}}
{{- define "uptime-kuma.uptimeKuma.name" -}}
{{- default .Chart.Name .Values.uptimeKuma.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "uptime-kuma.uptimeKuma.fullname" -}}
{{- if .Values.uptimeKuma.fullnameOverride }}
{{- .Values.uptimeKuma.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.uptimeKuma.nameOverride }}
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
{{- define "uptime-kuma.uptimeKuma.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "uptime-kuma.uptimeKuma.labels" -}}
helm.sh/chart: {{ include "uptime-kuma.uptimeKuma.chart" . }}
{{ include "uptime-kuma.uptimeKuma.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "uptime-kuma.uptimeKuma.selectorLabels" -}}
app.kubernetes.io/name: {{ include "uptime-kuma.uptimeKuma.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "uptime-kuma.uptimeKuma.serviceAccountName" -}}
{{- if .Values.uptimeKuma.serviceAccount.create }}
{{- default (include "uptime-kuma.uptimeKuma.fullname" .) .Values.uptimeKuma.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.uptimeKuma.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Returns the proper Storage Class
*/}}
{{- define "uptime-kuma.uptimeKuma.storageClass" -}}
{{- $storageClass := .Values.uptimeKuma.persistence.storageClass -}}
{{- if $storageClass -}}
  {{- if (eq "-" $storageClass) -}}
      {{- printf "storageClassName: \"\"" -}}
  {{- else }}
      {{- printf "storageClassName: %s" $storageClass -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Returns the proper Storage Claim name
*/}}
{{- define "uptime-kuma.uptimeKuma.persistentVolumeClaim" -}}
{{- if (eq "" .Values.uptimeKuma.persistence.existingClaim) -}}
  {{- printf (include "uptime-kuma.uptimeKuma.fullname" .) -}}
{{- else }}
  {{- printf .Values.uptimeKuma.persistence.existingClaim -}}
{{- end -}}
{{- end -}}