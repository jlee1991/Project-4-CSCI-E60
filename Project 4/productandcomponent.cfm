<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
    <title>Get Product Number and Search Component</title>
  </head>
    <body>

    <!-- FORM -->

       <cfquery name="getProducts"
                 datasource="cscie60"
                 username="jlee"
                 password="4525">
              SELECT tbProduct.prodNo, tbProduct.prodDesc
              FROM tbProduct
       </cfquery>


    <cfform name="DropDown"  action="productandcomponent.cfm" method=post>
        <p>
          Select product from below:
          <cfselect name="prodNo">
            <cfoutput query="getProducts">
              <option value="#prodNo#">#prodDesc#</option>
            </cfoutput>
          </cfselect>
        </p>
      <cfinput type="Submit" name="Submit" Value="Submit" />
      <cfinput type="Reset" name="Reset" value="Reset" />
    </cfform>

      <cfif IsDefined('form.prodNo')>


        <cfquery name="showComponent"
                 datasource="cscie60"
                 username="jlee"
                 password="4525">
              SELECT tbComponent.prodNo,tbComponent.compNo,tbComponent.partNo,tbComponent.noPartsReq
              FROM tbComponent
              WHERE tbComponent.prodNo = '#Form.prodNo#'
       </cfquery>


     <h5>Component List </h5>
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


  <cfform name="DropDown"  action="productandcomponent.cfm" method=post>
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

      <cfif IsDefined('form.compNo')>

      <cfquery name="selectPart"
                 datasource="cscie60"
                 username="jlee"
                 password="4525">
              SELECT tbComponent.partNo, tbComponent.noPartsReq
              FROM tbComponent
              WHERE tbComponent.prodNo = '#Form.prodNo#'
              AND tbComponent.compNo = '#Form.compNo#'
      </cfquery>

       <p>
         <cfoutput>
           <table>
                <tr>
                  <th>Parts No &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</th>
                  <th>Parts Required</th>
                </tr>
           </table>
           </cfoutput>
           <cfform action="productandcomponent.cfm" method="post">
           <table>
               <tr>
               <cfoutput query = 'selectPart'>
               <td> <cfinput type="text" name="partNo" value="#partNo#"></td>
               <td> <cfinput type="text" name="noPartsReq" value="#noPartsReq#"> </td>
             </cfoutput>
          </p>
             <cfinput type="Submit" name="Update" Value="Update" />
             <cfinput type="Reset" name="Reset" value="Reset" />
            </cfform>
             </tr>
         </table>
          <cfif IsDefined('Form.partNo')>
           Ready to update

          <cfquery name="updateTask"
                  datasource="cscie60"
                  username="jlee"
                  password="4525">
            UPDATE tbComponent
            SET tbComponent.partNo = '#Form.partNo#',
            tbComponent.noPartsReq = #Form.noPartsReq#
            WHERE tbComponent.prodNo = '#Form.prodNo#'
            AND tbComponent.compNo = '#Form.compNo#'
         </cfquery>

       </cfif>

   </cfif>

</body>
</html>
