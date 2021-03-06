#!/bin/bash
#Copyright (C) 2007 Paul Sharrad

#This file is part of Karoshi Server.
#
#Karoshi Server is free software: you can redistribute it and/or modify
#it under the terms of the GNU Affero General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#Karoshi Server is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU Affero General Public License for more details.
#
#You should have received a copy of the GNU Affero General Public License
#along with Karoshi Server.  If not, see <http://www.gnu.org/licenses/>.

#
#The Karoshi Team can be contacted at: 
#mpsharrad@karoshi.org.uk
#jsharrad@karoshi.org.uk

#
#Website: http://www.karoshi.org.uk
############################
#Language
############################

STYLESHEET=defaultstyle.css
TIMEOUT=300
[ -f /opt/karoshi/web_controls/user_prefs/$REMOTE_USER ] && source /opt/karoshi/web_controls/user_prefs/$REMOTE_USER
TEXTDOMAIN=karoshi-server

############################
#Show page
############################
echo "Content-type: text/html"
echo ""
echo '<!DOCTYPE html><html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"><title>'$"Client Locations"'</title><meta http-equiv="REFRESH" content="'$TIMEOUT'; URL=/cgi-bin/admin/logout.cgi"><link rel="stylesheet" href="/css/'$STYLESHEET'?d='`date +%F`'"><script src="/all/stuHover.js" type="text/javascript"></script></head><body onLoad="start()"><div id="pagecontainer">'
#########################
#Get data input
#########################
TCPIP_ADDR=$REMOTE_ADDR
DATA=`cat | tr -cd 'A-Za-z0-9\._:\-'`

function show_status {
echo '<SCRIPT language="Javascript">'
echo 'alert("'$MESSAGE'")';
echo '                window.location = "/cgi-bin/admin/view_karoshi_web_admin_log.cgi";'
echo '</script>'
echo "</div></body></html>"
exit
}
#########################
#Check https access
#########################
if [ https_$HTTPS != https_on ]
then
	export MESSAGE=$"You must access this page via https."
	show_status
fi
#########################
#Check user accessing this script
#########################
if [ ! -f /opt/karoshi/web_controls/web_access_admin ] || [ $REMOTE_USER'null' = null ]
then
	MESSAGE=$"You must be a Karoshi Management User to complete this action."
	show_status
fi

if [ `grep -c ^$REMOTE_USER: /opt/karoshi/web_controls/web_access_admin` != 1 ]
then
	MESSAGE=$"You must be a Karoshi Management User to complete this action."
	show_status
fi

#Generate navigation bar
/opt/karoshi/web_controls/generate_navbar_admin

echo '<div id="actionbox3"><div id="titlebox"><table class="standard" style="text-align: left;" ><tbody>
<tr><td style="vertical-align: top;"><div class="sectiontitle">'$"Client Locations"'</div></td>
<td style="vertical-align: top;"><a class="info" target="_blank" href="http://www.linuxschools.com/karoshi/documentation/wiki/index.php?title=Add_Network_Printer"><img class="images" alt="" src="/images/help/info.png"><span>'$"Locations are used to assign printers."'</span></a></td>
<td style="vertical-align: top;"><form action="/cgi-bin/admin/printers.cgi" name="printers" method="post">
<input name="SHOWPRINTERS" type="submit" class="button" value="'$"Show Printers"'"></form></td>
</tr></tbody></table><br>
'

echo '<form action="/cgi-bin/admin/locations2.cgi" method="post"><table class="standard" style="text-align: left;" >'
echo '<tbody>'
echo '<tr><td style="width: 180px;">'$"New location"'</td><td><input name="_NEWLOCATION_" size="15" type="text"> </td><td><input value="Submit" type="submit" class="button"></td></tr>'
echo '</tbody></table></form><br></div><div id="infobox">'

if [ -f /var/lib/samba/netlogon/locations.txt ]
then
	LOCATION_COUNT=`cat /var/lib/samba/netlogon/locations.txt | wc -l`
else
	LOCATION_COUNT=0
fi
#Show current rooms
if [ $LOCATION_COUNT -gt 0 ]
then
	echo '<form action="/cgi-bin/admin/locations2.cgi" method="post"><table class="standard" style="text-align: left;" >
<tbody><tr><td style="width: 180px;"><b>Current Locations</b></td><td><b>Delete</b></td></tr></tbody></table><br>
<table class="standard" style="text-align: left;" >
<tbody>'
COUNTER=1
while [ $COUNTER -lt $LOCATION_COUNT ]
do
	LOCATION=`sed -n $COUNTER,$COUNTER'p' /var/lib/samba/netlogon/locations.txt`
	echo '<tr><td style="width: 180px;">'$LOCATION'</td><td>
	<button class="info" name="DoDelete_" value="_DELETE_'$LOCATION'_">
	<img src="/images/submenus/client/delete_location.png" alt="'$"Delete"' '$LOCATION'">
	<span>'$"Delete"' '$LOCATION'</span>
	</button>
	</td></tr>'
	let COUNTER=$COUNTER+1
done
echo '</tbody></table></form><br>'
fi
echo '</div></div></div></body></html>'
exit
