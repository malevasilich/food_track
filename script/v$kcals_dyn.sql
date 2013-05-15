 create or replace view v$kcals_dyn as 
 select date::date dt, sum(f.kkal/100*weight) as kcals
 from food_tracks ft, foods f
 where ft.food_id=f.id
 group by dt
 having date::date in
  ( select distinct date::date from food_tracks where extract(hour from date)>=20-6 )
 order by dt desc;
