#!/bin/bash

#Change to the cloned repo path of the chart
helm_chart_path="charts/harness"
#File to store the image list
images_file="harness-images.yaml"
#Private repository url
repository="nikpnexus.co.uk:7777/repository/harness/"


#Helm template to extract all the images used in the chart
helm template $helm_chart_path | grep "image:" | tr -d "[:blank:]" | sed 's/image://g' > $images_file

#Parse images file
#Pull images from public repos
#Tag image according to your private repo
#Push image to the registry
#Missing the authentication to the private registry

while IFS= read -r line
do
  echo "$line"
  docker pull "$line"
  image=$(echo $line |sed 's/docker.io\///g' | sed 's/harness\///g' | sed 's/curl\///g'| sed 's/bitnami\///g' | sed 's/timescale\///g' )
  docker tag $line "$repository$image"
  docker push "$repository$image"
done < "$images_file"
