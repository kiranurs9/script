apiVersion: v1
data:
  script.sh: |-
    echo "Hello world!"
    kubectl get pods
kind: ConfigMap
metadata:
  name: script-configmap
  namespace: default
---
apiVersion: batch/v1
kind: Job
metadata:
  labels:
    app: script-job
  name: script-job
  namespace: default
spec:
  backoffLimit: 2
  template:
    spec:
      containers:
        - command:
            - sh
            - /opt/script/script.sh
          image: 'bitnami/kubectl:1.12'
          name: script
          volumeMounts:
            - mountPath: /opt/script
              name: script-configmap
              readOnly: false
      restartPolicy: Never
      serviceAccountName: test
      volumes:
        - configMap:
            name: script-configmap
          name: script-configmap
