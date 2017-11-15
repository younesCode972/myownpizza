-- --------------------------------------------------------------------------------
-- suppression Group Routines
-- --------------------------------------------------------------------------------
DELIMITER $$
create procedure suppresion_archive()
begin
	if date(sysdatetime()) = 1 then
		delete from Archive;
	end if;
end;
$$