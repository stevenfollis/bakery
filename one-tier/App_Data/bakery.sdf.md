# SQL Compact Database Readme

This application makes use of a Spatial Data File (`.sdf`) file (https://en.wikipedia.org/wiki/Spatial_Data_File), a variant of SQL Compact. To make edits to the database requires SQL commands and a special application. 

## Tool

The [LINQPad](https://www.linqpad.net/) tool supports editing a `.sdf` file. Download and install, then open the target `.sdf` file that you would like to change (such as the one here in the `App_Data` folder).

## Making Edits

LINQPad operates against the SDF database via a variety of protocols, but SQL is more approachable for basic edits.

Select all records:

```sql
SELECT * FROM Products
```

Insert records:

```sql
/*  SQL Compact doesn't support multiple inserts at one time
    Will need to manually insert each product :( */
INSERT INTO Products (Name, Description, Price, ImageName)
VALUES
	('Blank CD-R', 'Record your favorite mix for long road trips', '19.99', 'blank-cd.jpg');
	('Cell Phone', 'Perfect for high scores on the Snake game', '49.99', 'cell-phone.jpg'),
	('Cordless Phone', 'Battery lasts an impressive 25 minutes', '24.95', 'cordless-phone.jpg'),
    ('CD-ROM Drive', 'Finally a use for all of those AOL trial CDs', '34.99', 'external-cdrom.jpg'),
    ('Gaming System', 'Their last console, your first choice on weekends', '299.99', 'gaming-system.jpg'),
    ('GPS', 'Never fold a paper map again', '59.99', 'gps.jpg'),
    ('MP3 Player', 'Storage space for a whopping 25 songs', '99.99', 'mp3-player.jpg'),
    ('Pager', 'Get a sig'' on your beeper at pager friendly hotels', '84.95', 'pager.jpg'),
    ('PDA', 'Large device, teeny tiny stylus', '149.99', 'pda.jpg'),
    ('Portable CD Player', 'Skips more than kids at recess', '89.95', 'portable-cd-player.jpg')
```

Update a record:

```sql
UPDATE Products
SET ImageName = 'pager.jpg'
WHERE Id = 25;
```

Delete all records:

```sql
DELETE FROM Products;
```