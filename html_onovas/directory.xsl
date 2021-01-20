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

  <xsl:param name="title" select="'Código Fuente'" />
  <xsl:import href="components.xsl" />
  <xsl:import href="functions.xsl" />

  <xsl:variable name="ctx" select="//pdx:dir[@ctx:engine]" />

  <xsl:output method="xml" indent="yes" encoding="UTF-8" />

  <xsl:template match="/">
    <html lang="es">
      <xsl:call-template name="head" />

      <body>
        <div class="container">

          <xsl:call-template name="nav" />
          <xsl:call-template name="head-info" />

          <div id="mainstage" class="row">

            <div class="col-md-12">
              <h1>Código fuente de <xsl:value-of select="$project" /></h1>
              <p>
                  Este proyecto tiene <xsl:value-of select="count(//pdx:dir)" /> directorios, que contienen
                  un total de <xsl:value-of select="count(//pdx:file)" /> archivos.
              </p>
            </div>

            <ul class="path">
              <li><a href="{$base}source/index.{$extension}">inicio</a></li>
              <xsl:apply-templates select="$ctx/parent::pdx:dir" mode="head" />
              <xsl:if test="not($ctx/parent::pdx:source)">
                <li class="separator">&#160;<xsl:value-of select="$ctx/@name" /></li>
              </xsl:if>
            </ul>

            <table class="styled directory">
              <tr>
                <th>Nombre</th>
                <th>Tamaño</th>
                <th>Última modificación</th>
              </tr>

              <xsl:apply-templates select="$ctx/pdx:file|$ctx/pdx:dir" mode="table">
                <xsl:sort select="@name" order="ascending" />
              </xsl:apply-templates>

              <tr>
                <td colspan="3">
                  <small>
                    <xsl:variable name="dircount" select="count($ctx/pdx:dir)" />
                    <xsl:variable name="filecount" select="count($ctx/pdx:file)" />
                    Total: <xsl:if test="$dircount &gt; 0"><xsl:value-of select="$dircount" /> directorios,</xsl:if>
                    <xsl:if test="$filecount &gt; 0"><xsl:value-of select="$filecount" /> archivos</xsl:if>
                  </small>
                </td>
              </tr>
            </table>
          </div>
        </div>
        <xsl:call-template name="footer" />
      </body>
    </html>
  </xsl:template>

  <!-- Directorio del código fuente -->
  <xsl:template match="pdx:dir" mode="head">
    <xsl:apply-templates select="parent::pdx:dir" mode="head" />
    <xsl:if test="not(local-name(parent::*) = 'source')">
      <xsl:variable name="link">
        <xsl:for-each select="ancestor-or-self::pdx:dir[not(parent::pdx:source)]">
          <xsl:value-of select="concat(@name, '/')" />
        </xsl:for-each>
      </xsl:variable>
      <li class="separator"><a href="{$base}source/{$link}index.{$extension}"><xsl:value-of select="@name" /></a></li>
    </xsl:if>
  </xsl:template>

  <!-- Contenido del directorio -->
  <xsl:template match="pdx:dir" mode="table">
    <tr>
      <td><a href="{@name}/index.{$extension}"><strong><xsl:value-of select="@name" /></strong></a></td>
      <td>&#160;</td>
      <td>&#160;</td>
    </tr>
  </xsl:template>

  <xsl:template match="pdx:file" mode="table">
    <tr>
      <td><a href="{@name}.{$extension}"><xsl:value-of select="@name" /></a></td>
      <td><xsl:value-of select="pdxf:filesize(@size)" /></td>
      <td><xsl:value-of select="@time" /></td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
