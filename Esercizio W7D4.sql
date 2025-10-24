#Implementa una vista denominata Product al fine di creare unʼanagrafica (dimensione) prodotto completa. 
#La vista, se interrogata o utilizzata come sorgente dati, deve esporre il nome prodotto, il nome della sottocategoria associata e il nome della categoria associata.

CREATE VIEW Product AS (
SELECT
    p.EnglishProductName Name_product,
    c.EnglishProductCategoryName Name_category,
    sc.EnglishProductSubcategoryName Name_subcategory
FROM dimproduct p
INNER JOIN
	 dimproductsubcategory sc ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
INNER JOIN 
     dimproductcategory c ON sc.ProductCategoryKey = c.ProductCategoryKey);


#Implementa una vista denominata Reseller al fine di creare unʼanagrafica (dimensione) reseller completa.
#La vista, se interrogata o utilizzata come sorgente dati, deve esporre il nome del reseller, il nome della città e il nome della regione.

CREATE VIEW Resseler AS (
SELECT
    r.ResellerName,
    g.City,
    g.EnglishCountryRegionName Region_name
FROM 
   dimreseller r
JOIN
   dimgeography g ON r.GeographyKey = g.GeographyKey);


#Crea una vista denominata Sales che deve restituire la data dellʼordine, il codice documento,
# la riga di corpo del documento, la quantità venduta, lʼimporto totale e il profitto.

CREATE VIEW Sales AS (
SELECT
     rs.SalesOrderLineNumber,
     rs.SalesOrderNumber,
     rs.OrderDate,
     rs.OrderQuantity,
     rs.TotalProductCost,
     rs.SalesAmount,
     (rs.SalesAmount-rs.TotalProductCost) Profitto
FROM factresellersales rs );







