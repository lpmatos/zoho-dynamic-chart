{{/* 
Selector labels zoho. 
*/}}
{{- define "zoho.selectorLabels" -}}
app.kubernetes.io/name: {{ include "zoho.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* 
Common labels zoho. 
*/}}
{{- define "zoho.labels" -}}
helm.sh/chart: {{ include "zoho.chart" . }}
{{ include "zoho.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* 
Return zoho email user. 
*/}}
{{- define "zoho.email.user" -}}
{{- if .Values.zoho.email.user -}}
  {{- .Values.zoho.email.user -}}
{{- else -}}
  {{- required "We need Zoho User email" .Values.zoho.email.user -}}
{{- end -}}
{{- end -}}

{{/*
 Return zoho email dbowner.
*/}}
{{- define "zoho.email.dbowner" -}}
{{- if .Values.zoho.email.dbowner -}}
  {{- .Values.zoho.email.dbowner -}}
{{- else -}}
  {{- required "We need Zoho DBowner email" .Values.zoho.email.dbowner -}}
{{- end -}}
{{- end -}}

{{/*
Return zoho token.
*/}}
{{- define "zoho.token" -}}
{{- if .Values.zoho.token -}}
  {{- .Values.zoho.token | b64enc | quote -}}
{{- else }}
  {{- required "We need zoho auth token" .Values.zoho.token -}}
{{- end -}}
{{- end -}}
