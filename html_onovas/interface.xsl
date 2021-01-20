<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:pdx="http://xml.phpdox.net/src"
                xmlns:pdxf="http://xml.phpdox.net/functions"
                xmlns:pu="http://schema.phpunit.de/coverage/1.0"
                xmlns:func="http://exslt.org/functions"
                xmlns:idx="http://xml.phpdox.net/src"
                xmlns:git="http://xml.phpdox.net/gitlog"
                xmlns:ctx="ctx://engine/html"
                extension-element-prefixes="func"
                exclude-result-prefixes="idx pdx pdxf pu git ctx">

  <xsl:import href="components.xsl" />
  <xsl:import href="functions.xsl" />
  <xsl:import href="synopsis.xsl" />

  <xsl:output method="xml" indent="yes" encoding="UTF-8" doctype-system="about:legacy-compat" />

  <xsl:variable name="unit" select="/*[1]" />

  <xsl:template match="/">
    <html lang="es">
      <xsl:call-template name="head">
        <xsl:with-param name="title" select="$unit/@full" />
      </xsl:call-template>

      <body>
        <div class="container">

          <xsl:call-template name="nav" />
          <xsl:call-template name="head-info" />

          <div id="mainstage">

            <xsl:call-template name="breadcrumb" />
            <xsl:call-template name="sidenav" />

            <section>
              <h1 id="introduction"><small><xsl:value-of select="$unit/@namespace" />\</small><xsl:value-of select="$unit/@name" /></h1>
              <h4><xsl:value-of select="$unit/pdx:docblock/pdx:description/@compact" /></h4>
              <p><xsl:copy-of select="pdxf:nl2br($unit/pdx:docblock/pdx:description)" /></p>
              <xsl:if test="$unit/pdx:docblock">
                <xsl:call-template name="docblock" />
              </xsl:if>

              <h2 id="synopsis">Sinopsis</h2>
              <xsl:call-template name="synopsis">
                <xsl:with-param name="unit" select="$unit" />
              </xsl:call-template>

              <xsl:if test="$unit/pdx:extends|$unit/pdx:extender|$unit/pdx:implements|$unit/pdx:uses">
              <h2 id="hierarchy">Jerarquía</h2>
              <xsl:call-template name="hierarchy">
                <xsl:with-param name="dir" select="'interfaces'" />
              </xsl:call-template>
              </xsl:if>

              <xsl:call-template name="violations">
                <xsl:with-param name="ctx" select="$unit//pdx:enrichments" />
              </xsl:call-template>

              <xsl:if test="//pdx:todo">
                <h2 id="tasks">Tareas</h2>
                <xsl:call-template name="tasks" />
              </xsl:if>

              <xsl:if test="//pdx:constant">
                <h2 id="constants">Constantes</h2>
                <xsl:call-template name="constants" />
              </xsl:if>

              <xsl:if test="//pdx:method">
                <h2 id="methods">Métodos</h2>
                <xsl:call-template name="methods" />
              </xsl:if>
            </section>
          </div>
        </div>
        <xsl:call-template name="footer" />
      </body>
    </html>
  </xsl:template>

  <!-- Breadcrumb -->
  <xsl:template name="breadcrumb">
    <div class="box">
      <ul class="breadcrumb">
        <li><a href="{$base}index.{$extension}">Información</a></li>
        <li class="separator"><a href="{$base}interfaces.{$extension}">Interfaces</a></li>
        <xsl:if test="$unit/@namespace != ''">
          <li class="separator"><a href="{$base}interfaces.{$extension}#{translate($unit/@namespace, '\', '_')}"><xsl:value-of select="$unit/@namespace" /></a></li>
        </xsl:if>
        <li class="separator"><xsl:value-of select="$unit/@name" /></li>
      </ul>
    </div>
  </xsl:template>

  <!-- Sidebar -->
  <xsl:template name="sidenav">
    <nav class="box">
      <ul>
        <li><a href="#introduction">Introducción</a></li>
        <li><a href="#synopsis">Sinopsis</a></li>
        <xsl:if test="$unit/pdx:extends|$unit/pdx:extender|$unit/pdx:implements|$unit/pdx:uses">
          <li><a href="#hierarchy">Jerarquía</a></li>
        </xsl:if>
        <li><a href="#violations">Infracciones</a></li>
        <xsl:if test="//pdx:todo">
          <li><a href="#tasks">Tareas</a></li>
        </xsl:if>
        <xsl:if test="//pdx:constant">
          <li><a href="#constants">Constantes</a></li>
        </xsl:if>
        <xsl:if test="//pdx:method">
          <li><a href="#methods">Métodos</a></li>
        </xsl:if>
        <xsl:if test="$unit/@start"><!-- hack: test for start line == we know something about this class -->
          <li><a href="{$base}source/{$unit/pdx:file/@relative}.{$extension}#line{$unit/@start}">Código Fuente</a></li>
        </xsl:if>
      </ul>
    </nav>
  </xsl:template>


</xsl:stylesheet>
