<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:template match="obra">
        ###  http://www.semanticweb.org/eduar/ontologies/2020/1/arqSon#<xsl:value-of select="@id"/>
        :<xsl:value-of select="@id"/> rdf:type owl:NamedIndividual ,
        :Obra ;
        :titulo "<xsl:value-of select="titulo"/>"^^xsd:string ;
        :tipo "<xsl:value-of select="tipo"/>"^^xsd:string ;<xsl:if test="exists(inf-relacionada)">
        :inf-relacionada "<xsl:value-of select="inf-relacionada/video/@href"/>"^^xsd:string ;</xsl:if>
        :compositor "<xsl:value-of select="compositor"/>"^^xsd:string .
        <xsl:apply-templates select=".//partitura"/>
    </xsl:template>
    
    <xsl:template match="partitura">
        ###  http://www.semanticweb.org/eduar/ontologies/2020/1/arqSon#<xsl:value-of select="@path"/>
        :<xsl:value-of select="@path"/> rdf:type owl:NamedIndividual ,
        :Partitura ;
        :designacao "<xsl:value-of select="../designacao"/>"^^xsd:string ;
        :tipo "<xsl:value-of select="@type"/>"^^xsd:string ;<xsl:if test="exists(@voz)">
        :voz "<xsl:value-of select="@voz"/>"^^xsd:string ;</xsl:if><xsl:if test="exists(@clave)">
        :clave "<xsl:value-of select="@clave"/>"^^xsd:string ;</xsl:if><xsl:if test="exists(@afinacao)">
        :afinacao "<xsl:value-of select="@afinacao"/>"^^xsd:string ;</xsl:if>
        :path "<xsl:value-of select="@path"/>"^^xsd:string ;
        :partituraDe :<xsl:value-of select="../../../@id"/> .
    </xsl:template>
    
</xsl:stylesheet>