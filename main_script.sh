#!/bin/bash

#Name of the Script: main_script.sh
#Author: Yeamin Rajeev (yeamin.rajeev@gmail.com)
#Version: 1.0
#Last Modified: 23 Nov 2017
#Description: This script runs the ldap-json conversion script PCRF_LDAP_JSON_conv_script_ZM_v1.11.sh and then writes the output of the LDAP-JSON structure into batchfile.ldif.
#             Then this script fires the ldapadd command to insert subscriber and LimitUsage data from the batchfile.ldif into SAPC PCRF database.


./PCRF_LDAP_JSON_conv_script_ZM_v1.11.sh INPUT.TXT > batchfile.ldif

echo "Converting to LDAP-JSON...."
wait ${!}

ldapadd -x -c -h platform-vip -p 7323 -D "administratorName=jambala, nodeName=jambala" -w Pokemon1 -f batchfile.ldif

echo "Inserting LDAP-JSON data into PCRF via LDAP interface completed !!! "
