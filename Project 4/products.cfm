<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
    <title>PRODUCTS</title>
  </head>

  <body>
    <cfquery name="getProducts"
              datasource="cscie60"
              username="jlee"
              password="4525">
           SELECT tbProduct.prodNo, tbProduct.prodDesc
           FROM tbProduct
    </cfquery>

   <cfform name="DropDown"  action="products.cfm" method="post">
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
      <h4>
       <a href="ShowComponent.cfm?prodNo=<cfoutput>#Form.prodNo#</cfoutput>">
         Show Components</a>
      <a href="products.cfm">
       Choose another Product</a>
    </h4>
  </cfif>

  </body>
</html>
