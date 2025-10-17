#Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory).

SELECT 
      p.ProductKey,
      p.ProductSubcategoryKey,
      p.EnglishProductName Name_product,
      c.EnglishProductSubcategoryName Name_subcategory
FROM 
     dimproduct p
LEFT JOIN 
		dimproductsubcategory c ON p.ProductSubcategoryKey=c.ProductSubcategoryKey;
        

#Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory).

SELECT 
      p.ProductKey,
      p.ProductSubcategoryKey,
      sc.ProductCategoryKey,
      p.EnglishProductName Name_product,
      c.EnglishProductCategoryName Name_category,
      sc.EnglishProductSubcategoryName Name_subcategory
FROM 
     dimproduct p
LEFT JOIN 
         dimproductsubcategory sc ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
LEFT JOIN
         dimproductcategory c ON c.ProductCategoryKey = sc.ProductCategoryKey;
         
#Esponi lʼelenco dei soli prodotti venduti (DimProduct, FactResellerSales). 

select DISTINCT
p.ProductKey,
p.EnglishProductName Name_Product
FROM dimproduct p
INNER JOIN
		 factresellersales r ON p.ProductKey = r.ProductKey;

# SELECT DISTINCT p.ProductKey,
 #   p.EnglishProductName AS Product_Name
# FROM DimProduct AS p
# WHERE p.ProductKey IN (
#    SELECT r.ProductKey 
#   FROM FactResellerSales AS r );


#Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1).

SELECT 
    p.ProductKey,
    p.EnglishProductName AS ProductName
FROM dimproduct d
WHERE p.FinishedGoodsFlag = 1
  AND p.ProductKey NOT IN (
        SELECT frs.ProductKey
        FROM factresellersales frs
    );

 
#Esponi lʼelenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct)

SELECT
p.ProductKey,
p.EnglishProductName Name_product,
s.OrderDate,
s.OrderQuantity,
s.UnitPrice,
s.SalesAmount
FROM dimproduct p
INNER JOIN factresellersales s ON p.ProductKey =s.ProductKey;

#Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.

SELECT
p.ProductKey,
s.SalesOrderLineNumber,
p.EnglishProductName Name_product,
c.EnglishProductCategoryName Name_category,
s.OrderDate,
s.OrderQuantity,
s.UnitPrice,
s.SalesAmount
FROM factresellersales s
INNER JOIN dimproduct p ON s.ProductKey =p.ProductKey
INNER JOIN dimproductsubcategory sc ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
INNER JOIN dimproductcategory c ON sc.ProductCategoryKey = c.ProductCategoryKey;

#Esplora la tabella DimReseller.
#DESCRIBE dimreseller;
#SELECT * FROM dimreseller;

SELECT
      dr.ResellerKey,
      dr.GeographyKey,
      dr.ResellerName,
      dg.City,
      dg.EnglishCountryRegionName Name_region
FROM 
     dimreseller dr
LEFT JOIN 
         dimgeography dg ON dr.GeographyKey= dg.GeographyKey;
         
#Esponi lʼelenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost.
#Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica.

SELECT
      rs.SalesOrderNumber,
      rs.SalesOrderLineNumber,
      rs.OrderDate,
      dp.EnglishProductName Name_product,
      c.EnglishProductCategoryName Name_category,
      dr.ResellerName,
      dg.City,
      dg.EnglishCountryRegionName Name_region,
      rs.UnitPrice,
      rs.OrderQuantity,
      rs.TotalProductCost
FROM factresellersales rs
INNER JOIN dimproduct dp ON rs.ProductKey = dp.ProductKey
INNER JOIN dimproductsubcategory sc ON dp.ProductSubcategoryKey = sc.ProductSubcategoryKey
INNER JOIN dimproductcategory c ON sc.ProductCategoryKey = c.ProductCategoryKey
INNER JOIN dimreseller dr ON rs.ResellerKey = dr.ResellerKey
INNER JOIN dimgeography dg ON dr.GeographyKey = dg.GeographyKey;


         
         
         
         
         