<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ece="http://xmlns.escenic.com/2009/import" version="1.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <xsl:if test="ece:escenic/ece:content[@type='news' or @type='review' or @type='nettprat' or @type='video' or @type='politiFact']">
            <documents><document><xsl:apply-templates/></document></documents>
        </xsl:if>
    </xsl:template>
   
    <xsl:template match="ece:escenic/ece:content">
        <articlestate>articlestate<xsl:value-of select="@state"/></articlestate>
        <id><xsl:value-of select="ece:publication"/><xsl:value-of select="@exported-dbid"/></id>
        <element name="title"><value>&lt;![CDATA[<xsl:value-of select="ece:field[@name='title']"/>]]&gt;</value></element>
        
        <xsl:if test="ece:field[@name='frontpagetitle'] or ece:field[@name='runninghead'] or ece:field[@name='frontpagerunninghead'] or ece:field[@name='relationtitle'] or ece:field[@name='relationrunninghead'] or ece:field[@name='listtitle']">
            <element name="titleEnrichment">
                <value>
                &lt;![CDATA[
                    <xsl:if test="ece:field[@name='frontpagetitle']"><xsl:if test="string-length(ece:field[@name='frontpagetitle'])>0"><xsl:value-of select="ece:field[@name='frontpagetitle']"/>|</xsl:if></xsl:if>
                    <xsl:if test="ece:field[@name='runninghead']"><xsl:if test="string-length(ece:field[@name='runninghead'])>0"><xsl:value-of select="ece:field[@name='runninghead']"/>|</xsl:if></xsl:if>
                    <xsl:if test="ece:field[@name='frontpagerunninghead']"><xsl:if test="string-length(ece:field[@name='frontpagerunninghead'])>0"><xsl:value-of select="ece:field[@name='frontpagerunninghead']"/>|</xsl:if></xsl:if>
                    <xsl:if test="ece:field[@name='relationtitle']"><xsl:if test="string-length(ece:field[@name='relationtitle'])>0"><xsl:value-of select="ece:field[@name='relationtitle']"/>|</xsl:if></xsl:if>
                    <xsl:if test="ece:field[@name='relationrunninghead']"><xsl:if test="string-length(ece:field[@name='relationrunninghead'])>0"><xsl:value-of select="ece:field[@name='relationrunninghead']"/>|</xsl:if></xsl:if>
                    <xsl:if test="ece:field[@name='listtitle']"><xsl:value-of select="ece:field[@name='listtitle']"/></xsl:if>
                ]]&gt;
                </value>
            </element>
        </xsl:if>
        
        <publication><xsl:value-of select="ece:publication"/>0</publication>
        
        <xsl:if test="ece:field[@name='leadtext'] or ece:field[@name='frontpageleadtext'] or ece:field[@name='listleadtext'] or ece:field[@name='relationleadtext']">
            <element name="leadText">
                <value>
                    &lt;![CDATA[
                    <xsl:choose>
                        <xsl:when test="ece:field[@name='leadtext']"><xsl:if test="string-length(ece:field[@name='leadtext'])>0"><xsl:value-of select="ece:field[@name='leadtext']"/></xsl:if></xsl:when>
                        <xsl:when test="ece:field[@name='frontpageleadtext']"><xsl:if test="string-length(ece:field[@name='frontpageleadtext'])>0"><xsl:value-of select="ece:field[@name='frontpageleadtext']"/></xsl:if></xsl:when>
                        <xsl:when test="ece:field[@name='listleadtext']"><xsl:if test="string-length(ece:field[@name='listleadtext'])>0"><xsl:value-of select="ece:field[@name='listleadtext']"/></xsl:if></xsl:when>
                        <xsl:when test="ece:field[@name='relationleadtext']"><xsl:value-of select="ece:field[@name='relationleadtext']"/></xsl:when>
                    </xsl:choose>
                    ]]&gt;
                </value>
            </element>
        </xsl:if>
        
        <xsl:if test="ece:field[@name='bodytext'] or ece:field[@name='quote'] or ece:field[@name='quotesource']">
            <element name="bodyText">
                <value>
                    &lt;![CDATA[
                    <xsl:if test="ece:field[@name='bodytext']"><xsl:if test="string-length(ece:field[@name='bodytext'])>0"><xsl:value-of select="ece:field[@name='bodytext']"/>|</xsl:if></xsl:if>
                    <xsl:if test="ece:field[@name='quote']"><xsl:if test="string-length(ece:field[@name='quote'])>0"><xsl:value-of select="ece:field[@name='quote']"/>|</xsl:if></xsl:if>
                    <xsl:if test="ece:field[@name='quotesource']"><xsl:value-of select="ece:field[@name='quotesource']"/></xsl:if>
                    ]]&gt;
                </value>
            </element>
        </xsl:if>
         

        <xsl:choose>
            <xsl:when test="relation[@type='TEASERREL']">
                <xsl:for-each select="relation[@type='TEASERREL']">
                    <element name="imageMain"><value><xsl:value-of select="@exported-dbid"/></value></element>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="relation[@type='TOPMEDIAREL']">
                <xsl:for-each select="relation[@type='TEASERREL']">
                    <element name="imageMain"><value><xsl:value-of select="@exported-dbid"/></value></element>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="relation[@type='PICTUREREL']">
                <xsl:for-each select="relation[@type='TEASERREL']">
                    <element name="imageMain"><value><xsl:value-of select="@exported-dbid"/></value></element>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    
        <xsl:for-each select="ece:section-ref">
            <xsl:if test="@home-section='true'">
                <element name="homeSection">
                    <value>&lt;![CDATA[<xsl:value-of select="@unique-name"/>]]&gt;</value>
                </element>
                <xsl:choose>
                  <xsl:when test="//ece:publication='bilvertikal'">
                        <element name="url"><value>&lt;![CDATA[http://bil.aftenposten.no/<xsl:value-of select="@unique-name"/>/<xsl:value-of select="//ece:uri"/>]]&gt;</value></element>
                    </xsl:when>
                    <xsl:when test="//ece:publication='sa'">
                        <element name="url"><value>&lt;![CDATA[http://www.aftenbladet.no/<xsl:value-of select="@unique-name"/>/<xsl:value-of select="//ece:uri"/>]]&gt;</value></element>                    
                    </xsl:when>
                    <xsl:when test="//ece:publication='ap'">
                        <element name="url"><value>&lt;![CDATA[http://www.aftenposten.no/<xsl:value-of select="@unique-name"/>/<xsl:value-of select="//ece:uri"/>]]&gt;</value></element>
                    </xsl:when>
                    <xsl:when test="//ece:publication='fv'">
                        <element name="url"><value>&lt;![CDATA[http://www.fvn.no/<xsl:value-of select="@unique-name"/>/<xsl:value-of select="//ece:uri"/>]]&gt;</value></element>
                    </xsl:when>
                    <xsl:otherwise>
                        <element name="url"><value>&lt;![CDATA[http://www.bt.no/<xsl:value-of select="@unique-name"/>/<xsl:value-of select="//ece:uri"/>]]&gt;</value></element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </xsl:for-each>


        <xsl:variable name="pubDate" select="@publishdate"/>
        <element name="firstPublished"><value><xsl:value-of select="substring-before($pubDate, ' ')"/>T<xsl:value-of select="substring($pubDate,12,8)"/>Z</value></element>
        <element name="docdatetime"><value><xsl:value-of select="substring-before($pubDate, ' ')"/>T<xsl:value-of select="substring($pubDate,12,8)"/>Z</value></element>

        <element name="escenicArtType"><value>&lt;![CDATA[<xsl:value-of select="@type"/>]]&gt;</value></element>
        

        <xsl:variable name="numNodes2" select="count(section-ref)"/>
        
        <xsl:if test="$numNodes2 &gt; 1">
            <element name="relatedSections">
                <value>
                    &lt;![CDATA[
                        <xsl:for-each select="section-ref">
                            <xsl:if test="@home-section=false()"><xsl:value-of select="@unique-name"/>|</xsl:if>
                        </xsl:for-each>
                    ]]&gt;
                </value>
            </element>
        </xsl:if>
        
        <xsl:if test="relation[@type='STORYREL']">
            <element name="relatedArticles">
                <value>
                    &lt;![CDATA[
                        <xsl:for-each select="relation[@type='STORYREL']">
                            <xsl:if test="ece:field[@name='title']"><xsl:value-of select="ece:field[@name='title']"/>|</xsl:if>
                            <xsl:if test="ece:field[@name='runninghead']"><xsl:value-of select="ece:field[@name='runninghead']"/>|</xsl:if>
                        </xsl:for-each>
                    ]]&gt;
                </value>
            </element>
            
            <element name="relatedArticleUrls">
                <value>
                    &lt;![CDATA[
                    <xsl:for-each select="relation[@type='STORYREL']">
                        <xsl:value-of select="@exported-dbid"/>|
                    </xsl:for-each>
                    ]]&gt;
                </value>    
            </element>
        </xsl:if>
        
        <xsl:if test="ece:field[@name='reviewsubjecttitle']">
            <element name="subjectTitle">
                <value>
                    &lt;![CDATA[
                    <xsl:value-of select="ece:field[@name='reviewsubjecttitle']"/>
                    ]]&gt;
                </value>
            </element>
        </xsl:if>
        
        <xsl:if test="ece:field[@name='reviewtype']">
            <element name="eventDescription">
                <value>
                    &lt;![CDATA[
                    <xsl:value-of select="ece:field[@name='reviewtype']/value"/>
                    ]]&gt;
                </value>
            </element>
        </xsl:if>
        
        <xsl:if test="ece:field[@name='score']">
            <element name="rating">
                <value>
                    &lt;![CDATA[
                    <xsl:value-of select="ece:field[@name='score']/value"/>
                    ]]&gt;                
                </value>
            </element>
        </xsl:if>

        <xsl:if test="ece:field[@name='theme']">
            <xsl:if test="ece:field[@name='theme'] != ''">
                <element name="internalcategories">
                    <value>
                        &lt;![CDATA[
                        <xsl:value-of select="ece:field[@name='theme']"/>
                        ]]&gt;
                    </value>
                </element>
            </xsl:if>
        </xsl:if>
        
        <!--
        <xsl:variable name="numNodes2" select="child::node()/@unique-name"/>
        <test><xsl:value-of select="$numNodes2"/></test>
        -->
        
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="ece:author">
        <element name="author">
            <value>
                &lt;![CDATA[
                <xsl:if test="@first-name!=''"><xsl:value-of select="@first-name"/></xsl:if>
                <xsl:if test="@last-name!=''"><xsl:text> </xsl:text><xsl:value-of select="@last-name"/></xsl:if>
                ]]&gt;
            </value>
        </element>
        <xsl:if test="@email-address!=''">
            <element name="authorEmailAddress">
                <value>
                    &lt;![CDATA[
                        <xsl:value-of select="@email-address"/>
                    ]]&gt;
                </value>
            </element>
        </xsl:if>
        <xsl:apply-templates/>
        <element name="grouping"><value>&lt;![CDATA[escenic]]&gt;</value></element>
    </xsl:template>
    
    <xsl:template match="ece:publication"/>
    <xsl:template match="ece:uri"/>
    <xsl:template match="ece:field[@*]"></xsl:template>
    <xsl:template match="ece:relation/ece:field[@*]"></xsl:template>
    
    
</xsl:stylesheet>
