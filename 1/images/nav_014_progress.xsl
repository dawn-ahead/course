<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:msxsl="urn:schemas-microsoft-com:xslt"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	nav_014_progress.xsl
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>
<xsl:template match="params">

	<xsl:variable name="bg-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="bg_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="border-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="border_color"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="img.visited">
		<xsl:choose>
			<xsl:when test="standard='yes'"><xsl:value-of select="$imagesFolder"/>icon_visited.gif</xsl:when>
			<xsl:when test="standard!='yes' and n1_img=''"><xsl:value-of select="$imagesFolder"/>icon_visited.gif</xsl:when>
			<xsl:otherwise><xsl:value-of select="n1_img"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="img.current">
		<xsl:choose>
			<xsl:when test="standard='yes'"><xsl:value-of select="$imagesFolder"/>icon_current.gif</xsl:when>
			<xsl:when test="standard!='yes' and n2_img=''"><xsl:value-of select="$imagesFolder"/>icon_current.gif</xsl:when>
			<xsl:otherwise><xsl:value-of select="n2_img"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="img.unvisited">
		<xsl:choose>
			<xsl:when test="standard='yes'"><xsl:value-of select="$imagesFolder"/>icon_unvisited.gif</xsl:when>
			<xsl:when test="standard!='yes' and n3_img=''"><xsl:value-of select="$imagesFolder"/>icon_unvisited.gif</xsl:when>
			<xsl:otherwise><xsl:value-of select="n3_img"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="_css_border_style">
		<xsl:choose>
			<xsl:when test="number(border_width)=0 or border_style='none'"></xsl:when>
			<xsl:otherwise>border-style: <xsl:value-of select="border_style"/>; border-width: <xsl:value-of select="border_width"/>px; border-color: <xsl:value-of select="$border-color-fixed"/>;</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="shadow-string">
		<xsl:choose>
			<xsl:when test="shadow_strength='extralight'">2px 2px 6px #ccc</xsl:when>
			<xsl:when test="shadow_strength='light'">2px 2px 6px #999</xsl:when>
			<xsl:when test="shadow_strength='normal'">2px 2px 6px #666</xsl:when>
			<xsl:when test="shadow_strength='dark'">2px 2px 6px #333</xsl:when>
			<xsl:when test="shadow_strength='extradark'">2px 2px 6px #000</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="nOffset">
		<xsl:choose>
			<xsl:when test="string(number(offset))='NaN'">0</xsl:when>
			<xsl:otherwise><xsl:value-of select="offset"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<div class="style-custom" style="display: none">
		<div class="rule">
			<xsl:attribute name="data-name">#<xsl:value-of select="$objectID"/> .cl-progress</xsl:attribute>
			<span class="rule-static">padding: <xsl:value-of select="padding"/>px; background-color: <xsl:value-of select="$bg-color-fixed"/>; <xsl:value-of select="$_css_border_style"/></span>
			<xsl:if test="number(border_radius)!=0">
				<span class="rule-dynamic">
					<xsl:attribute name="data-type">border-radius</xsl:attribute>
					<xsl:attribute name="data-value"><xsl:value-of select="border_radius"/>px</xsl:attribute>
				</span>
			</xsl:if>
			<xsl:if test="shadow_strength!='none'">
				<span class="rule-dynamic">
					<xsl:attribute name="data-type">box-shadow</xsl:attribute>
					<xsl:attribute name="data-value"><xsl:value-of select="$shadow-string"/></xsl:attribute>
				</span>
			</xsl:if>
		</div>
		<div class="rule">
			<xsl:attribute name="data-name">#<xsl:value-of select="$objectID"/> .cl-rail-table td</xsl:attribute>
			<span class="rule-static">padding: 0 <xsl:value-of select="0.5*number($nOffset)"/>px;</span>
		</div>
	</div>
	<div>
		<xsl:attribute name="class">cl-container unselectable</xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-progress</xsl:attribute>
			<table cellpadding="0" border="0">
				<xsl:attribute name="class">cl-rail-table</xsl:attribute>
				<tr>
					<xsl:attribute name="class">cl-rail</xsl:attribute>
					<td class="cl-template">
						<img border="0">
							<xsl:attribute name="class">cl-unvisited</xsl:attribute>
							<xsl:attribute name="src"><xsl:value-of select="$img.unvisited"/></xsl:attribute>
						</img>
						<img border="0">
							<xsl:attribute name="class">cl-visited</xsl:attribute>
							<xsl:attribute name="src"><xsl:value-of select="$img.visited"/></xsl:attribute>
						</img>
						<img border="0">
							<xsl:attribute name="class">cl-current</xsl:attribute>
							<xsl:attribute name="src"><xsl:value-of select="$img.current"/></xsl:attribute>
						</img>
					</td>
				</tr>
			</table>
		</div>
	</div>

</xsl:template>
<xsl:template name="fix-color">
	<xsl:param name="color"/>
	<xsl:choose>
		<xsl:when test="substring($color, 1, 1)='#'">
			<xsl:choose>
				<xsl:when test="string-length($color)=7"><xsl:value-of select="$color"/></xsl:when>
				<xsl:when test="string-length($color)=4">#<xsl:value-of select="substring($color, 2, 1)"/><xsl:value-of select="substring($color, 2, 1)"/><xsl:value-of select="substring($color, 3, 1)"/><xsl:value-of select="substring($color, 3, 1)"/><xsl:value-of select="substring($color, 4, 1)"/><xsl:value-of select="substring($color, 4, 1)"/></xsl:when>
				<xsl:otherwise>transparent</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>transparent</xsl:otherwise>
	</xsl:choose>
</xsl:template>
</xsl:stylesheet>
