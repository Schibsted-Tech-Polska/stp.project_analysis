<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xslt="http://xml.apache.org/xslt" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output encoding="UTF-8" method="text" omit-xml-declaration="yes" indent="no"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="documents/document">
        <xsl:value-of select="id"/>
    </xsl:template>
</xsl:stylesheet>