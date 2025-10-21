#Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. 
#Quali considerazioni/ragionamenti è necessario che tu faccia?

#Controlliamo se non ci sono valori NULL

SELECT COUNT(*) AS NullCount
FROM dimproduct
WHERE ProductKey IS NULL;

#Controlliamo se non ci sono duplicati

SELECT ProductKey, COUNT(*) AS count
FROM dimproduct
GROUP BY ProductKey
HAVING COUNT(*) > 1;

#Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.
#Se non restituisce righe, vuol dire che ogni coppia è unica nei dati
SELECT 
    SalesOrderNumber,
    SalesOrderLineNumber,
    COUNT(*) AS count
FROM factresellersales
GROUP BY 
    SalesOrderNumber,
    SalesOrderLineNumber
HAVING COUNT(*) > 1;

#Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.

SELECT 
     OrderDate,
     COUNT(SalesOrderLineNumber) numero_transazioni
FROM 
    factresellersales
GROUP BY OrderDate
HAVING 
      OrderDate IN (SELECT OrderDate
                    FROM factresellersales
                    WHERE OrderDate >= '2020-01-01');
                    

#Calcola il fatturato totale FactResellerSales.SalesAmount), la quantità totale venduta FactResellerSales.OrderQuantity)
#e il prezzo medio di vendita FactResellerSales.UnitPrice) per prodotto DimProduct) a partire dal 1 Gennaio 2020. 
#Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. 
#I campi in output devono essere parlanti.

SELECT
    p.EnglishProductName Name_product,
    SUM(r.OrderQuantity) Quantity_total,
    SUM(r.SalesAmount) Total_Amount,
    AVG(r.UnitPrice) Average_price
FROM
   factresellersales r
JOIN 
   dimproduct p ON r.ProductKey = p.ProductKey
WHERE 
    r.OrderDate >= '2020-01-01'
GROUP BY 
        p.EnglishProductName
ORDER BY r.OrderDate DESC;


#Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity) per Categoria prodotto (DimProductCategory).
#Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. 
#I campi in output devono essere parlanti!

SELECT
     c.EnglishProductCategoryName Category_name,
     SUM(r.OrderQuantity) Quantity_total,
     SUM(r.SalesAmount) Total_amount
FROM 
    factresellersales r
JOIN 
    dimproduct p ON r.ProductKey = p.ProductKey
JOIN 
    dimproductsubcategory sc ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
JOIN 
    dimproductcategory c ON sc.ProductCategoryKey = c.ProductCategoryKey
GROUP BY 
        c.EnglishProductCategoryName
ORDER BY 
        Total_amount DESC;
        
        
#Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
#Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.

SELECT
	g.City City,
    SUM(r.SalesAmount) Total_amount
FROM 
    factresellersales r
JOIN 
      dimgeography g ON r.SalesTerritoryKey = g.SalesTerritoryKey
WHERE
     r.OrderDate >= '2020-01-01'
GROUP BY 
       g.City
HAVING
      Total_amount > 60000
ORDER BY 
        Total_amount DESC;



