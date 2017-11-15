-- --------------------------------------------------------------------------------
-- mise_a_jour_commande Group Routines
-- --------------------------------------------------------------------------------
DELIMITER $$

create procedure mise_a_jour_commande()
begin
	
	declare c_historique_commande cursor for select no_commande, date_commande, pizzeria.id, heure_livraison 
												from Historique_commande order by no_commande, date_commande for update;
												
	declare v_duree_limite int(45);
	declare v_no_commande int;
	declare v_id int;
	declare v_heure time;
	declare v_date datetime;

	open c_historique_commande;

	Loop  
		fetch c_historique_commande
		into v_no_commande, v_id, v_heure, v_date;

		if convert(time, getdate()) - convert(time,v_heure) > convert(time,v_duree_limite) then
			
			insert into Archive values (null, getdate(),v_no_commande,v_date, v_id);
			delete from Historique_commande where current of c_historique_commande;
		else 
			insert into Erreurs values (3200,'Suppression automatique de la commande ' || v_no_commande || ' impossible');

		end if;
	end loop;
	close c_historique_commande;
end
$$