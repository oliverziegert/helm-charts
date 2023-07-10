{{/*
Expand the name of the chart.
*/}}
{{- define "uptime-kuma.signal.name" -}}
{{- printf "signal-%s" (default .Chart.Name .Values.signal.nameOverride | trunc 63 | trimSuffix "-") }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "uptime-kuma.signal.fullname" -}}
{{- if .Values.signal.fullnameOverride }}
{{- .Values.signal.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.signal.nameOverride }}
{{- if contains $name .Release.Name }}
{{- printf "signal-%s" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-signal-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "uptime-kuma.signal.chart" -}}
{{- printf "%s-signal-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "uptime-kuma.signal.labels" -}}
helm.sh/chart: {{ include "uptime-kuma.signal.chart" . }}
{{ include "uptime-kuma.signal.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "uptime-kuma.signal.selectorLabels" -}}
app.kubernetes.io/name: {{ include "uptime-kuma.signal.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "uptime-kuma.signal.serviceAccountName" -}}
{{- if .Values.signal.serviceAccount.create }}
{{- default (include "uptime-kuma.signal.fullname" .) .Values.signal.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.signal.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Returns the proper Storage Class
*/}}
{{- define "uptime-kuma.signal.storageClass" -}}
{{- $storageClass := .Values.signal.persistence.storageClass -}}
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
{{- define "uptime-kuma.signal.persistentVolumeClaim" -}}
{{- if (eq "" .Values.signal.persistence.existingClaim) -}}
  {{- printf (include "uptime-kuma.signal.fullname" .) -}}
{{- else }}
  {{- printf .Values.signal.persistence.existingClaim -}}
{{- end -}}
{{- end -}}