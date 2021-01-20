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

  <xsl:param name="title" select="'Información'" />

  <xsl:import href="functions.xsl"/>
  <xsl:import href="components.xsl" />

  <xsl:output method="xml" indent="yes" encoding="UTF-8" />

  <xsl:template match="/">
    <html lang="es">
      <xsl:call-template name="head" />
      <body class="all-info">
        <div class="container">

          <xsl:call-template name="nav" />
          <xsl:call-template name="head-info" />

          <div id="mainstage" class="row">
            <xsl:choose>
              <xsl:when test="//pdx:enrichment[@type='phploc']">
                <xsl:call-template name="phploc" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="missing" />
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </div>
        <xsl:call-template name="footer" />
      </body>
    </html>
  </xsl:template>

  <xsl:template name="missing">
    <div class="unavailable col-md-12">
      <p><strong>Advertencia:</strong> PHPLoc no ha sido activado o no se ha encontrado el archivo phploc.xml.</p>
    </div>
  </xsl:template>

  <xsl:template name="phploc">
    <xsl:variable name="phploc" select="//pdx:enrichment[@type='phploc']" />

    <h1 class="col-md-12">Visión General</h1>
    <div class="col-md-6">
      <div>
        <h2>Estructura</h2>
        <table class="styled overview">
          <tr>
            <td>Namespaces</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:namespaces" /></td>
            <td />
          </tr>
          <tr>
            <td>Interfaces</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:interfaces" /></td>
            <td />
          </tr>
          <tr>
            <td>Traits</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:traits" /></td>
            <td />
          </tr>
          <tr>
            <td>Clases</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:classes" /></td>
            <td />
          </tr>
          <tr>
            <td class="indent">Clases abstratas</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:abstractClasses" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:abstractClasses div $phploc/pdx:classes * 100, '0.##')" />%)</td>
          </tr>
          <tr>
            <td class="indent">Clases concretas</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:concreteClasses" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:concreteClasses div $phploc/pdx:classes * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td>Métodos</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:methods" /></td>
            <td />
          </tr>
          <tr>
            <td class="indent">Alcance</td>
            <td />
            <td />
          </tr>
          <tr>
            <td class="indent2">Métodos no estáticos</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:nonStaticMethods" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:nonStaticMethods div $phploc/pdx:methods * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td class="indent2">Métodos estáticos</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:staticMethods" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:staticMethods div $phploc/pdx:methods * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td class="indent">Visibilidad</td>
            <td />
            <td />
          </tr>
          <tr>
            <td class="indent2">Métodos públicos</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:publicMethods" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:publicMethods div $phploc/pdx:methods * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td class="indent2">Métodos no públicos</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:nonPublicMethods" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:nonPublicMethods div $phploc/pdx:methods * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td>Funciones</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:functions" /></td>
            <td />
          </tr>
          <tr>
            <td class="indent">Funciones nombradas</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:namedFunctions" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:namedFunctions div $phploc/pdx:functions * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td class="indent">Funciones anónimas</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:anonymousFunctions" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:anonymousFunctions div $phploc/pdx:functions * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td>Constantes</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:constants" /></td>
            <td />
          </tr>
          <tr>
            <td class="indent">Constantes Globales</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:globalConstants" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:globalConstants div $phploc/pdx:constants * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td class="indent">Constantes de Clase</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:classConstants" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:classConstants div $phploc/pdx:constants * 100,'0.##')" />%)</td>
          </tr>
        </table>
      </div>
      <div>
        <h2>Tests</h2>
        <table class="styled overview">
          <tr>
            <td>Clases</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:testClasses" /></td>
            <td class="percent"/>
          </tr>
          <tr>
            <td>Métodos</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:testMethods" /></td>
            <td class="percent"/>
          </tr>
        </table>
      </div>
    </div>

    <div class="col-md-6">
      <div>
        <h2>Tamaño</h2>
        <table class="styled overview">
          <tr>
            <td>Líneas de código (LOC)</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:loc" /></td>
            <td/>
          </tr>
          <tr>
            <td>Líneas de código comentadas (CLOC)</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:cloc" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:cloc div $phploc/pdx:loc * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td>Líneas de código sin comentar (NCLOC)</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:ncloc" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:ncloc div $phploc/pdx:loc * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td>Líneas lógicas de código (LLOC)</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:lloc" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:lloc div $phploc/pdx:loc * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td>Clases</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:llocClasses" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:llocClasses div $phploc/pdx:lloc * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td class="indent">Longitud media de la clase</td>
            <td class="nummeric"><xsl:value-of select="round($phploc/pdx:classLlocAvg)" /></td>
            <td/>
          </tr>
          <tr>
            <td class="indent">Longitud media del método</td>
            <td class="nummeric"><xsl:value-of select="round($phploc/pdx:methodLlocAvg)" /></td>
            <td/>
          </tr>
          <tr>
            <td>Funciones</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:llocFunctions" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:llocFunctions div $phploc/pdx:lloc * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td class="indent">Longitud media de la función</td>
            <td class="nummeric"><xsl:value-of select="round($phploc/pdx:llocByNof)" /></td>
            <td/>
          </tr>
          <tr>
            <td>No en clases o funciones</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:llocGlobal" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:llocGlobal div $phploc/pdx:lloc * 100,'0.##')" />%)</td>
          </tr>
        </table>
      </div>

      <div>
        <h2>Complejidad</h2>
        <table class="styled overview">
          <tr>
            <td>Complejidad ciclomática / LLOC</td>
            <td class="nummeric"><xsl:value-of select="pdxf:format-number($phploc/pdx:ccnByLloc, '0.##')" /></td>
            <td class="percent"/>
          </tr>
          <tr>
            <td>Complejidad ciclomática / Número de métodos</td>
            <td class="nummeric"><xsl:value-of select="pdxf:format-number($phploc/pdx:ccnByNom, '0.##')" /></td>
            <td class="percent"/>
          </tr>
        </table>
      </div>

      <div>
        <h2>Dependencias</h2>
        <table class="styled overview">
          <tr>
            <td>Accesos Globales</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:globalAccesses" /></td>
            <td />
          </tr>
          <tr>
            <td class="indent">Constantes Globales</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:globalConstantAccesses" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:globalConstantAccesses div $phploc/pdx:globalAccesses * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td class="indent">Variables Globales</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:globalVariableAccesses" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:globalVariableAccesses div $phploc/pdx:globalAccesses * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td class="indent">Variables Super-Globales</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:superGlobalVariableAccesses" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:superGlobalVariableAccesses div $phploc/pdx:globalAccesses * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td>Accesos a atributos</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:attributeAccesses" /></td>
            <td />
          </tr>
          <tr>
            <td class="indent">No estáticos</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:instanceAttributeAccesses" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:instanceAttributeAccesses div $phploc/pdx:attributeAccesses * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td class="indent">Estáticos</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:staticAttributeAccesses" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:staticAttributeAccesses div $phploc/pdx:attributeAccesses * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td>Llamadas a métodos</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:methodCalls" /></td>
            <td />
          </tr>
          <tr>
            <td class="indent">No estáticos</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:instanceMethodCalls" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:instanceMethodCalls div $phploc/pdx:methodCalls * 100,'0.##')" />%)</td>
          </tr>
          <tr>
            <td class="indent">Estáticos</td>
            <td class="nummeric"><xsl:value-of select="$phploc/pdx:staticMethodCalls" /></td>
            <td class="percent">(<xsl:value-of select="pdxf:format-number($phploc/pdx:staticMethodCalls div $phploc/pdx:methodCalls * 100,'0.##')" />%)</td>
          </tr>
        </table>
      </div>

    </div>
  </xsl:template>

</xsl:stylesheet>
