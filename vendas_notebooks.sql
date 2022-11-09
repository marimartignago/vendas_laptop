-- Databricks notebook source
-- MAGIC %md
-- MAGIC Análise Descritiva (SQL)

-- COMMAND ----------

SELECT * FROM laptop_data

-- COMMAND ----------

-- MAGIC %md
-- MAGIC - criar uma view para editar algumas colunas
-- MAGIC - converter o valor do desconto para porcentagem.

-- COMMAND ----------

CREATE VIEW vw_notebooks_vendidos as
SELECT * FROM laptop_data

-- COMMAND ----------

ALTER VIEW vw_notebooks_vendidos
as
SELECT *,
(discount/100) as desconto
FROM laptop_data

-- COMMAND ----------

SELECT * FROM vw_notebooks_vendidos

-- COMMAND ----------

-- MAGIC %md
-- MAGIC - converter o valor do preço para Real

-- COMMAND ----------

ALTER VIEW vw_notebooks_vendidos
as
SELECT *,
(latest_price * 0.063) as preco_atual_real ,
(old_price * 0.063) as preco_anterior_real
FROM laptop_data

-- COMMAND ----------

SELECT * FROM vw_notebooks_vendidos

-- COMMAND ----------

-- MAGIC %md
-- MAGIC - Média de preço das marcas

-- COMMAND ----------

SELECT
avg(preco_atual_real) as media_preco_atual
FROM vw_notebooks_vendidos
GROUP BY brand


-- COMMAND ----------

-- MAGIC %md
-- MAGIC - Corrigindo o nome de uma das marcas

-- COMMAND ----------

SELECT
CASE WHEN Brand = 'lenovo' THEN 'Lenovo'
      ELSE brand
END AS marca_ajustada, 
avg(preco_atual_real) as media_preco_atual
FROM vw_notebooks_vendidos
GROUP BY 
CASE WHEN Brand = 'lenovo' THEN 'Lenovo' 
      ELSE brand
end
      ORDER BY 2 desc

-- COMMAND ----------


