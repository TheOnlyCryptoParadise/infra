{{/*
Expand the name of the chart.
*/}}
{{- define "cryptoparadise.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cryptoparadise.fullname" -}}
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
{{- define "cryptoparadise.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cryptoparadise.labels" -}}
helm.sh/chart: {{ include "cryptoparadise.chart" . }}
{{ include "cryptoparadise.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cryptoparadise.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cryptoparadise.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cryptoparadise.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cryptoparadise.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{- define "aws_envs" -}}
- name: AWS_ACCESS_KEY_ID
  value: {{ .Values.aws.AWS_ACCESS_KEY_ID }}
- name: AWS_SECRET_ACCESS_KEY
  value: {{ .Values.aws.AWS_SECRET_ACCESS_KEY }}
- name: AWS_DEFAULT_REGION
  value: {{ .Values.aws.AWS_DEFAULT_REGION }}
{{- end }}

{{- define "sql_db_conn_info" -}}
- name: MARIADB_HOST
  value: {{ .Values.sql_db.service_name }}
- name: MARIADB_PORT
  value: {{ .Values.sql_db.port | quote }}
- name: MARIADB_USER
  value: {{ .Values.sql_db.user }}
- name: MARIADB_PASSWORD
  value: test
{{- end }}

{{- define "containers_spec_common" -}}
imagePullPolicy: Always
resources:
  requests:
    memory: "256Mi"
    cpu: "250m"
  limits:
    memory: "2048Mi"
    cpu: 2
{{- end -}}