#!/bin/bash

#Script Name: PCRF_JSON_conv_script_ZM_v1.11.sh
#Author: Yeamin Rajeev (yeamin.rajeev@gmail.com)
#Version: 1.11
#Last Modified: 23 August 2012
#Description: This Bash/Awk script reads lines from an input text file containing space separated data about telco 
#             subscribers having data bundles. Then the script converts the necessary data into an LDAP-JSON structured 
#             file to insert the data into PCRF SAPC over LDAP interface. 
#Dependencies: Please check the readme.txt file for details.

filename=$1

cat `echo $filename` | awk  '{ if ( $4 == "50MB" ) { $4 = "50MB_Bundle_Normal"; $11="30 days";} \
else if ( $4 == "100MB" ) {$4 = "100MB_Bundle_Normal"; $11="30 days";} \
else if ( $4 == "5MB _DAILYDEALS" ) {$4 = "10MB_Bundle_Normal"; $11="30 days";} \
else if ( $4 == "10MB" ) { $4 = "10MB_Bundle_Normal"; $11="30 days";}
else if ( $4 == "25MB" ) { $4 = "25MB_Bundle_Normal"; $11="30 days";}
else if ( $4 == "250MB" ) { $4 = "250MB_Bundle_Normal"; $11="30 days";}
else if ( $4 == "500MB" ) { $4 = "500MB_Bundle_Normal"; $11="30 days";} \
else if ( $4 == "1GB" ) {$4 = "1GB_Bundle_Normal"; $11="30 days";} \
else if ( $4 == "1.5GB" ) {$4 = "1.5GB_Bundle_Normal"; $11="30 days";} \
else if ( $4 == "2GB" ) {$4 = "2GB_Bundle_Normal"; $11="60 days";} \
else if ( $4 == "2GB_R" ) {$4 = "2GB_Bundle_Normal"; $11="60 days";} \
else if ( $4 == "4GB" ) {$4 = "4GB_Bundle_Normal"; $11="60 days";} \
else if ( $4 == "6GB" ) {$4 = "6GB_Bundle_Normal"; $11="60 days";} \
else if ( $4 == "6GB_R" ) {$4 = "6GB_Bundle_Normal"; $11="60 days";} \
else if ( $4 == "10GB" ) {$4 = "10GB_Bundle_Normal"; $11="90 days";} \
else if ( $4 == "20GB" ) {$4 = "20GB_Bundle_Normal"; $11="90 days";} \
else if ( $4 == "20MB" ) { $4 = "20MB_Bundle_Normal"; $11="2 days";} \
else if ( $4 == "500MBPROMO" ) { $4 = "Handset_Hauwei_Android"; $11="300 days";} \
else if ( $4 == "2GBPROMO" ) { $4 = "Router_B970"; $11="120 days";} \
else if ( $4 == "1.5GBPROMO" ) { $4 = "Router_E173"; $11="30 days";} \
else if ( $4 == "300MB_STAFF" ) { $4 = "300MB_STAFF"; $11="30 days";} \
else if ( $4 == "1GB_STAFF" ) { $4 = "1GB_STAFF"; $11="30 days";} \
else if ( $4 == "2GB_STAFF" ) { $4 = "2GB_STAFF"; $11="30 days";} \
else if ( $4 == "6GB_STAFF" ) { $4 = "6GB_STAFF"; $11="30 days";} \
else if ( $4 == "DUP" ) { $4 = "Unlimited_Daily_Plan"; $11="1 days";} \
else if ( $4 == "WUP" ) { $4 = "Unlimited_Weekly_Plan"; $11="7 days";} \
else if ( $4 == "MUP" ) { $4 = "Unlimited_Monthly_Plan"; $11="30 days";} else {$4="Default_PAYG";$11="999 days"}   printf \
("dn: EPC-SubscriberId="$1",EPC-SubscribersName=EPC-Subscribers,applicationName=EPC-EpcNode,nodeName=jambala\n" \
"objectClass: EPC-Subscriber\n" \
"ownerId: 0\n" \
"groupId: 4003\n" \
"shareTree: nodeName=jambala\n" \
"permissions: 15\n" \
"EPC-SubscriberId: "$1"\n" \
"EPC-GroupIds: Default_PAYG:30\n" \
"EPC-GroupIds: "$4":10:"$2"T00:00:00,"$3"T00:00:00\n\n" \
"dn: EPC-LimitName=EPC-LimitUsage,EPC-SubscriberId="$1",EPC-SubscribersName=EPC-Subscribers,applicationName=EPC-EpcNode,nodeName=jambala\n" \
"objectClass: EPC-UsageControlLimit\n" \
"EPC-Data: {\"reportingGroups\":[{ \"name\" : \"1000\",\"description\" : \"any\", \"subscriptionType\" : \"prepaid\", \"sliceVolume\" : 1024, \"absoluteLimits\" : {\"resetPeriod\": {\"volume\":\""$11"\"}, \"conditionalLimits\" :[ {\"name\":\"Home\", \"bidirVolume\" : [0,"$10","$9"]}]}, \"subscriptionDate\":\""$2"\"}]}\n" \
"EPC-LimitName: EPC-LimitUsage\n" \
"groupId: 4003\n" \
"ownerId: 0\n" \
"permissions: 15\n" \
"shareTree: nodeName=jambala\n\n");}'
