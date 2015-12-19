-- ******************************************************
-- 2015ps3.sql
--
-- Loader for PS-3 Database
--
-- Description:	This script contains the DDL to load
--              the tables of the
--              INVENTORY database
--
-- There are 6 tables on this DB
--
-- Author:  Maria R. Garcia Altobello
--
-- Student:  Jim Lee
--
-- Date:   October, 2015
--
-- ******************************************************

-- ******************************************************
--    SPOOL SESSION
-- ******************************************************

spool 2015ps3.lst

-- ******************************************************
--    DROP TABLES
-- Note:  Issue the appropiate commands to drop tables
-- ******************************************************

DROP table tbShipment purge;
DROP table tbQuote purge;
DROP table tbVendor purge;
DROP table tbComponent purge;
DROP table tbPart purge;
DROP table tbProduct purge;

-- ******************************************************
--    DROP SEQUENCES
-- Note:  Issue the appropiate commands to drop sequences
-- ******************************************************

DROP sequence seq_shipment;

-- ******************************************************
--    CREATE TABLES
-- ******************************************************

-- PART table
CREATE table tbPart (
        partNo          char(2)                 not null
          constraint pk_part primary key
          constraint rg_partNo check (partNo between 01 and 99),
        partDesc       varchar2(15)            not null,
        quantityOnHand  number(8,0)             not null
          constraint rg_quantityOnHand check (quantityOnHand between 0 and 1000)
);

-- PRODUCT table
CREATE table tbProduct (
        prodNo          char(3)                 not null
          constraint pk_product primary key,
        prodDesc     varchar2(15)            not null,
        schedule        number(2,0)             not null
);

-- COMPONENT table
CREATE table tbComponent (
        prodNo          char (3)                not null
          constraint fk_prodNo_tbComponent references tbProduct (prodNo) on delete cascade,
        compNo          char (2)                not null
          constraint rg_compNo check (compNo between 01 and 10),
        partNo          char (2)                null
          constraint fk_partNo_tbComponent references tbPart (partNo),
        noPartsReq      number (2,0)            default 1     not null
          constraint rg_noPartsReq check (noPartsReq between 1 and 10),
        constraint pk_component primary key (prodNo, compNo)
);

-- VENDOR table
CREATE table tbVendor (
        vendorNo        char(3)                 not null
          constraint pk_vendorNo primary key
          constraint rg_vendorNo check (vendorNo between 100 and 999),
        vendorName      varchar2(25)            not null,
        vendorCity      varchar2(15)            null
);

-- QUOTE table
CREATE table tbQuote (
        vendorNo        char(3)                 not null
          constraint fk_vendorNo_tbQuote references tbVendor (vendorNo),
        partNo          char(2)                 not null
          constraint fk_partNo_tbQuote references tbPart (partNo) on delete cascade,
        priceQuote      number(11,2)            default 0     not null
          constraint rg_priceQuote check (priceQuote >= 0),
        constraint pk_quote primary key (vendorNo, partNo)
);

-- SHIPMENT table
CREATE table tbShipment (
        shipmentNo      number (11,0)           not null
          constraint pk_shipmentNo primary key,
        vendorNo        char (3)                not null,
        partNo          char (2)                not null,
        quantity        number (4,0)            default 1
          constraint rg_quantity check (quantity between 1 and 1000),
        shipmentDate    date                    default CURRENT_DATE     not null,
        constraint fk_vendorNo_partNo_tbShipment
          foreign key (vendorNo, partNo) references tbQuote (vendorNo, partNo)
);

-- ******************************************************
--    CREATE SEQUENCES
-- ******************************************************

CREATE sequence seq_shipment
    increment by 1
    start with 1;

-- ******************************************************
--    POPULATE TABLES
--
-- Note:  Follow instructions and data provided on PS-3
--        to populate the tables
-- ******************************************************

/* inventory tbPart */
INSERT INTO tbPart values('01', 'Tub', 10);
INSERT INTO tbPart values('05', 'Wheel', 45);
INSERT INTO tbPart values('97', 'Box', 15);
INSERT INTO tbPart values('98', 'Strut', 15);
INSERT INTO tbPart values('99', 'Handle', 55);

/* inventory tbProduct */
INSERT INTO tbProduct values ('100', 'Cart', 3);
INSERT INTO tbProduct values ('101', 'Wheelbarrow', 3);

/* inventory tbComponent */
INSERT INTO tbComponent values ('100', '01', '05', 2);
INSERT INTO tbComponent values ('100', '02', '97', 1);
INSERT INTO tbComponent values ('100', '03', '98', 1);
INSERT INTO tbComponent values ('100', '04', '99', 1);
INSERT INTO tbComponent values ('101', '01', '05', 1);
INSERT INTO tbComponent values ('101', '02', '97', 2);
INSERT INTO tbComponent values ('101', '03', '98', 1);
INSERT INTO tbComponent values ('101', '04', '99', 2);

