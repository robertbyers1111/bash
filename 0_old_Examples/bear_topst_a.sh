#!/bin/sh

################################################################
# bear_topst_a.sh
#
# Script to query selected ATM and autotopology MIBs of various
# C-100 devices. For use only by Bear Stearns Network Management
# personnel.
#
#
#
# SYNTAX:
#
#	bear_topst_a.sh [-f] [RDCOMM]
#
#	-f	(optional) Full query - queries about 220 devices.
#		Otherwise, performs an abreviated query of the
#		following 12 devices:
#
#		 	147.107.142.140
#			147.107.142.141
#			147.107.142.142
#			147.107.142.143
#			147.107.142.187
#			147.107.142.190
#			147.107.142.191
#			147.107.142.192
#			147.107.142.193
#			147.107.142.194
#			147.107.142.216
#			147.107.142.217
#
#	RDCOMM	(optional) Read-only community string. Default is "public".
#
#
#
# Direct questions and/or comments to byersr@nortelnetworks.com
#
###########################################################################

#NOTE: Output goes to /tmp/bear_topst_a.log.YYMMDD_HHMMSS

	LOG=/tmp/bear_topst_a.log.`date +%y%m%d_%H%M%S`

#Set defaults for optional command line arguments

	FULLQUERY=0
	RDCOMMSTR=public

###################################
Die_If_Unset()
{
  NAME=$1
  VAL=`eval echo $"$1"`

  if [ "$VAL" = "" ]; then
	echo "\nERROR: $NAME is not set\n"
	exit 1
  fi
}

###################################
DEVNOTE ()
{
 echo "\nStarting MIB queries on $*"
 echo "\n================================================" >> $LOG
 echo "Starting MIB queries on $* at `date` \n" >> $LOG
}

###################################
LOGNOTE ()
{
 echo \	$*
 echo "\n==:$* for $DEVICE started `date` \n" >> $LOG
}

###################################
#Query is called once per device
Query()
{
 DEVICE=$1
 RDCOMM=$2

 DEVNOTE $DEVICE


 #Send a test ping - if it fails, device is unreachable
 PINGOUT=6
 if ping $DEVICE $PINGOUT > /dev/null ; then
  :
 else
  echo "\n	Warning: ping timeout ($PINGOUT seconds) for $DEVICE!" | tee -a $LOG
  return 1
 fi


 #Get sysDescr - if it fails, probably a wrong comm string
 if SYSDESCR=`$NMAN -c $RDCOMM -a 1.3.6.1.2.1.1.1 $DEVICE` ; then
  :
 else
  echo "\n	Warning: Possible incorrect comm string ($RDCOMM) for $DEVICE" | tee -a $LOG
  return 1
 fi


 LOGNOTE sysDescr
 echo $SYSDESCR >> $LOG 2>&1

 LOGNOTE bnetAtmTopGbl
 $NMAN -c $RDCOMM -a 1.3.6.1.4.1.45.1.6.14.1 $DEVICE >> $LOG 2>&1

 LOGNOTE bnetAtmTopLinksEntry
 $NMAN -c $RDCOMM -a 1.3.6.1.4.1.45.1.6.14.2.1.1 $DEVICE >> $LOG 2>&1

 LOGNOTE s5EnMsTopInfo
 $NMAN -c $RDCOMM -a 1.3.6.1.4.1.45.1.6.13.1 $DEVICE >> $LOG 2>&1

 LOGNOTE s5EnMsTopNmmEntry
 $NMAN -c $RDCOMM -a 1.3.6.1.4.1.45.1.6.13.2.1.1 $DEVICE >> $LOG 2>&1

 LOGNOTE s5CmSNodeEntry
 $NMAN -c $RDCOMM -a 1.3.6.1.4.1.45.1.6.5.1.1.1 $DEVICE >> $LOG 2>&1

 LOGNOTE atmElanConfigEntry
 $NMAN -c $RDCOMM -a 1.3.6.1.4.1.930.2.2.1.1.1.1 $DEVICE >> $LOG 2>&1

 LOGNOTE atmPortConfigEntry
 $NMAN -c $RDCOMM -a 1.3.6.1.4.1.930.2.2.1.3.1.1 $DEVICE >> $LOG 2>&1
}

###################################
#Main script starts here

. /usr/lnms/bin/opt_kshrc
. /usr/lnms/bin/opt_ovvars.sh

Die_If_Unset LNMSHOME
Die_If_Unset OV_BIN

touch $LOG

NMAN=/usr/lnms/unsupported/nman.`uname`

#Make sure nman is executable
if [ ! -x $NMAN ]; then
	echo ""
        echo ERROR: $NMAN either does not exist or is not executable
	echo \	If it exists, try chmod 755 $NMAN
	echo ""
	exit 1
