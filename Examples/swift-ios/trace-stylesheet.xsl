<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
  <html>
  <body>
  <h2>Trace</h2>
  <xsl:for-each select="trace-query-result/node">
    <table border="1">
      <tr bgcolor="#9acd32">
        <xsl:for-each select="schema/col">
          <th><xsl:value-of select="name"/></th>  
        </xsl:for-each>
        <!-- <th>Title</th>
        <th>Artist</th>
        <th>Country</th>
        <th>Company</th>
        <th>Price</th>
        <th>Year</th> -->
      </tr>
      <xsl:for-each select="row">
      <tr>
        <xsl:for-each select="./*">
          <td>
            <xsl:value-of select="./@fmt"/> <br/>
            <!-- <xsl:element name="{local-name()}">
                <xsl:value-of select="@fmt"/>
            </xsl:element> -->
           </td>
          </xsl:for-each>  
        <!-- <td><xsl:value-of select="title"/></td>
        <td><xsl:value-of select="artist"/></td>
        <td><xsl:value-of select="country"/></td>
        <td><xsl:value-of select="company"/></td>
        <td><xsl:value-of select="price"/></td>
        <td><xsl:value-of select="bar:year"/></td> -->
      </tr>
      </xsl:for-each>
    </table>
  </xsl:for-each>
  </body>
  </html>
</xsl:template>
</xsl:stylesheet>