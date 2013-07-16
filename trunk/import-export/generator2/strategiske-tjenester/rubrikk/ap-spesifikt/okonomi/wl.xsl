<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xslt="http://xml.apache.org/xslt" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output encoding="UTF-8" method="text" omit-xml-declaration="yes" indent="no" />
    <xsl:strip-space elements="*"/>
    <xsl:template match="MS_xml_root">
        <xsl:value-of select="message/fld[1]"/><xsl:text>&#xa;</xsl:text><xsl:value-of select="message/fld[2]"/>
    </xsl:template>
</xsl:stylesheet>