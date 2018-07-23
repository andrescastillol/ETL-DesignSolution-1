WITH DimDateCTE as
(
SELECT CAST(‘2000-01-01’ as DateTime) FullDate
	UNION ALL
SELECT 
	FullDate + 1
FROM 
	DimDateCTE
WHERE 
	FullDate + 1 <= ‘2020-12-31’
)
INSERT INTO [dbo].[DimDate]
SELECT
CAST(CONVERT(CHAR(8),CAST(FullDate as DateTime),112) as INT) as DateKey,
FullDate as FullDateAlternateKey,
DATEPART(dw, FullDate) as DayNumberOfWeek,
DATENAME(dw, FullDate) as EnglishDayNameOfWeek,
' ' as SpanishDayNameOfWeek, 
' ' as FrenchDayNameOfWeek,
DAY(FullDate) as DayNumberOfMonth,
DATEPART(dy, FullDate) as DayNumberOfYear,
DATEPART(wk, FullDate) as WeekNumberOfYear,  
DATENAME(mm, FullDate) as EnglishMonthName,
' ' as SpanishDayNameOfWeek, 
' ' as FrenchDayNameOfWeek, 
MONTH(FullDate) AS MonthNumberOfYear,
DATEPART(qq, FullDate) AS CalendarQuarter,
YEAR(FullDate) AS CalendarYear,
CASE WHEN MONTH(FullDate) >= 1 AND MONTH (FullDate) <=6 THEN 1 ELSE 2 END AS CalendarSemester,
DATEPART(quarter, FullDate) AS FiscalDate,
YEAR(FullDate) AS FiscalYear,
(MONTH(FullDate + 3) / 4) AS FiscalSemester
FROM 
DimDateCTE

OPTION (MAXRECURSION 0)
GO