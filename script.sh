#!/bin/bash

pods_status=$(kubectl  get pods -n default -o custom-columns=POD:metadata.name,PODIP:status.podIP,READY-true:status.containerStatuses[*].ready | grep -i nfs | grep true)


if [ -z "$pods_status" ]; then
  echo "Some of the ebs-csi pods are not fully up and running with all the containers. Pls fix the issue and rerun the script"
  exit 1
else                                                                                                                                                                                                         
  echo "All the ebs-csi pods are running with no issues."

fi
echo "$(kubectl get pod  $(kubectl get pods -n default  | grep -i nfs | awk 'FNR==1{print $1}') -o jsonpath='{range .spec.containers[*]}{.name}{"\t"}{.image}{"\n"}{end}')"
