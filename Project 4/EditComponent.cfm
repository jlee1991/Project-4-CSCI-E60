<html>
  <head>
    <title>EDIT COMPONENT</title>
  </head>
    <body>

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
           <cfform action="EditComponent.cfm" method="post">
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

    <!-- RETURN TO COMPONENTS / PRODUCTS -->
      <h4>
        <a href="ShowComponent.cfm?prodNo=<cfoutput>#Form.prodNo#</cfoutput>">
         Choose another Task</a>
         &nbsp;&nbsp;|&nbsp;&nbsp;
        <a href="products.cfm">
         Choose another Product</a>
      </h4>
    </body>
  </html>

  <!--    <a href="showprojectsandtasks.cfm?projectno=<cfoutput>#Form.projectno#</cfoutput>">
         Choose another Task</a>-->
