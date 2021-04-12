#!/bin/bash

# Metadata allows your plugin to show up in the app, and website.
#
#  <xbar.title>GCP Project Switcher</xbar.title>
#  <xbar.version>v1.0</xbar.version>
#  <xbar.author>Daniel Palma</xbar.author>
#  <xbar.author.github>danthelion</xbar.author.github>
#  <xbar.desc>See current active GCP project and easily switch between others.</xbar.desc>

# Edit this if gcloud was not installed via brew
gcloud_executable="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/gcloud"


active_project=$(${gcloud_executable} config get-value project)

echo "$active_project"
echo "---"

project_id_array=($(${gcloud_executable} projects list --format="value(name)" | awk '{print $1}'))
for i in "${!project_id_array[@]}"; do 
    if [[ "${project_id_array[$i]}" == "$active_project" ]] ;then
        printf ":white_check_mark: "
    fi
    echo "${project_id_array[$i]}"
    echo "-- activate | shell=${gcloud_executable} param1=config param2=set param3=project param4=${project_id_array[$i]} | refresh=true"
done

