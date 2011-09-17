#!/usr/bin/haserl
<?

	# Copyright (c) 2011 Eric Bishop and Cezary Jackiewicz <cezary@eko.one.pl>  
	# and is distributed under the terms of the GNU GPL 
	# version 2.0 with a special clarification/exception that permits adapting the program to 
	# configure proprietary "back end" software provided that all modifications to the web interface
	# itself remain covered by the GPL. 
	# See http://gargoyle-router.com/faq.html#qfoss for more information

	eval $( gargoyle_session_validator -c "$COOKIE_hash" -e "$COOKIE_exp" -a "$HTTP_USER_AGENT" -i "$REMOTE_ADDR" -r "login.sh" -t $(uci get gargoyle.global.session_timeout) -b "$COOKIE_browser_time"  )
	gargoyle_header_footer -h -s "system" -p "themes" -c "internal.css" -j "table.js themes.js" gargoyle
?>

<script>
<!--
<?
	echo "var themes = new Array();"
	ls /www/themes | awk '{print "themes.push(\""$0"\");" ;}'
?>
//-->
</script>

<form>
	<fieldset>
		<legend class="sectionheader">Themes manager</legend>
		<div class='indent'>
		<div id="themes_table_container"></div>
		</div>
	</fieldset>

	<span id="update_container" >Plase wait while new settings are applied...</span>
</form>

<script>
<!--
	resetData();
//-->
</script>

<?
	gargoyle_header_footer -f -s "system" -p "themes"
?>