<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <title>Get Quotes and Search Parts</title>
  </head>
    <body>

    <!-- FORM -->
    <cfform name="DropDown" action="searchandshowquotes.cfm">
        <p>
          Select part from below:
          <cfselect name="partNo">
              <option value='01'>Tub
              <option value='05'>Wheel
              <option value='97'>Box
              <option value='98'>Strut
              <option value='99'>Handle
          </cfselect>
        </p>
      <cfinput type="Submit" name="Submit" value="Submit">
      <cfinput type="Reset" name="Reset" value="Reset">
    </cfform>

  <cfif IsDefined('form.partNo')>

      <!--COMBINED QUERY-->
      <cfquery name="searchPart"
                 datasource="cscie60"
                 username="jlee"
                 password="4525">
              SELECT tbQuote.partNo, tbQuote.vendorNo, vendorName, priceQuote
              FROM tbQuote
                JOIN tbVendor ON tbQuote.vendorNo = tbVendor.vendorNo
              WHERE tbQuote.partNo = '#Form.partNo#'
              GROUP BY tbQuote.partNo, tbQuote.vendorNo, tbVendor.vendorName, tbQuote.priceQuote
      </cfquery>

    <!-- ERROR CHECKING: Part is in the list -->
    <cfif searchPart.partNo IS 0>
      Invalid Part!

    <cfelse>
        <cfquery name="searchQuote"
                 datasource="cscie60"
                 username="jlee"
                 password="4525">
              SELECT tbQuote.partNo, count(tbQuote.vendorNo) as NumberOfQuote
              FROM tbQuote
              WHERE tbQuote.partNo = '#Form.partNo#'
              GROUP BY tbQuote.partNo
       </cfquery>

    <!-- USE SEARCH PART-->
    <h2>Vendor Breakdown</h2>
          <cfoutput>
              <table>
                <tr>
                  <th>Part Number</th>
                  <th>Vendor ID</th>
                  <th>Vendor Name</th>
                  <th>Price Quotes</th>
                </tr>
            </cfoutput>
            <cfoutput query = 'searchPart'>
              <tr>
                 <td>#partNo#</td>
                 <td>#vendorNo#</td>
                 <td>#vendorName#</td>
                 <td>#priceQuote#</td>
             </cfoutput>
         <cfoutput>
             <table>
               <tr>
                 <th>Number of Quotes</th>
               </tr>
           </cfoutput>
            <cfoutput query = 'searchQuote'>
              <td>#NumberOfQuote#</td>
              </tr>
          </cfoutput>

       </cfif>
           <!-- ERROR CHECKING: Less than three quotes -->
          <cfif searchQuote.NumberOfQuote lt 3>
            <h4>  Warning: There are less than three quotes! There must be more to search. </h4>
          </cfif>
       </cfif>
</body>
</html>
