<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:template match="result">
        ###  http://www.semanticweb.org/semanas/ontologies/2020/2/cinema#<xsl:value-of select="translate(binding[@name='fname'], ' .[]¡§½=¿+-;…#$%?!—(),/\:’–°*&quot;','_')"/>
        :<xsl:value-of select="translate(binding[@name='fname'], ' .[]¡§½=¿+-;…#$%?!—(),/\:’–°*&quot;','_')"/> rdf:type owl:NamedIndividual ,
        :Filme ;
        :titulo "<xsl:value-of select="translate(binding[@name='fname'], '.[]¡§½=¿+-;…#$%?!—(),/\:’–°*&quot;','')"/>"^^xsd:string ;
        :diretor "<xsl:value-of select="translate(substring(binding[@name='dir'], 29), ' .[]¡§½=¿+-;…#$%?!—(),/\:’–°*&#xA;&quot;','_')"/>"^^xsd:string ;
        :temCompositor :<xsl:value-of select="translate(substring(binding[@name='music'], 29), ' .[]¡§½=¿+-;…#$%?!—(),/\:’–°*&#xA;&quot;','_')"/>;
        :temEscritor :<xsl:value-of select="translate(substring(binding[@name='writer'], 29), ' .[]¡§½=¿+-;…#$%?!—(),/\:’–°*&#xA;&quot;','_')"/>;
        :temPaisOrigem :<xsl:value-of select="translate(binding[@name='country'], ' .[]¡§½=¿+-;…#$%?!—(),/\:’–°*&#xA;&quot;','_')"/>;
        :temLingua :<xsl:value-of select="translate(binding[@name='lang'], ' .[]¡§½=¿+-;…#$%?!—(),/\:’–°*&#xA;&quot;','_')"/>.
    </xsl:template>
    
</xsl:stylesheet>