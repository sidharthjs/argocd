{{/*
Expand the name of the chart.
*/}}
{{- define "app.fullname" -}}
{{- .Values.instance -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "app.absfullname" -}}
{{- .Values.project }}-{{ include "app.fullname" . }}
{{- end }}

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
