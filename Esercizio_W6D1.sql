 #Connettersi al database
Use AdventureWorksDW;

#Esplora la tabelle dei prodotti

 SELECT * 
 FROM dimproduct ;
 
# Interroga la tabella dei prodotti  ed esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag

SELECT 
	Productkey,
    Productalternatekey,
    Englishproductname,
    Color,
    Standardcost,
    Finishedgoodsflag
 FROM dimproduct;
 
 #Partendo dalla query scritta nel passaggio precedente, esponi in output i soli prodotti finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1.
 
 SELECT 
	Productkey,
    Productalternatekey,
    Englishproductname,
    Color,
    Standardcost,
    Finishedgoodsflag
 FROM dimproduct
 WHERE Finishedgoodsflag = 1;

#Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello ProductAlternateKey) comincia con FR oppure BK.
#Il result set deve contenere il codice prodotto ProductKey), il modello, il nome del prodotto.il costo standard e il prezzo listino.
 
 SELECT
   Productkey,
   Productalternatekey,
   StandardCost,
   ListPrice,
   EnglishProductName,
   ModelName
 FROM dimproduct
 WHERE ProductAlternateKey LIKE 'FR%' OR 'BK%' ;
 
 #Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dallʼazienda (ListPrice - StandardCost)
 
 SELECT
   Productkey,
   Productalternatekey,
   EnglishProductName,
   ModelName, 
   StandardCost,
   ListPrice,
   (ListPrice-StandardCost) AS Markup
 FROM dimproduct
 WHERE ProductAlternateKey LIKE 'FR%' OR 'BK%'
 ORDER BY Markup DESC ;
 
 #Scrivi unʼaltra query al fine di esporre lʼelenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000.
 
 SELECT 
   Productkey,
   EnglishProductName,
   FinishedGoodsFlag,
   ListPrice
FROM dimproduct
WHERE  ListPrice BETWEEN 1000 AND 2000;

#Esplora la tabella degli impiegati aziendali (DimEmployee)

SELECT * FROM dimemployee;

SELECT 
EmployeeKey,
FirstName,
LastName
FROM dimemployee
WHERE SalesPersonFlag = 1;
   
 #Interroga la tabella delle vendite (FactResellerSales).
 #Esponi in output lʼelenco delle transazioni registrate a partire dal 1 gennaio 2020 dei soli codici prodotto: 597, 598, 477, 214. 
 #Calcola per ciascuna transazione il profitto SalesAmount - TotalProductCost).
 
SELECT 
 f.Productkey,
 p.EnglishProductName,
 f.OrderDate,
 (f.SalesAmount - f.TotalProductCost) AS Markup
FROM factresellersales AS f
JOIN dimproduct AS p ON f.Productkey=p.Productkey
WHERE 
  OrderDate >= '2020-01-01'
  AND f.Productkey IN (597, 598, 477, 214);

 
 
 
 