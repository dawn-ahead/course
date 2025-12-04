<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				 xmlns:websoft="http://www.websoft.ru"
				 version="1.0">
<!--
'*	v_rapid_007#.xsl
'*	Copyright (c) Websoft Ltd., Russia.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>

<xsl:param name="moduleImagesFolder"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="width"></xsl:param>
<xsl:param name="height"></xsl:param>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>

<xsl:template match="params">

	<xsl:variable name="pwidth">
		<xsl:choose>
			<xsl:when test="number($width) &gt; number($height)"><xsl:value-of select="$height"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$width"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="pheight">
		<xsl:choose>
			<xsl:when test="number($height) &gt; number($width)"><xsl:value-of select="$width"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$height"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="pcolor">
		<xsl:choose>
			<xsl:when test="color_scheme='red'">#FF0000</xsl:when>
			<xsl:when test="color_scheme='yellow'">#FFFF00</xsl:when>
			<xsl:when test="color_scheme='cyan'">#00FFFF</xsl:when>
			<xsl:when test="color_scheme='green'">#00FF00</xsl:when>
			<xsl:when test="color_scheme='blue'">#0000FF</xsl:when>
			<xsl:when test="color_scheme='orange'">#FF9900</xsl:when>
			<xsl:when test="color_scheme='white'">#F8F8F8</xsl:when>
			<xsl:when test="color_scheme='black'">#000033</xsl:when>
			<xsl:otherwise>#FF9900</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="cradius" select="round(0.3*number($pwidth))"/>
	<xsl:variable name="cmargin" select="round(0.2*number($pwidth))"/>
	
	<style>
		.container { position: absolute; top: 0; left: 0; width: <xsl:value-of select="$pwidth"/>px; height: <xsl:value-of select="$pheight"/>px; overflow: hidden; }
		.circle { position: absolute; box-sizing: border-box; top: 0; left: 0; margin: <xsl:value-of select="$cmargin"/>px; width: <xsl:value-of select="2*number($cradius)"/>px; height: <xsl:value-of select="2*number($cradius)"/>px; -webkit-border-radius: <xsl:value-of select="$cradius"/>px; border-radius: <xsl:value-of select="$cradius"/>px; border: solid 2px <xsl:value-of select="$pcolor"/>; overflow: hidden; }
		.crosshair1 { position: absolute; left: 0; top: 0; width: <xsl:value-of select="$pwidth"/>px; height: <xsl:value-of select="floor(0.5*number($pheight))-1"/>px; border-bottom: solid 2px <xsl:value-of select="$pcolor"/>; overflow: hidden; }
		.crosshair2 { position: absolute; left: 0; top: 0; width: <xsl:value-of select="floor(0.5*number($pwidth))-1"/>px; height: <xsl:value-of select="$pheight"/>px; border-right: solid 2px <xsl:value-of select="$pcolor"/>; overflow: hidden; }
	</style>
	<div>
		<xsl:attribute name="class">container</xsl:attribute>
		<div>
			<xsl:attribute name="class">circle</xsl:attribute>
			&#160;
		</div>
		<div>
			<xsl:attribute name="class">crosshair1</xsl:attribute>
			&#160;
		</div>
		<div>
			<xsl:attribute name="class">crosshair2</xsl:attribute>
			&#160;
		</div>
	</div>	
</xsl:template>

</xsl:stylesheet>
