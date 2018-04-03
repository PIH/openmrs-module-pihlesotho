DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`gen_seq_paperf_no`$$
CREATE PROCEDURE `openmrs`.`gen_seq_paperf_no`(
_prefix char(2)
, _size int(5)
)
BEGIN

-- create the table that will store a sequential list
drop table if exists gen_seq_paperf_no_tmp;
create temporary table gen_seq_paperf_no_tmp (
 `gspnt_id` int not null AUTO_INCREMENT,
 `paperf_no_seq` char(7) DEFAULT NULL,
  PRIMARY KEY(`gspnt_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

select 0 into @counter;

START TRANSACTION;

while @counter < _size
do
   insert into gen_seq_paperf_no_tmp (`paperf_no_seq`)
   values (CONCAT(_prefix, LPAD(@counter:=@counter+1, 5, '0')));

end while;

COMMIT;

ALTER TABLE `gen_seq_paperf_no_tmp` ADD INDEX ( paperf_no_seq );

END$$

DELIMITER ;