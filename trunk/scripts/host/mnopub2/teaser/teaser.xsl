<?xml version="1.0" encoding="ISO-8859-1"?>
<!--   ==== aftenposten ====  -->
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
	<!-- Document Element (root) -->

	<xsl:template match="/">
		<!-- Resolving the usedImageSourceId -->
		<xsl:variable name="usedImageSourceId">
			<xsl:for-each
				select="/escenic/content[@type='news' or @type='review']/section-ref[@unique-name='henvisninger_vertikal_bil' or @unique-name='henvisninger_sprek']">
				<xsl:variable name="srcId">
					<xsl:value-of select="../@sourceid"/>
				</xsl:variable>
				<xsl:for-each select="relation">
				
				</xsl:for-each>
				<xsl:variable name="imgTeaserSrcId">
					<xsl:value-of select="../relation[@type='TEASERREL']/@sourceid"/>
				</xsl:variable>
				<!-- image -->
				<xsl:variable name="imgContentSourceId">
					<xsl:value-of select="/escenic/content[@type='picture' and @sourceid=$imgTeaserSrcId]/@sourceid" /> 
				</xsl:variable>
				<xsl:if test="$imgContentSourceId != ''">
					<xsl:value-of select="$imgContentSourceId"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>	
		<!-- Resolving the contentSourceId -->					
		<xsl:variable name="contentSourceId">
			<xsl:for-each
				select="/escenic/content[@type='news' or @type='review']/section-ref[@unique-name='henvisninger_vertikal_bil' or @unique-name='henvisninger_sprek']">
				<xsl:variable name="srcId">
					<xsl:value-of select="../@sourceid"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$usedImageSourceId != ''">
						<xsl:variable name="imgTeaserSrcId">
							<xsl:value-of
								select="/escenic/content[@sourceid=$srcId]/relation[@type='TEASERREL'][@sourceid = $usedImageSourceId]"
							/>
						</xsl:variable>
						<xsl:if test="$imgTeaserSrcId != ''">
							<xsl:value-of select="../@sourceid"/>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../@sourceid"/>	
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>	
		<escenic xmlns="http://xmlns.escenic.com/2009/import" version="2.0">
			<xsl:if test="$usedImageSourceId != ''">
				<xsl:element name="content" namespace="http://xmlns.escenic.com/2009/import">					
					<xsl:attribute name="source"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/@source"/></xsl:attribute>
					<xsl:attribute name="sourceid"><xsl:value-of select="$usedImageSourceId"/></xsl:attribute>
					<xsl:attribute name="type"><xsl:value-of select="/escenic/content[@sourceid=$usedImageSourceId]/@type"/></xsl:attribute>
					<xsl:attribute name="state"><xsl:text>published</xsl:text></xsl:attribute>
					<xsl:element name="field">
						<xsl:attribute name="name">binary</xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="/escenic/content[@sourceid = $usedImageSourceId]/field[@name='binary']/@title"/></xsl:attribute>
						<xsl:value-of select="/escenic/content[@sourceid = $usedImageSourceId]/field[@name='binary']"/>
					</xsl:element>
					<xsl:element name="field">
						<xsl:attribute name="name">title</xsl:attribute>
						<xsl:value-of select="/escenic/content[@sourceid = $usedImageSourceId]/field[@name='title']"/>
					</xsl:element>
				</xsl:element>	
			</xsl:if>
			<xsl:element name="content" namespace="http://xmlns.escenic.com/2009/import">
				<xsl:attribute name="source"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/@source"/></xsl:attribute>
				<xsl:attribute name="sourceid"><xsl:value-of select="$contentSourceId"/></xsl:attribute>
				<xsl:attribute name="type">news</xsl:attribute>
				<xsl:attribute name="state"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/@state"/></xsl:attribute>
				<xsl:attribute name="publishdate"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/@publishdate"/></xsl:attribute>
				<!--<xsl:attribute name="state">submitted</xsl:attribute>-->
				<!--	<xsl:element name="section-ref" namespace="http://xmlns.escenic.com/2009/import">
						<xsl:attribute name="source">CCI</xsl:attribute>
						<xsl:attribute name="home-section">true</xsl:attribute>
						<xsl:apply-templates select="nitf/head/tobject" />
					</xsl:element>
				-->
				<xsl:element name="uri">
					<xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/uri"/>
				</xsl:element>
				
				<xsl:element name="creator">
					<xsl:attribute name="first-name"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/creator/@first-name"/></xsl:attribute>
					<xsl:attribute name="last-name"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/creator/@last-name"/></xsl:attribute>
					<xsl:attribute name="email-address"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/creator/@email-address"/></xsl:attribute>
					<xsl:attribute name="username"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/creator/@username"/></xsl:attribute>
				</xsl:element>
				<xsl:element name="author">
					<xsl:attribute name="first-name"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/author/@first-name"/></xsl:attribute>
					<xsl:attribute name="last-name"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/author/@last-name"/></xsl:attribute>
					<xsl:attribute name="email-address"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/author/@email-address"/></xsl:attribute>
					<xsl:attribute name="username"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/author/@username"/></xsl:attribute>
				</xsl:element>
				
				<xsl:element name="field" namespace="http://xmlns.escenic.com/2009/import">
					<xsl:attribute name="name">frontpagetitle</xsl:attribute>
					<xsl:variable name="fpTitle"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/field[@name='frontpagetitle']"/></xsl:variable>
					<xsl:if test="$fpTitle = ''"><xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/field[@name='title']"/></xsl:if>
					<xsl:if test="$fpTitle != ''"><xsl:value-of select="$fpTitle"/></xsl:if>
				</xsl:element>
				<xsl:element name="field" namespace="http://xmlns.escenic.com/2009/import">
					<xsl:attribute name="name">frontpageleadtext</xsl:attribute>
					<xsl:variable name="fpLeadText">
						<xsl:value-of
							select="/escenic/content[@sourceid=$contentSourceId]/field[@name='frontpageleadtext']"
						/>
					</xsl:variable>
					<xsl:if test="$fpLeadText = ''">
						<xsl:value-of
							select="/escenic/content[@sourceid=$contentSourceId]/field[@name='leadtext']"
						/>
					</xsl:if>
					<xsl:if test="$fpLeadText != ''">
						<xsl:value-of select="$fpLeadText"/>
					</xsl:if>
				</xsl:element>
				<xsl:element name="field" namespace="http://xmlns.escenic.com/2009/import">
					<xsl:attribute name="name">title</xsl:attribute>
					<xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/field[@name='title']"/>
				</xsl:element>
				<xsl:element name="field" namespace="http://xmlns.escenic.com/2009/import">
					<xsl:attribute name="name">leadtext</xsl:attribute>
					<xsl:value-of select="/escenic/content[@sourceid=$contentSourceId]/field[@name='leadtext']"/>
				</xsl:element>
				<xsl:element name="field" namespace="http://xmlns.escenic.com/2009/import">
					<xsl:attribute name="name">link</xsl:attribute>http://www</xsl:element>
					<xsl:element name="relation" namespace="http://xmlns.escenic.com/2009/import">
					<xsl:attribute name="type">TEASERREL</xsl:attribute>
						<xsl:attribute name="sourceid"><xsl:value-of select="/escenic/content[@sourceid = $contentSourceId]/relation[@type='TEASERREL']/@sourceid"/></xsl:attribute>
						<xsl:attribute name="source"><xsl:value-of select="/escenic/content[@sourceid = $contentSourceId]/@source"/></xsl:attribute>	
					<xsl:element name="field">
						<xsl:attribute name="name">title</xsl:attribute>
						<xsl:value-of select="/escenic/content[@sourceid = $contentSourceId]/relation[@type='TEASERREL']/field[@name = 'title']"/>
					</xsl:element>
					<xsl:element name="field">
						<xsl:attribute name="name">photographer</xsl:attribute>
						<xsl:value-of select="/escenic/content[@sourceid = $contentSourceId]/relation[@type='TEASERREL']/field[@name = 'photographer']"/>
					</xsl:element>
					<xsl:element name="field">
						<xsl:attribute name="name">caption</xsl:attribute>
						<xsl:value-of select="/escenic/content[@sourceid = $contentSourceId]/relation[@type='TEASERREL']/field[@name = 'caption']"/>
					</xsl:element>
				</xsl:element>	
			</xsl:element>
		</escenic>
	</xsl:template>
</xsl:transform>
