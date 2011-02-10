#!/usr/bin/haserl
<?
	# This program is copyright � 2008-2011 Eric Bishop and is distributed under the terms of the GNU GPL 
	# version 2.0 with a special clarification/exception that permits adapting the program to 
	# configure proprietary "back end" software provided that all modifications to the web interface
	# itself remain covered by the GPL. 
	# See http://gargoyle-router.com/faq.html#qfoss for more information
	eval $( gargoyle_session_validator -c "$COOKIE_hash" -e "$COOKIE_exp" -a "$HTTP_USER_AGENT" -i "$REMOTE_ADDR" -r "login.sh" -t $(uci get gargoyle.global.session_timeout) -b "$COOKIE_browser_time"  )
	gargoyle_header_footer -h -s "status" -p "wol" -c "internal.css" -j "wol.js table.js" -i -n dhcp wireless
?>

<script>
<!--
var dhcpLeaseLines;
var wifiLines;
var wirelessDriver;
var conntrackLines;
var arpLines;
<?
	sh /usr/lib/gargoyle/define_host_vars.sh
	echo "var etherData = new Array();";
	if [ -e /etc/ethers ] ; then
		cat /etc/ethers | awk ' $0 ~ /^[\t ]*[0-9abcdefABCDEF]/ {print "etherData.push([\""$1"\",\""$2"\"]);"};'
	fi
	wan_ip=$(uci -p /tmp/state get network.wan.ipaddr 2>/dev/null)
	lan_ip=$(uci -p /tmp/state get network.lan.ipaddr 2>/dev/null)
	echo "currentWanIp=\"$wan_ip\";"
	echo "currentLanIp=\"$lan_ip\";"
	echo "var bcastIp=\"$(ifconfig | awk '/^br-lan/{s=$1;getline;print $3}' | cut -b7-)\";"
?>
//-->
</script>

<fieldset id="wol_data">
	<legend class="sectionHeader">Wake on LAN</legend>
	<div id="wol_table_container"></div>
</fieldset>


<script>
<!--
	initWolTable();
//-->
</script>

<?
	gargoyle_header_footer -f -s "connection" -p "wol"
?>