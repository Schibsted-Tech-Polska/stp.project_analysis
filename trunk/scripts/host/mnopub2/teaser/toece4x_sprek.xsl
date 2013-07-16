<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="ISO-8859-1" indent="yes" />
	<xsl:strip-space elements="*" />

	
	<xsl:template match="/">
		<io>
			<xsl:element name="multimediaGroup">
				<xsl:attribute name="type">image</xsl:attribute>
				<xsl:attribute name="published">true</xsl:attribute>
				<xsl:attribute name="source">MEDIANORGE</xsl:attribute>
				<xsl:attribute name="name">sourceid</xsl:attribute>
				<xsl:attribute name="sourceid"><xsl:value-of select="escenic/content[@type='picture']/@sourceid"/></xsl:attribute>
				<xsl:attribute name="id"><xsl:value-of select="escenic/content[@type='picture']/@sourceid"/></xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="escenic/content[@type='picture']/field[@name='binary']"/></xsl:attribute>
				<xsl:attribute name="photographer"><xsl:value-of select="escenic/content[@type='picture']/field[@name='photographer']"/></xsl:attribute>	
				<xsl:element name="multimedia">
					<xsl:attribute name="version">a</xsl:attribute>
					<xsl:attribute name="default">yes</xsl:attribute>
					<xsl:attribute name="filename"><xsl:value-of select="escenic/content[@type='picture']/field[@name='binary']"/></xsl:attribute>
				</xsl:element>	
			</xsl:element>
			<xsl:element name="article">
				<xsl:attribute name="source">MEDIANORGE</xsl:attribute>
				<xsl:attribute name="sourceid"><xsl:value-of select="escenic/content[@type='news' or @type='review']/@sourceid"/></xsl:attribute>
				<xsl:attribute name="id"><xsl:value-of select="escenic/content[@type='news' or @type='review']/@sourceid"/></xsl:attribute>
				<xsl:attribute name="state"><xsl:value-of select="escenic/content[@type='news' or @type='review']/@state"/></xsl:attribute>
				<xsl:attribute name="type">normal</xsl:attribute>
				<section source="escenic" name="sprek" uniquename="henvisninger_vertikal_sprek" homeSection="yes"/>
				<xsl:element name="reference" >
					<xsl:attribute name="type">image</xsl:attribute>
					<xsl:attribute name="source">MEDIANORGE</xsl:attribute>
					<xsl:attribute name="sourceid"><xsl:value-of select="escenic/content[@type='picture']/@sourceid" /></xsl:attribute>
					<xsl:attribute name="priority">1</xsl:attribute>
					<xsl:attribute name="element">FORSIDETITTEL</xsl:attribute>
					<xsl:attribute name="align">left</xsl:attribute>
				</xsl:element>
				
				<creator>
					<xsl:attribute name="firstname"><xsl:value-of select="escenic/content[@type='news' or @type='review']/creator/@first-name"/></xsl:attribute>
					<xsl:attribute name="surname"><xsl:value-of select="escenic/content[@type='news' or @type='review']/creator/@last-name"/></xsl:attribute>
					<xsl:attribute name="email"><xsl:value-of select="escenic/content[@type='news' or @type='review']/creator/@email-address"/></xsl:attribute>
				</creator>
				<author>
					<xsl:attribute name="firstname"><xsl:value-of select="escenic/content[@type='news' or @type='review']/author/@first-name"/></xsl:attribute>
					<xsl:attribute name="surname"><xsl:value-of select="escenic/content[@type='news' or @type='review']/author/@last-name"/></xsl:attribute>
					<xsl:attribute name="email"><xsl:value-of select="escenic/content[@type='news' or @type='review']/author/@email-address"/></xsl:attribute>
				</author>
				<field name="INGRESS"><xsl:value-of select="escenic/content[@type='news' or @type='review']/field[@name='leadtext']"/></field>
				<field name="TITLE"><xsl:value-of select="escenic/content[@type='news' or @type='review']/field[@name='title']"/></field>
				<field name="FORSIDEINGRESS"><xsl:value-of select="escenic/content[@type='news' or @type='review']/field[@name='frontpageleadtext']"/></field>
				<field name="FORSIDETITTEL"><xsl:value-of select="escenic/content[@type='news' or @type='review']/field[@name='frontpagetitle']"/></field>
				<field name="FORSIDEURL"></field>				
			</xsl:element>	
		</io>		
	</xsl:template>	
</xsl:transform>