/* inventory tbVendor */
INSERT INTO tbVendor values ('123', 'FirstOne', 'Boston');
INSERT INTO tbVendor values ('225', 'SomeStuff', 'Cambridge');
INSERT INTO tbVendor values ('747', 'LastChance', 'Belmont');
INSERT INTO tbVendor values ('909', 'IHaveIt', 'Boston');

/* inventory tbQuote */
INSERT INTO tbQuote values ('123', '01', 50);
INSERT INTO tbQuote values ('123', '98', 20);
INSERT INTO tbQuote values ('225', '99', 20);
INSERT INTO tbQuote values ('747', '05', 28);
INSERT INTO tbQuote values ('909', '01', 40);
INSERT INTO tbQuote values ('909', '05', 30);
INSERT INTO tbQuote values ('909', '97', 60);
INSERT INTO tbQuote values ('909', '98', 22);
INSERT INTO tbQuote values ('909', '99', 22);

/* inventory tbShipment */
INSERT INTO tbShipment values (seq_shipment.nextval, '123', '01', 2, to_date('10-01-2015','mm-dd-yyyy'));
INSERT INTO tbShipment values (seq_shipment.nextval, '747', '05', 5, to_date('10-02-2015','mm-dd-yyyy'));
INSERT INTO tbShipment values (seq_shipment.nextval, '909', '97', 2, to_date('10-03-2015','mm-dd-yyyy'));
INSERT INTO tbShipment values (seq_shipment.nextval, '123', '98', 5, to_date('10-07-2015','mm-dd-yyyy'));
INSERT INTO tbShipment values (seq_shipment.nextval, '225', '99', 1, to_date('10-07-2015','mm-dd-yyyy'));

-- ******************************************************
--    VIEW TABLES
--
-- Note:  Issue the appropiate commands to show your data
-- ******************************************************

SELECT * FROM tbComponent;
SELECT * FROM tbPart;
SELECT * FROM tbProduct;
SELECT * FROM tbQuote;
SELECT * FROM tbShipment;
SELECT * FROM tbVendor;

-- ******************************************************
--    QUALITY CONTROLS
--
-- Note:  Test only 2 constraints of each of
--        the following types:
--        *) Entity integrity
--        *) Referential integrity
--        *) Column constraints
-- ******************************************************

/*Entity Integrity*/
--Inserting a Duplicate PK
INSERT INTO tbProduct values ('100','Dup. prodNo', 5);
 --Inserting a NULL PK
INSERT INTO tbProduct values (null, 'NULL Primary Key', 5);

/*Referential Integrity*/
 --Inserting a FK which does not match a PK
INSERT INTO tbComponent values ('103', '01', '05', 2);
 --Deleting a PK with existing FK
DELETE from tbPart WHERE partNo = '05';

/*Column Constraints*/
 --Violating a Column Constraint
 -- INSERT INTO tbShipment values (seq_shipment.nextval, '123', '01', 2000, to_date('10-01-2015','mm-dd-yyyy'));
 --Violating a Column Constraint
INSERT INTO tbQuote values ('123', '97', -10);

-- ******************************************************
-- SQL STATEMENTS
-- ******************************************************

--Query 1
SELECT partDesc FROM tbPart
WHERE partNo IN
  (
    SELECT partNo FROM tbComponent
    GROUP BY partNo
    HAVING count(partNo)>1
  );


--Query 2
SELECT prodDesc FROM tbProduct, tbPart
WHERE tbPart.partNo IN
  (
    SELECT partNo FROM tbPart
    WHERE partDesc LIKE '%Box%'
  );

--Query 3
SELECT tbPart.partNo, partDesc, count(*) "number of quotes" FROM tbPart
WHERE tbPart.partNo =
  (
    SELECT partNo FROM tbQuote
    GROUP BY partNo
    HAVING count(vendorNo)<2
  )
GROUP BY partNo, partDesc;

--Query 4
SELECT tbQuote.vendorNo, vendorName, partNo, MIN(priceQuote) "price quote"
FROM tbQuote, tbVendor
GROUP BY partNo, tbQuote.vendorNo, tbVendor.vendorName;

--Query 5
SELECT prodNo, compNo, tbComponent.partNo, partDesc
FROM tbComponent, tbPart
WHERE tbComponent.partNo = tbPart.partNo
order by prodNo;

--Query 6
SELECT a.vendorName, b.vendorName, a.vendorcity
FROM tbVendor a, tbVendor b
WHERE a.vendorcity = b.vendorcity
AND a.vendorName != b.vendorName;

--Query 7
SELECT partDesc, ROUND((quantityOnhand/(sum(tbComponent.noPartsReq)*3)),1) "Weeks_left"
FROM tbPart
INNER JOIN tbComponent
ON tbComponent.partNo = tbPart.partNo
GROUP BY tbComponent.partNo, partDesc, quantityOnHand, tbComponent.noPartsReq;

-- ******************************************************
--    END SESSION
-- ******************************************************

spool off
