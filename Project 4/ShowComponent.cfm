<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
    <title>SHOW COMPONENTS</title>
  </head>
    <body>

        <h4><a href="products.cfm">Oops! You forgot to enter a Product Name</a></h4>

      <cfif IsDefined('form.prodNo')>

        <cfquery name="showComponent"
                 datasource="cscie60"
                 username="jlee"
                 password="4525">
              SELECT tbComponent.prodNo,tbComponent.compNo,tbComponent.partNo,tbComponent.noPartsReq
              FROM tbComponent
              WHERE tbComponent.prodNo = '#Form.prodNo#'
       </cfquery>

      <h5>Component List</h5>
      </tr>

          <cfoutput>
              <table>
                <tr>
                  <th>Product No</th>
                  <th>Component No</th>
                  <th>Parts No</th>
                  <th>Parts Required</th>
                </tr>
            </cfoutput>
            <cfoutput query = 'showComponent'>
              <tr>
                 <td>#prodNo#</td>
                 <td>#compNo#</td>
                 <td>#partNo#</td>
                 <td>#noPartsReq#</td>
             </cfoutput>
       </tr>


      <cfquery name="getComponent"
                 datasource="cscie60"
                 username="jlee"
                 password="4525">
              SELECT tbComponent.prodNo,tbComponent.compNo
              FROM tbComponent
              WHERE tbComponent.prodNo = '#Form.prodNo#'
      </cfquery>


      <cfform name="DropDown"  action="ShowComponent.cfm" method="post">
        <p>
          Select component from below:
          <cfselect name="compNo">
            <cfoutput query="getComponent">
              <option value="#compNo#">#compNo#</option>
            </cfoutput>
          </cfselect>
          <cfinput type="hidden" name="prodNo" value=#prodNo#>
        </p>
      <cfinput type="Submit" name="Submit" Value="Submit" />
      <cfinput type="Reset" name="Reset" value="Reset" />
      </cfform>
      </cfif>

    <!-- RETURN TO PRODUCTS -->
    <cfif IsDefined('form.compNo')>

    <h4>
      <h4>
        <a href="EditComponent.cfm?prodNo=<cfoutput>#Form.prodNo#</cfoutput>?compNo=<cfoutput>#Form.compNo#</cfoutput>">
         Edit Component</a>
      <a href="products.cfm">
       Choose another Product</a>
    </h4>
  </cfif>
  </body>
</html>
