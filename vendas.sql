
alter view vw_notebooks_vendidos 
as
select *,
(preco_atual * 0.063)as preco_atual_real ,
(preco_anterior * 0.063) as preco_anterior_real,
(disconto/100) as desconto
from notebooks_vendidos


select
case when marca ='lenovo' then 'Lenovo' 
     else marca 
end as marca_ajustada , 
avg(preco_atual_real) as media_preco_atual
from vw_notebooks_vendidos
group by 
case when marca ='lenovo' then 'Lenovo' 
     else marca 
end
order by 2 desc

select
case when tipo_memoria ='LPDDR3' then 'DDR3'
     when tipo_memoria in('LPDDR4','LPDDR4X') then 'DDR4'
else tipo_memoria end as tipo_memoria_ajustado, 
sum(preco_atual_real) as soma_preco_atual
from vw_notebooks_vendidos
group by 
 
case when tipo_memoria ='LPDDR3' then 'DDR3'
     when tipo_memoria in('LPDDR4','LPDDR4X') then 'DDR4'
else tipo_memoria end
 
order by 2 desc