{{/*
Expand the name of the chart.
*/}}
{{- define "gravity-workflow.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "app.fullname" -}}
{{- .Values.instance -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels -> https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/
*/}}
{{- define "app.labels" -}}
helm.sh/chart: {{ include "app.chart" . }}
app.kubernetes.io/name: {{ include "app.fullname" . }}
app.kubernetes.io/platform: gravity
app.kubernetes.io/instance: {{ .Values.instance }} # mysql-abcxzy
{{- if .Values.project }}
gravity.invisibl.io/project: {{ .Values.project }}
{{- end }}
{{- if .Values.component }}
app.kubernetes.io/component: {{ .Values.component }} # database
{{- end }}
{{- if .Values.partOf }}
app.kubernetes.io/part-of: {{ .Values.partOf }} # wordpress
{{- end }}
{{- if .Values.createdBy }}
app.kubernetes.io/created-by: {{ .Values.createdBy }} # user name
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }} # helm
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gravity-workflow.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
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
{{- define "gravity-workflow.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gravity-workflow.labels" -}}
helm.sh/chart: {{ include "gravity-workflow.chart" . }}
{{ include "gravity-workflow.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "gravity-workflow.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gravity-workflow.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "gravity-workflow.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "gravity-workflow.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
