<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
                xmlns:kiln="http://www.kcl.ac.uk/artshums/depts/ddh/kiln/ns/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../../kiln/stylesheets/solr/tei-to-solr.xsl" />

  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Oct 18, 2010</xd:p>
      <xd:p><xd:b>Author:</xd:b> jvieira</xd:p>
      <xd:p>This stylesheet converts a TEI document into a Solr index document. It expects the parameter file-path,
      which is the path of the file being indexed.</xd:p>
    </xd:desc>
  </xd:doc>

  <xsl:template match="/">
    <add>
      <xsl:apply-imports />
    </add>
  </xsl:template>
  
  <xsl:template match="//tei:summary/seg" mode="facet_inscription_type">
    <field name="inscription_type">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  
  <xsl:template match="tei:rs[@key]" mode="facet_mentioned_institutions">
    <field name="mentioned_institutions">
      <xsl:value-of select="@key"/>
    </field>
  </xsl:template>
  
  <xsl:template match="tei:persName[@type='divine']" mode="facet_mentioned_divinities">
    <field name="mentioned_divinities">
      <xsl:value-of select="@key"/>
    </field>
  </xsl:template>
 
  
  <xsl:template match="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:history/tei:origin/tei:origPlace" mode="facet_origin_place">
    <field name="origin_place">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  
  <xsl:template match="tei:persName/tei:name[@nymRef]" mode="facet_person_name">
    <field name="person_name">
      <xsl:value-of select="@nymRef"/>
    </field>
  </xsl:template>
  
  
  
  
  <xsl:template match="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/objectType" mode="facet_support_object_type">
    <field name="support_object_type">
      <xsl:value-of select="."/>
    </field>
    
  </xsl:template>
  
  <xsl:template match="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:history/tei:provenance/tei:placeName/tei:seg" mode="facet_found_provenance">
    <field name="found_provenance">
      <xsl:value-of select="."/>      
    </field>
  </xsl:template>
  
  <xsl:template match="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:material" mode="facet_support_material">
    <field name="support_material">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  
  <xsl:template match="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:handDesc/tei:handNote/tei:rs[@type='script']" mode="facet_script_type">
    <field name="script_type">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  
  <xsl:template match="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:handDesc/tei:handNote/tei:rs[@type='execution']" mode="facet_execution">
    <field name="execution">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  
  <xsl:template match="//tei:text/tei:body/tei:div/tei:ab/tei:rs[@type='date']" mode="facet_date_in_text">
    <field name="date_in_text">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  
  <xsl:template match="//tei:text/tei:body/tei:div//tei:ab/tei:rs[@type='pn']" mode="facet_khanmetoba">
    <field name="khanmetoba">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  
  <xsl:template match="//tei:text/tei:body/tei:div/tei:ab/tei:rs[@type='curse']" mode="facet_curse">
    <field name="curse">
      <xsl:value-of select="."/>
    </field>
  </xsl:template>
  
  
  <!-- This template is called by the Kiln tei-to-solr.xsl as part of
       the main doc for the indexed file. Put any code to generate
       additional Solr field data (such as new facets) here. -->
  
  <xsl:template name="extra_fields">
    
    <field name="inscription_language"> 
      <xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:div[@type='edition']/@xml:lang"/> 
    </field> 
    
    
    <xsl:call-template name="field_inscription_type"/>
    <xsl:call-template name="field_mentioned_institutions"/>
    <xsl:call-template name="field_mentioned_divinities"/>
    <xsl:call-template name="field_person_name"/>
    
    <xsl:call-template name="field_found_provenance"/>
    <xsl:call-template name="field_origin_place"/>
    <xsl:call-template name="field_support_material"/>
    <xsl:call-template name="field_support_object_type"/>
    
    <xsl:call-template name="field_script_type"/>
    <xsl:call-template name="field_execution"/>
    <xsl:call-template name="field_date_in_text"/>
    <xsl:call-template name="field_khanmetoba"/>
    <xsl:call-template name="field_curse"/>
    
  </xsl:template>
  
  <xsl:template name="field_inscription_type">
    <xsl:apply-templates mode="facet_inscription_type" select="//tei:summary/seg"/>
  </xsl:template>
  
  <xsl:template name="field_mentioned_institutions">
    <xsl:apply-templates mode="facet_mentioned_institutions" select="//tei:text/tei:body/tei:div[@type='edition']"/>
  </xsl:template>
  
   <xsl:template name="field_mentioned_divinities">
    <xsl:apply-templates mode="facet_mentioned_divinities" select="//tei:text/tei:body/tei:div[@type='edition']" />
  </xsl:template>
  
  <xsl:template name="field_person_name">
    <xsl:apply-templates mode="facet_person_name" select="//tei:text/tei:body/tei:div[@type='edition']" />
  </xsl:template>
  
  <xsl:template name="field_found_provenance">
    <xsl:apply-templates mode="facet_found_provenance" select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:history/tei:provenance/tei:placeName/tei:seg"/>
  </xsl:template>
  
  <xsl:template name="field_origin_place">
    <xsl:apply-templates mode="facet_origin_place" select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:history/tei:origin/tei:origPlace"/>
  </xsl:template>
  
  <xsl:template name="field_support_material">
    <xsl:apply-templates mode="facet_support_material" select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/tei:material"/>
  </xsl:template>
  
  <xsl:template name="field_support_object_type">
    <xsl:apply-templates mode="facet_support_object_type" select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support/objectType"/>
  </xsl:template>
  
  
  <xsl:template name="field_script_type">
    <xsl:apply-templates mode="facet_script_type" select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:handDesc/tei:handNote/tei:rs[@type='script']">
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template name="field_execution">
    <xsl:apply-templates mode="facet_execution" select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:handDesc/tei:handNote/tei:rs[@type='execution']">
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template name="field_date_in_text">
    <xsl:apply-templates mode="facet_date_in_text" select="//tei:text/tei:body/tei:div/tei:ab/tei:rs[@type='date']">
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template name="field_khanmetoba">
    <xsl:apply-templates mode="facet_khanmetoba" select="//tei:text/tei:body/tei:div//tei:ab/tei:rs[@type='pn']">
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template name="field_curse">
    <xsl:apply-templates mode="facet_curse" select="//tei:text/tei:body/tei:div/tei:ab/tei:rs[@type='curse']">
    </xsl:apply-templates>
  </xsl:template>

</xsl:stylesheet>
