<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:template match="result">
        ###  http://www.semanticweb.org/semanas/ontologies/2020/2/cinema#<xsl:value-of select="translate(binding[@name='mname'], ' .(),/\:’–°&quot;','_')"/>
        :<xsl:value-of select="translate(binding[@name='mname'], ' .(),/\:’–°&quot;','_')"/> rdf:type owl:NamedIndividual ,
        :Compositor ;
        :nome "<xsl:value-of select="translate(binding[@name='mname'], '.(),/\:’–°&quot;', '')"/>"^^xsd:string ;
        :dataNascimento "<xsl:value-of select="binding[@name='bdate']"/>"^^xsd:string ;
        :sexo "<xsl:value-of select="binding[@name='gender']"/>"^^xsd:string ;
        :parceira "<xsl:value-of select="substring(binding[@name='wife'], 29)"/>"^^xsd:string .
    </xsl:template>
    
</xsl:stylesheet>