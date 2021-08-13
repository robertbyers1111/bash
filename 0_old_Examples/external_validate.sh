#!/bin/sh -xv
###########################################################################
# external_validate.sh
#
# This script will launch the Optivity validate database process
# from a shell not spawned by Open View or Net View. This is done
# by emulating the key environment variables required by the API.
#
# NOTE: This script is UNSUPPORTED, and is supplied AS IS.
#
# Questions and/or comments should be directed to byersr@nortelnetworks.com
#
###########################################################################

Die_If_Unset()
{
  NAME=$1
  VAL=`eval echo $"$1"`

  if [ -z "$VAL" ]; then
	echo "\nERROR: $NAME is not set\n"
	exit 1
  fi
}

###########################################################################

Die_If_Unset LNMSHOME
Die_If_Unset OV_BIN

OVwAppName=Optivity	; export OVwAppName
OVwSessionID=barqs:0.0	; export OVwSessionID

${LNMSHOME}/bin/validateOptivityDb <<EOF
y
EOF
