# ETL Dynamic Package Solution for AdventureWorks

AdventureWorks is a Microsoft-supplied sample that model a fictitious bicycle company. Microsoft provided the OLTP and the OLAP DW. We will design and implement an ETL project consisting of several packages, with one master package, that load data from different sources. 

### Environment
* Microsoft SQL Server Management Studio 2012 (SSMS)
* Microsoft SQL Server Data Tools

### Problem
We have a folder with several .txt files ('SampleData' folder) with important data that we need to load it into our fact table 'FactCurrencyRates'. Since our 'FactCurrencyRate' table have two primary keys ('CurrencyKey' and 'DateKey') we need to load up those dimensions as well ('DimCurrency' and 'DimDate'). Therefore, our plan is to use a combination of loops, expressions, flat file connection managers, and a data flow to load these files dynamically. 

<p align="center">
  <img width="300" src="Images/Fig1.jpg">
</p>

### Tasks
1. First we add our project connection managers: OLTP AdventureWorks database as well as our staging AdventureWorks DW environment. The SQL code that we used to create our staging environment from our current DW is in the `Script` folder. 
2. In our 'DimDate' package: we only need to add an Execute SQL Task to generate dates using `DimDateSQLQuery` in our SQLStatement. This T-SQL code generates dates from a time frame that we specify. 

<p align="center">
  <img width="200" src="Images/Fig2.jpg">
</p>

3. In our DimCurrency package: we need to add an Execute SQL task specifying our OLTP database because we are going to get our data from a table called Sales.Currency. 
4. In our FactCurrencyRates package: 
* First we add a local Flat File connection manager to all of our .txt `SampleData` which are the ones that we are going to load up. In addiion, it is required to name our columns and select the corresponding data type in our columns. 
* We drag a Foreach Loop Container to our Control Flow tab. We are going to set up a variable (@FilePath) with the path and then use an expression to tie the directory to the variable. In this way, we a centralized spot for all of our configurations. 

<p align="center">
  <img width="400" src="Images/Fig3.jpg">
</p>

* Now, we are going to create a variable @FileRootDir in order to create an expression in our Foreach Loop Container
* In our Currency Connection Manager, we are going to build the expression to iterate with our @FilePath variable. 
* Now, we are going to set our Data FLow inside of our Loop. 

<p align="center">
  <img width="300" src="Images/Fig4.jpg">
</p>

* We are going to do a Lookup in our DW Dim.Currency and we are going to look up the currency key by joining the currency ID to the currency alternate key (pulling out the currency key). 

<p align="center">
  <img width="300" src="Images/Fig5.jpg">
</p>

* We are going to need another lookup for our Date look up which is going to be the Lookup Match Output. 

<p align="center">
  <img width="300" src="Images/Fig6.jpg">
</p>

* Finally we have to put the data in our destination so we drag an OLE DB Destination. The column mapping is the following: 

<p align="center">
  <img width="300" src="Images/Fig7.jpg">
</p>

* The final result is the following Data Flow:

<p align="center">
  <img width="400" src="Images/Fig8.jpg">
</p>

* 
