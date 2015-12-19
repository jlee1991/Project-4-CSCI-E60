-- ******************************************************
--    SPOOL SESSION
-- ******************************************************

spool 2015ps4.lst

-- ******************************************************
-- ViIEW TABLES
-- ******************************************************

SELECT * FROM tbShipment;
SELECT * FROM tbQuote;
SELECT * FROM tbVendor;
SELECT * FROM tbComponent;
SELECT * FROM tbPart;
SELECT * FROM tbProduct;

-- ******************************************************
-- PROJECT 1 - TRIGGER TO ENSURE ENTITY INTEGRITY
-- ******************************************************

CREATE or REPLACE trigger TR_new_shipment_IN
   /* trigger executes BEFORE an INSERT into the SHIPMENT table */
   before insert on tbShipment
   /* trigger executes for each ROW being inserted */
   for each row

   /* begins a PL/SQL Block */
   begin
      /* get the next value of the PK sequence and today’s date */
      SELECT seq_shipment.nextval, sysdate
         /* insert them into the :NEW ROW columns */
           into :new.shipmentNo, :new.shipmentDate
            FROM dual;
   end TR_new_shipment_IN;
.
/

INSERT INTO tbShipment (vendorNo, partNo, quantity)
values ('123', '01', 5);

INSERT INTO tbShipment (vendorNo, partNo, quantity)
values ('225', '99', 5);

SELECT * FROM tbShipment;