fi

#Process command line
if [ $# -gt 0 ]; then
   COUNT=0
   while [ $# -gt 0 ]
   do
        COUNT=`expr $COUNT + 1`
	if [ $1 = "-f" ]; then
		FULLQUERY=1
	else
		RDCOMMSTR=$1
	fi
        shift
   done
fi


##############################################################
# Here are the MIB queries.
#
#	NOTE: 2nd parameter is the READ-ONLY Community String
#	(default is "public"). Override default from command
#	line (see syntax description at top of this script)

 Query 147.107.142.140	$RDCOMMSTR
 Query 147.107.142.141	$RDCOMMSTR
 Query 147.107.142.142	$RDCOMMSTR
 Query 147.107.142.143	$RDCOMMSTR
 Query 147.107.142.187	$RDCOMMSTR
 Query 147.107.142.190	$RDCOMMSTR
 Query 147.107.142.191	$RDCOMMSTR
 Query 147.107.142.192	$RDCOMMSTR
 Query 147.107.142.193	$RDCOMMSTR
 Query 147.107.142.194	$RDCOMMSTR
 Query 147.107.142.216	$RDCOMMSTR
 Query 147.107.142.217	$RDCOMMSTR

#The remaining devices are only queried if "-f" was specified

if [ $FULLQUERY = "1" ]; then
    Query 147.107.142.218 $RDCOMMSTR
    Query 147.107.142.219 $RDCOMMSTR
    Query 147.107.142.52 $RDCOMMSTR
    Query 147.107.142.53 $RDCOMMSTR
    Query 147.107.142.56 $RDCOMMSTR
    Query 147.107.142.57 $RDCOMMSTR
    Query 147.107.142.58 $RDCOMMSTR
    Query 147.107.142.59 $RDCOMMSTR
    Query 147.107.246.100 $RDCOMMSTR
    Query 147.107.246.101 $RDCOMMSTR
    Query 147.107.246.102 $RDCOMMSTR
    Query 147.107.246.103 $RDCOMMSTR
    Query 147.107.246.107 $RDCOMMSTR
    Query 147.107.246.108 $RDCOMMSTR
    Query 147.107.246.109 $RDCOMMSTR
    Query 147.107.246.110 $RDCOMMSTR
    Query 147.107.246.114 $RDCOMMSTR
    Query 147.107.246.115 $RDCOMMSTR
    Query 147.107.246.119 $RDCOMMSTR
    Query 147.107.246.120 $RDCOMMSTR
    Query 147.107.246.124 $RDCOMMSTR
    Query 147.107.246.125 $RDCOMMSTR
    Query 147.107.246.126 $RDCOMMSTR
    Query 147.107.246.127 $RDCOMMSTR
    Query 147.107.246.129 $RDCOMMSTR
    Query 147.107.246.130 $RDCOMMSTR
    Query 147.107.246.133 $RDCOMMSTR
    Query 147.107.246.134 $RDCOMMSTR
    Query 147.107.246.143 $RDCOMMSTR
    Query 147.107.246.144 $RDCOMMSTR
    Query 147.107.246.145 $RDCOMMSTR
    Query 147.107.246.146 $RDCOMMSTR
    Query 147.107.246.147 $RDCOMMSTR
    Query 147.107.246.148 $RDCOMMSTR
    Query 147.107.246.149 $RDCOMMSTR
    Query 147.107.246.150 $RDCOMMSTR
    Query 147.107.246.50 $RDCOMMSTR
    Query 147.107.246.51 $RDCOMMSTR
    Query 147.107.246.52 $RDCOMMSTR
    Query 147.107.246.53 $RDCOMMSTR
    Query 147.107.246.56 $RDCOMMSTR
    Query 147.107.246.57 $RDCOMMSTR
    Query 147.107.246.58 $RDCOMMSTR
    Query 147.107.246.59 $RDCOMMSTR
    Query 147.107.246.60 $RDCOMMSTR
    Query 147.107.246.61 $RDCOMMSTR
    Query 147.107.88.1 $RDCOMMSTR
    Query 147.107.88.10 $RDCOMMSTR
    Query 147.107.88.100 $RDCOMMSTR
    Query 147.107.88.101 $RDCOMMSTR
    Query 147.107.88.102 $RDCOMMSTR
    Query 147.107.88.103 $RDCOMMSTR
    Query 147.107.88.104 $RDCOMMSTR
    Query 147.107.88.105 $RDCOMMSTR
    Query 147.107.88.106 $RDCOMMSTR
    Query 147.107.88.107 $RDCOMMSTR
    Query 147.107.88.108 $RDCOMMSTR
    Query 147.107.88.109 $RDCOMMSTR
    Query 147.107.88.11 $RDCOMMSTR
    Query 147.107.88.110 $RDCOMMSTR
    Query 147.107.88.111 $RDCOMMSTR
    Query 147.107.88.112 $RDCOMMSTR
    Query 147.107.88.113 $RDCOMMSTR
    Query 147.107.88.114 $RDCOMMSTR
    Query 147.107.88.115 $RDCOMMSTR
    Query 147.107.88.116 $RDCOMMSTR
    Query 147.107.88.117 $RDCOMMSTR
    Query 147.107.88.118 $RDCOMMSTR
    Query 147.107.88.119 $RDCOMMSTR
    Query 147.107.88.12 $RDCOMMSTR
    Query 147.107.88.120 $RDCOMMSTR
    Query 147.107.88.121 $RDCOMMSTR
    Query 147.107.88.122 $RDCOMMSTR
    Query 147.107.88.123 $RDCOMMSTR
    Query 147.107.88.125 $RDCOMMSTR
    Query 147.107.88.126 $RDCOMMSTR
    Query 147.107.88.127 $RDCOMMSTR
    Query 147.107.88.13 $RDCOMMSTR
    Query 147.107.88.130 $RDCOMMSTR
    Query 147.107.88.131 $RDCOMMSTR
    Query 147.107.88.132 $RDCOMMSTR
    Query 147.107.88.133 $RDCOMMSTR
    Query 147.107.88.134 $RDCOMMSTR
    Query 147.107.88.135 $RDCOMMSTR
    Query 147.107.88.136 $RDCOMMSTR
    Query 147.107.88.137 $RDCOMMSTR
    Query 147.107.88.138 $RDCOMMSTR
    Query 147.107.88.139 $RDCOMMSTR
    Query 147.107.88.14 $RDCOMMSTR
    Query 147.107.88.140 $RDCOMMSTR
    Query 147.107.88.141 $RDCOMMSTR
    Query 147.107.88.142 $RDCOMMSTR
    Query 147.107.88.143 $RDCOMMSTR
    Query 147.107.88.144 $RDCOMMSTR
    Query 147.107.88.145 $RDCOMMSTR
    Query 147.107.88.146 $RDCOMMSTR
    Query 147.107.88.147 $RDCOMMSTR
    Query 147.107.88.148 $RDCOMMSTR
    Query 147.107.88.149 $RDCOMMSTR
    Query 147.107.88.15 $RDCOMMSTR
    Query 147.107.88.150 $RDCOMMSTR
    Query 147.107.88.151 $RDCOMMSTR
    Query 147.107.88.152 $RDCOMMSTR
    Query 147.107.88.153 $RDCOMMSTR
    Query 147.107.88.154 $RDCOMMSTR
    Query 147.107.88.155 $RDCOMMSTR
    Query 147.107.88.156 $RDCOMMSTR
    Query 147.107.88.157 $RDCOMMSTR
    Query 147.107.88.158 $RDCOMMSTR
    Query 147.107.88.159 $RDCOMMSTR
    Query 147.107.88.16 $RDCOMMSTR
    Query 147.107.88.160 $RDCOMMSTR
    Query 147.107.88.161 $RDCOMMSTR
    Query 147.107.88.162 $RDCOMMSTR
    Query 147.107.88.163 $RDCOMMSTR
    Query 147.107.88.164 $RDCOMMSTR
    Query 147.107.88.165 $RDCOMMSTR
    Query 147.107.88.166 $RDCOMMSTR
    Query 147.107.88.167 $RDCOMMSTR
    Query 147.107.88.168 $RDCOMMSTR
    Query 147.107.88.169 $RDCOMMSTR
    Query 147.107.88.17 $RDCOMMSTR
    Query 147.107.88.170 $RDCOMMSTR
    Query 147.107.88.171 $RDCOMMSTR
    Query 147.107.88.172 $RDCOMMSTR
    Query 147.107.88.173 $RDCOMMSTR
    Query 147.107.88.174 $RDCOMMSTR
    Query 147.107.88.175 $RDCOMMSTR
    Query 147.107.88.176 $RDCOMMSTR
    Query 147.107.88.177 $RDCOMMSTR
    Query 147.107.88.178 $RDCOMMSTR
    Query 147.107.88.179 $RDCOMMSTR
    Query 147.107.88.18 $RDCOMMSTR
    Query 147.107.88.180 $RDCOMMSTR
    Query 147.107.88.181 $RDCOMMSTR
    Query 147.107.88.19 $RDCOMMSTR
    Query 147.107.88.2 $RDCOMMSTR
    Query 147.107.88.20 $RDCOMMSTR
    Query 147.107.88.21 $RDCOMMSTR
    Query 147.107.88.22 $RDCOMMSTR
    Query 147.107.88.23 $RDCOMMSTR
    Query 147.107.88.24 $RDCOMMSTR
    Query 147.107.88.25 $RDCOMMSTR
    Query 147.107.88.26 $RDCOMMSTR
    Query 147.107.88.27 $RDCOMMSTR
    Query 147.107.88.28 $RDCOMMSTR
    Query 147.107.88.29 $RDCOMMSTR
    Query 147.107.88.3 $RDCOMMSTR
    Query 147.107.88.30 $RDCOMMSTR
    Query 147.107.88.31 $RDCOMMSTR
    Query 147.107.88.32 $RDCOMMSTR
    Query 147.107.88.33 $RDCOMMSTR
    Query 147.107.88.34 $RDCOMMSTR
    Query 147.107.88.35 $RDCOMMSTR
    Query 147.107.88.36 $RDCOMMSTR
    Query 147.107.88.37 $RDCOMMSTR
    Query 147.107.88.38 $RDCOMMSTR
    Query 147.107.88.39 $RDCOMMSTR
    Query 147.107.88.4 $RDCOMMSTR
    Query 147.107.88.40 $RDCOMMSTR
    Query 147.107.88.41 $RDCOMMSTR
    Query 147.107.88.42 $RDCOMMSTR
    Query 147.107.88.43 $RDCOMMSTR
    Query 147.107.88.44 $RDCOMMSTR
    Query 147.107.88.45 $RDCOMMSTR
    Query 147.107.88.46 $RDCOMMSTR
    Query 147.107.88.47 $RDCOMMSTR
    Query 147.107.88.48 $RDCOMMSTR
    Query 147.107.88.49 $RDCOMMSTR
    Query 147.107.88.50 $RDCOMMSTR
    Query 147.107.88.51 $RDCOMMSTR
    Query 147.107.88.52 $RDCOMMSTR
    Query 147.107.88.53 $RDCOMMSTR
    Query 147.107.88.54 $RDCOMMSTR
    Query 147.107.88.55 $RDCOMMSTR
    Query 147.107.88.56 $RDCOMMSTR
    Query 147.107.88.57 $RDCOMMSTR
    Query 147.107.88.58 $RDCOMMSTR
    Query 147.107.88.59 $RDCOMMSTR
    Query 147.107.88.6 $RDCOMMSTR
    Query 147.107.88.60 $RDCOMMSTR
    Query 147.107.88.61 $RDCOMMSTR
    Query 147.107.88.62 $RDCOMMSTR
    Query 147.107.88.63 $RDCOMMSTR
    Query 147.107.88.64 $RDCOMMSTR
    Query 147.107.88.65 $RDCOMMSTR
    Query 147.107.88.66 $RDCOMMSTR
    Query 147.107.88.67 $RDCOMMSTR
    Query 147.107.88.68 $RDCOMMSTR
    Query 147.107.88.72 $RDCOMMSTR
    Query 147.107.88.73 $RDCOMMSTR
    Query 147.107.88.74 $RDCOMMSTR
    Query 147.107.88.75 $RDCOMMSTR
    Query 147.107.88.76 $RDCOMMSTR
    Query 147.107.88.77 $RDCOMMSTR
    Query 147.107.88.78 $RDCOMMSTR
    Query 147.107.88.79 $RDCOMMSTR
    Query 147.107.88.8 $RDCOMMSTR
    Query 147.107.88.80 $RDCOMMSTR
    Query 147.107.88.81 $RDCOMMSTR
    Query 147.107.88.82 $RDCOMMSTR
    Query 147.107.88.83 $RDCOMMSTR
    Query 147.107.88.84 $RDCOMMSTR
    Query 147.107.88.85 $RDCOMMSTR
    Query 147.107.88.86 $RDCOMMSTR
    Query 147.107.88.87 $RDCOMMSTR
    Query 147.107.88.88 $RDCOMMSTR
    Query 147.107.88.89 $RDCOMMSTR
    Query 147.107.88.9 $RDCOMMSTR
    Query 147.107.88.90 $RDCOMMSTR
    Query 147.107.88.91 $RDCOMMSTR
fi

#That is all
echo "\nFinished."
echo "\n====================================================\n"
echo "	Your output is in...\n\n		$LOG\n"
echo "	Please email this file to byersr@nortelnetworks.com, or"
echo "	ftp it to ftp-east.baynetworks.com(192.32.253.17):/incoming/Bear\n"
