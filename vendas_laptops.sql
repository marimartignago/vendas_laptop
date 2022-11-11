-- Databricks notebook source
-- MAGIC %md
-- MAGIC - Esse é um projeto feito para fixar o conhecimento sobre SQL, e testar a ferramenta de notebooks no Databricks. 
-- MAGIC - Escolhi um dataset disponível no Kaggle para realizar esse projeto.
-- MAGIC - O objetivo do projeto é discorrer sobre a variação no preço de computadores portáteis (laptops), e também levantar alguns critérios que são indicadores para a venda de laptops.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Análise Descritiva (SQL)** 

-- COMMAND ----------

SELECT * FROM default.cleaned_laptop_data

-- COMMAND ----------

-- MAGIC %md
-- MAGIC - criar uma view para editar colunas;
-- MAGIC - converter o valor do desconto para porcentagem.

-- COMMAND ----------

CREATE VIEW vw_laptops_vendidos as
SELECT * FROM default.cleaned_laptop_data

-- COMMAND ----------

ALTER VIEW vw_laptops_vendidos
as
SELECT *,
(discount/100) as desconto
FROM default.cleaned_laptop_data

-- COMMAND ----------

SELECT * FROM vw_laptops_vendidos

-- COMMAND ----------

-- MAGIC %md
-- MAGIC - converter o valor do preço para Real

-- COMMAND ----------

ALTER VIEW vw_laptops_vendidos
as
SELECT *,
(latest_price * 0.063) as preco_atual_real ,
(old_price * 0.063) as preco_anterior_real
FROM default.cleaned_laptop_data

-- COMMAND ----------

SELECT * FROM vw_laptops_vendidos

-- COMMAND ----------

-- MAGIC %md
-- MAGIC - Média de preço das marcas

-- COMMAND ----------

SELECT
avg(preco_atual_real) as media_preco_atual
FROM vw_laptops_vendidos
GROUP BY brand


-- COMMAND ----------

-- MAGIC %md
-- MAGIC - Corrigindo o nome de uma das marcas
-- MAGIC - Testando algumas ferramentas de visualização de dados.

-- COMMAND ----------

SELECT
CASE WHEN Brand = 'lenovo' THEN 'Lenovo'
      ELSE brand
END AS marca_ajustada, 
avg(preco_atual_real) as media_preco_atual
FROM vw_laptops_vendidos
GROUP BY 
CASE WHEN Brand = 'lenovo' THEN 'Lenovo' 
      ELSE brand
end
      ORDER BY 2 desc

-- COMMAND ----------

-- MAGIC %md - tipo de processador 

-- COMMAND ----------

SELECT DISTINCT processor_name
FROM vw_laptops_vendidos
GROUP BY processor_name



-- COMMAND ----------

-- MAGIC %md
-- MAGIC - tipo de memória ram

-- COMMAND ----------

SELECT ram_type,
avg(preco_atual_real) as media_preco_atual
FROM vw_laptops_vendidos
GROUP BY ram_type
ORDER BY 2 desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC - agrupando as variações de escrita em uma mesma categoria de memória (DDR3, DDR4 e DDR5)

-- COMMAND ----------

SELECT
CASE WHEN ram_type = 'LPDDR3' THEN 'DDR3'
     WHEN ram_type in('LPDDR4', 'LPDDR4X') then 'DDR4'
else ram_type end as tipo_memoria_ajustado,
sum(preco_atual_real) as soma_preco_atual
FROM vw_laptops_vendidos
GROUP BY

CASE WHEN ram_type = 'LPDDR3' THEN 'DDR3'
     WHEN ram_type in('LPDDR4', 'LPDDR4X') then 'DDR4'
else ram_type end
ORDER BY 2 desc

