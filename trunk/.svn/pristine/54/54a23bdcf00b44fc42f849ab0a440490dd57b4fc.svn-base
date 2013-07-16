<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <tags>
      <xsl:for-each select="root/row">
        <tag>
          <xsl:attribute name="term">
            <xsl:value-of select="ID"/>
          </xsl:attribute>
          <xsl:if test="Parent != '00000000'">
            <xsl:attribute name="parent-term">
              <xsl:value-of select="Parent"/>
            </xsl:attribute>
          </xsl:if>
          <label><xsl:value-of select="Beskrivelse"/></label>
        </tag>
      </xsl:for-each>
    </tags>
  </xsl:template>
</xsl:stylesheet>
