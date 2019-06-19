{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "tarantool.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Expand the chart plus release name (used by the chart label)
*/}}
{{- define "tarantool.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "tarantool.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "tarantool.repl" -}}
{{- $local := dict "first" true -}}
{{- $count_local := .Values.replicaCount | int -}}
{{- range $k, $v := until $count_local -}}
{{- if not $local.first -}},{{- end -}}
{{ template "tarantool.fullname" $ }}-{{- $v -}}.{{ template "tarantool.fullname" $ }}.{{ $.Release.Namespace }}.svc.cluster.local{{- $_ := set $local "first" false -}}
{{- end -}}
{{- end -}}
