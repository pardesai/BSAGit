#!/bin/nsh
blcli_setoption serviceProfileName 87P2-Linux
blcli_setoption roleName BLAdmins
blcli_connect
blcli_execute ServerConfigDef findAll
blcli_execute Utility storeTargetObject cfos
blcli_execute Utility listLength
blcli_storeenv listLength
for i in {1..$((${listLength}-1))}
     do
     blcli_execute Utility setTargetObject cfos
     blcli_execute Utility listItemSelect ${i}
     blcli_execute Utility setTargetObject
     blcli_execute ServerConfigDef getName
     blcli_storeenv cfoName
     echo ${cfoName} >> out1.csv
blcli_execute Template getDBKeyByGroupAndName "$1" "$2"
blcli_storeenv KEY
blcli_execute Template addConfigurationObjectPart $KEY "$cfoName" "Configuration File" "Name,Path" "" "" ""
done
