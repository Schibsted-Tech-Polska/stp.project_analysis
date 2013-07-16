<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:e="http://xmlns.escenic.com/2009/import">
    <xsl:output method="xml" omit-xml-declaration="yes"/>
    <xsl:template match="*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="article[@type='konkurranse']"/>
    <xsl:template match="article[@type='funksjon']"/>
    <xsl:template match="article[@type='Facts']"/>
    <xsl:template match="article[@type='KsArticle']"/>
    <xsl:template match="article[@type='DebateArticle']"/>
    <xsl:template match="article[@type='PollArticle']"/>
    <xsl:template match="article[@type='verification']"/>
    <xsl:template match="article[@type='aboWeb']"/>
    <xsl:template match="article[@type='posting']"/>
    <xsl:template match="article[@type='forum']"/>
    
    
    <xsl:template match="field[@name='CENTRALBODYTEXT']">
        <xsl:if test="not(parent::article/field[@name='BODYTEXT'])">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:attribute name="name">
                    <xsl:text>BODYTEXT</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="type"><xsl:text>html</xsl:text></xsl:attribute>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    <xsl:template match="field[@name='CENTRALLEADTEXT']">
        <xsl:if test="not(parent::article/field[@name='LEADTEXT'])">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:attribute name="name">
                    <xsl:text>LEADTEXT</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="type"><xsl:text>html</xsl:text></xsl:attribute>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    <xsl:template match="field[@name='CENTRALFACT']">
        <xsl:if test="not(parent::article/field[@name='FACTDESCRIPTION'])">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:attribute name="name">
                    <xsl:text>FACTDESCRIPTION</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="type"><xsl:text>html</xsl:text></xsl:attribute>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>   
    <xsl:template match="field[@name='CENTRALTITLE']">
        <xsl:if test="not(parent::article/field[@name='TITLE'])">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:attribute name="name">
                    <xsl:text>TITLE</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    <xsl:template match="field[@name='CENTRALBYLINE']">
        <xsl:if test="not(parent::article/field[@name='BYLINE'])">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:attribute name="name">
                    <xsl:text>BYLINE</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:if>
    </xsl:template> 
    <xsl:template match="field[@name='CENTRALRUNNINGHEAD']">
        <xsl:if test="not(parent::article/field[@name='RUNNINGHEAD'])">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:attribute name="name">
                    <xsl:text>RUNNINGHEAD</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:if>
    </xsl:template> 
    <xsl:template match="field[@name='CENTRALFRONTPAGERUNNINGHEAD']">
        <xsl:if test="not(parent::article/field[@name='FRONTPAGERUNNINGHEAD'])">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:attribute name="name">
                    <xsl:text>FRONTPAGERUNNINGHEAD</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:if>
    </xsl:template> 
    <xsl:template match="field[@name='CENTRALFRONTPAGELEADTEXT']">
        <xsl:if test="not(parent::article/field[@name='FRONTPAGELEADTEXT'])">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:attribute name="name">
                    <xsl:text>FRONTPAGELEADTEXT</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="type"><xsl:text>html</xsl:text></xsl:attribute>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    <xsl:template match="field[@name='CENTRALFRONTPAGETITLE']">
        <xsl:if test="not(parent::article/field[@name='FRONTPAGETITLE'])">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:attribute name="name">
                    <xsl:text>FRONTPAGETITLE</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    <xsl:template match="field[@name='ARTIST']">
        <xsl:if test="not(parent::article/field[@name='REVIEWPERFORMERNAME'])">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:attribute name="name">
                    <xsl:text>REVIEWPERFORMERNAME</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    <xsl:template match="field[@name='BODY']"/>
    <xsl:template match="field[@name='BYSPILL']"/>
    <xsl:template match="field[@name='CONTENTSOURCE']"/>
    <xsl:template match="field[@name='ENABLETIP']"/>
    <xsl:template match="field[@name='FPNUMRELATEDARTICLES']"/>
    <xsl:template match="field[@name='HIDERELATIONLEADTEXT']"/>
    <xsl:template match="field[@name='IMAGEFULLWIDTH']"/>
    <xsl:template match="field[@name='LINKURL']"/>
    <xsl:template match="field[@name='LOKALKANDEBATTERES']"/>
    <xsl:template match="field[@name='LOKALLOKAL']"/>
    <xsl:template match="field[@name='LOKALSEKSJONSFLASHAKTIV']"/>
    <xsl:template match="field[@name='MOBILELEADTEXT']"/>
    <xsl:template match="field[@name='MOBILETITLE']"/>
    <xsl:template match="field[@name='MUSIKK-CD']"/>
    <xsl:template match="field[@name='NOBYLINE']"/>
    <xsl:template match="field[@name='NTB']"/>
    <xsl:template match="field[@name='OLDSECTION']"/>
    <xsl:template match="field[@name='RELATEDARTICLESWITHLEADTEXT']"/>
    <xsl:template match="field[@name='RELATIONIMAGESIZE']"/>
    <xsl:template match="field[@name='RSSADD']"/>
    <xsl:template match="field[@name='SECTIONFPIMAGESIZE']"/>
    <xsl:template match="field[@name='SEKSJONSFLASHAKTIV']"/>
    <xsl:template match="field[@name='STATUS']"/>
    <xsl:template match="field[@name='VALGPANEL']"/>
    <xsl:template match="field[@name='VIDEOMODUS']"/>
    <xsl:template match="field[@name='WRITER']"/>
    <xsl:template match="field[@name='CHANGEDDATE']"/>
    <xsl:template match="field[@name='ENDTIME']"/>
    <xsl:template match="field[@name='PRIORITY']"/>
    <xsl:template match="field[@name='QUIZID']"/>
    <xsl:template match="field[@name='RSSREMOVE']"/>
    <xsl:template match="field[@name='WHATSONPLACEID']"/>   
    <xsl:template match="field[@name='WHATSONEVENTID']"/> 
    <xsl:template match="field[@name='PERFORMER']"/>   
    <xsl:template match="field[@name='INGRESS']"/>   
    <xsl:template match="field[@name='FRONTPAGEINGRESS']"/>
    <xsl:template match="field[@name='FAKTATEKST']"/>
    <xsl:template match="field[@name='FRONTPAGEINGRESS']"/>    
    <xsl:template match="field[@name='LINKTOORIGINALARTICLE']"/>    
    <xsl:template match="field[@name='WHATSONID']"/>
    <xsl:template match="field[@name='TOPICCATEGORY']"/>
    <xsl:template match="field[@name='STARTTIME']"/>
    <xsl:template match="field[@name='SHOWRELATIONARTICLE']"/>
    <xsl:template match="field[@name='SOURCE']"/>
</xsl:stylesheet>
