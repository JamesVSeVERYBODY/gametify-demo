CREATE DATABASE IF NOT EXISTS `online_games` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `online_games`;

CREATE TABLE Product (
    Product_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(255) NOT NULL,
    pro_name VARCHAR(255),
    price DECIMAL(19 , 4 )
);

INSERT into Product values(NULL,'games','Grand Theft Auto',400.00);
INSERT into Product values(NULL,'games','Grand Theft Auto',400.00);
INSERT into Product values(NULL,'games','Call duty Ghosts',900.00);
INSERT into Product values(NULL,'games','FarCry Primal',1400.00);
INSERT into Product values(NULL,'games','Division',2000.00);
INSERT into Product values(NULL,'games','Dirt Rally',1400.00);
INSERT into Product values(NULL,'games','Counter Strike',437.00);
INSERT into Product values(NULL,'games','Mario',400.00);
INSERT into Product values(NULL,'games','Battlefield',400.00);

CREATE TABLE Games
(
    Games_id Integer PRIMARY KEY,
    games_name varchar(255),
    min_memory_size Integer,
    max_no_players Integer,
    details varchar(255),
    console_fk INTEGER,
    FOREIGN KEY (Games_id)
        REFERENCES Product (product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT into Games values(1004, 'Grand Theft Auto',16,32,'version 5',1000);
INSERT into Games values(1005, 'Grand Theft Auto',8,16,'version 3',1001);
INSERT into Games values(1006, 'Call duty ghosts',3,12,'version 2',1003);
INSERT into Games values(1007, 'FarCry Primal',8,15,'version 3',1000);
INSERT into Games values(1008, 'Division',35,100,'version 3',1002);
INSERT into Games values(1009, 'Dirt Rally',18,15,'version 3',1000);
INSERT into Games values(1010, 'Counter Strike',8,8,'latest version 11',1000);
INSERT into Games values(1011, 'Mario',8,15,'version 5',1002);
INSERT into Games values(1012, 'Battlefield',8,15,'version 15',1003);

INSERT into Games values(1026, 'FarCry Primal',8,15,'version 4',1003);
INSERT into Games values(1027, 'Division',35,100,'version 3',1000);
INSERT into Games values(1028, 'Dirt Rally',18,15,'version 3',1003);
INSERT into Games values(1029, 'Counter Strike',8,8,'latest version 11',1003);
INSERT into Games values(1030, 'Mario',8,15,'version 5',1000);
INSERT into Games values(1031, 'Battlefield',8,15,'version 16',1000);

SELECT * FROM Games;

CREATE TABLE customer_orders
(
    order_id Integer PRIMARY KEY AUTO_INCREMENT,
    date_order date,
    product Integer,
    product_count Integer,
    customer Integer,
    order_status varchar(255),
    FOREIGN KEY (customer)
        REFERENCES customer (customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product)
        REFERENCES Product (product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

insert into customer_orders values(NULL,'2016-02-25',1006,2,104,"aborted");
insert into customer_orders values(NULL,'2016-05-23',1017,3,104,"ordered");
insert into customer_orders values(NULL,'2016-05-22',1011,1,103,"ordered");
insert into customer_orders values(NULL,'2016-05-14',1021,4,103,"delivered");
insert into customer_orders values(NULL,'2016-05-23',1017,1,102,"ordered");
insert into customer_orders values(NULL,'2016-05-21',1016,1,103,"ordered");
insert into customer_orders values(NULL,'2016-05-27',1031,1,111,"delivered");
insert into customer_orders values(NULL,'2016-05-14',1021,2,113,"delivered");
insert into customer_orders values(NULL,'2016-05-23',1017,1,109,"ordered");
insert into customer_orders values(NULL,'2016-06-21',1026,2,102,"ordered");
insert into customer_orders values(NULL,'2016-05-14',1021,2,113,"delivered");

SELECT * FROM customer_orders;

CREATE TABLE Product_inventory (
    Product_id INTEGER PRIMARY KEY,
    product_count INTEGER,
    FOREIGN KEY (Product_id)
        REFERENCES Product (product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE Product_inventory
ADD constraint CHECK(product_count>0) ;

insert into Product_inventory values(1000, 25);
insert into Product_inventory values(1001, 25);
insert into Product_inventory values(1002, 25);
insert into Product_inventory values(1003, 25);
insert into Product_inventory values(1004, 25);
insert into Product_inventory values(1005, 25);
insert into Product_inventory values(1006, 25);
insert into Product_inventory values(1007, 25);
insert into Product_inventory values(1008, 25);
insert into Product_inventory values(1009, 25);
insert into Product_inventory values(1010, 25);
insert into Product_inventory values(1011, 25);
insert into Product_inventory values(1012, 25);
insert into Product_inventory values(1013, 25);
insert into Product_inventory values(1014, 25);
insert into Product_inventory values(1015, 25);
insert into Product_inventory values(1016, 25);
insert into Product_inventory values(1017, 25);
insert into Product_inventory values(1018, 25);
insert into Product_inventory values(1019, 25);
insert into Product_inventory values(1020, 25);
insert into Product_inventory values(1021, 25);
insert into Product_inventory values(1022, 25);
insert into Product_inventory values(1023, 25);
insert into Product_inventory values(1024, 25);
insert into Product_inventory values(1025, 25);
insert into Product_inventory values(1026, 25);
insert into Product_inventory values(1027, 25);
insert into Product_inventory values(1028, 25);
insert into Product_inventory values(1029, 25);
insert into Product_inventory values(1030, 25);
insert into Product_inventory values(1031, 25);

insert into Product_inventory values(1034, 25);
select * from Product_inventory;

/*WRITE TRIGGERS FOR INSERT/ UPDATE INTO CUSTOMER ORDERS, WHEN STATUS = ORDERED SO 
THAT IT DECREMENTS COUNT FROM PRODUCT_INVENTORY FOR THAT PRODUCT
WITH THE CONDITION THAT IF STATUS IS UPDATED TO ABORT, IT SHOULD INCREMENT THE COUNT BACK
AS THE PLACED ORDER IS NOW ABORTED,
NO CHANGES TO BE MADE IF STATUS = */
/*Also if the count of order made is less than available, transaction shouldn't get through*/
DROP TRIGGER prod_order_insert;
DROP TRIGGER prod_order_update;


/* No trigger for aborted during insertion bcz new order with aborted status simply means no change to database  */
delimiter |
CREATE TRIGGER prod_order_insert BEFORE INSERT ON customer_orders
FOR EACH ROW
BEGIN
	
	UPDATE Product_inventory set product_count = product_count - new.product_count where  Product_inventory.Product_id = New.product AND New.order_status ='ordered';
	UPDATE Product_inventory set product_count = product_count - new.product_count where  Product_inventory.Product_id = New.product AND New.order_status ='delivered';
END;
|
delimiter ;

/* 
 update when there is change of product count  or when there is an order status change. I am assuming that changes should be made only when \
order status will be changed from ordered to aborted, or from aborted to ordered or delivered. No one will make a change from delivered to ordered/aborted    */
delimiter |
CREATE TRIGGER prod_order_update BEFORE UPDATE  ON customer_orders
FOR EACH ROW
BEGIN
if OLD.product_count <> new.product_count  Then
	UPDATE Product_inventory set product_count = product_count - new.product_count + OLD.product_count where  Product_inventory.Product_id = New.product;

elseif OLD.order_status <> new.order_status Then
	if OLD.order_status = 'ordered' Then
		UPDATE Product_inventory set product_count = product_count + new.product_count  where  Product_inventory.Product_id = New.product AND New.order_status ='aborted';

    elseif OLD.order_status = 'aborted'  Then
		UPDATE Product_inventory set product_count = product_count - new.product_count where  Product_inventory.Product_id = New.product AND New.order_status ='delivered';
        UPDATE Product_inventory set product_count = product_count - new.product_count where  Product_inventory.Product_id = New.product AND New.order_status ='ordered';
    end if;

	
end if;

END;
|
delimiter ;
