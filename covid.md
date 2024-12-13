## Covid Data analysis with Mysql
- 2. how many rows we have in each table
```
SELECT COUNT(*)
FROM covid
```
```
+----------+
| COUNT(*) |
+----------+
|    15347 |
+----------+
```
- 2. looking at all the data
```
SELECT * FROM covid;
```

- 3. Select the data that we are going to be using, and order by location and date (i.e. 1,2)
```
SELECT 
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM
    covid
WHERE
    continent IS NOT NULL
ORDER BY 1 , 2;
```
```
+----------------------+----------+-------------+-----------+--------------+------------+
| location             | date     | total_cases | new_cases | total_deaths | population |
+----------------------+----------+-------------+-----------+--------------+------------+
| Afghanistan          | 01-01-21 |       51526 |         0 | 2191         |   38928341 |
| Afghanistan          | 01-02-21 |       55059 |        36 | 2404         |   38928341 |
| Afghanistan          | 01-03-20 |           1 |         0 |              |   38928341 |
| Afghanistan          | 01-03-21 |       55733 |        19 | 2444         |   38928341 |
| Afghanistan          | 01-04-20 |         197 |        22 | 4            |   38928341 |
| Afghanistan          | 01-05-20 |        2291 |       164 | 68           |   38928341 |
| Afghanistan          | 01-06-20 |       15753 |       545 | 266          |   38928341 |
| Afghanistan          | 01-07-20 |       31826 |       319 | 780          |   38928341 |
| Afghanistan          | 01-08-20 |       36700 |        35 | 1285         |   38928341 |
| Afghanistan          | 01-09-20 |       38193 |        34 | 1407         |   38928341 |
| Afghanistan          | 01-10-20 |       39285 |        17 | 1460         |   38928341 |
| Afghanistan          | 01-11-20 |       41501 |        76 | 1538         |   38928341 |
| Afghanistan          | 01-12-20 |       46516 |       242 | 1822         |   38928341 |
| Afghanistan          | 02-01-21 |       51526 |         0 | 2191         |   38928341 |
| Afghanistan          | 02-02-21 |       55121 |        62 | 2405         |   38928341 |
```
- 4. Look at Total Cases vs Total Deaths
```
SELECT 
    location,
    total_cases,
    total_deaths,
    CONCAT(ROUND((total_deaths / total_cases) * 100, 2),
            '%') AS DeathPercentage
FROM
    covid
WHERE
    continent IS NOT NULL
ORDER BY  DeathPercentage desc;
```
```
+----------------------+-------------+--------------+-----------------+
| location             | total_cases | total_deaths | DeathPercentage |
+----------------------+-------------+--------------+-----------------+
| Spain                |      148220 | 14792        | 9.98%           |
| Spain                |      285430 | 28443        | 9.96%           |
| Spain                |      141942 | 14045        | 9.89%           |
| Sudan                |         162 | 16           | 9.88%           |
| United Kingdom       |      425769 | 42025        | 9.87%           |
| Spain                |      288522 | 28445        | 9.86%           |
| Spain                |      288522 | 28445        | 9.86%           |
| Spain                |      288522 | 28445        | 9.86%           |
| Sweden               |       49030 | 4814         | 9.82%           |
| Spain                |      136675 | 13341        | 9.76%           |
| United Kingdom       |      431819 | 42060        | 9.74%           |
| Sweden               |       12432 | 1203         | 9.68%           |
| United Kingdom       |       66738 | 6452         | 9.67%           |
| Sweden               |       50367 | 4854         | 9.64%           |
| United Kingdom       |      437519 | 42077        | 9.62%           |
| Spain                |      131646 | 12641        | 9.6%            |
| Spain                |      297054 | 28472        | 9.58%           |
| United Kingdom       |       61422 | 5882         | 9.58%           |
| United Kingdom       |      441575 | 42090        | 9.53%           |
| Zimbabwe             |          42 | 4            | 9.52%           |
| Zimbabwe             |          42 | 4            | 9.52%           |
| Sweden               |       51409 | 4874         | 9.48%           |
| Spain                |      126168 | 11947        | 9.47%           |
| United States        |          74 | 7            | 9.46%           |
| Spain                |      302814 | 28498        | 9.41%           |
| United Kingdom       |      448731 | 42162        | 9.4%            |
| Sweden               |       51827 | 4874         | 9.4%            |
| Spain                |      119199 | 11198        | 9.39%           |
| Tanzania             |          32 | 3            | 9.38%           |
| Tanzania             |          32 | 3            | 9.38%           |
| Tanzania             |          32 | 3            | 9.38%           |
| Sweden               |        6475 | 605          | 9.34%           |
| Spain                |      305767 | 28499        | 9.32%           |
| Sweden               |       52511 | 4891         | 9.31%           |
| Sudan                |         140 | 13           | 9.29%           |
| United Kingdom       |      455848 | 42233        | 9.26%           |
```


- 5. look at the Total Cases vs Total Deaths for the United States, ordered by Date descending
  - Shows the likelihood of dying if you contract covid in the United States

```
SELECT location, date, total_cases, total_deaths, concat(round((total_deaths/total_cases)*100,2),'%') as DeathPercentage
FROM covid
WHERE location LIKE '%States%'
  AND continent is not NULL
ORDER BY 2 DESC;
```
```
+---------------+----------+-------------+--------------+-----------------+
| location      | date     | total_cases | total_deaths | DeathPercentage |
+---------------+----------+-------------+--------------+-----------------+
| United States | 31-12-20 |    20099363 | 352093       | 1.75%           |
| United States | 31-10-20 |     9165619 | 231733       | 2.53%           |
| United States | 31-08-20 |     6026895 | 183802       | 3.05%           |
| United States | 31-07-20 |     4567420 | 154147       | 3.37%           |
| United States | 31-05-20 |     1798718 | 107833       | 5.99%           |
| United States | 31-03-21 |    30462210 | 552495       | 1.81%           |
| United States | 31-03-20 |      192301 | 5369         | 2.79%           |
| United States | 31-01-21 |    26247053 | 449341       | 1.71%           |
| United States | 31-01-20 |           8 |              | 0%              |
| United States | 30-12-20 |    19863696 | 348613       | 1.76%           |
| United States | 30-11-20 |    13670332 | 270996       | 1.98%           |
| United States | 30-10-20 |     9075924 | 230823       | 2.54%           |
| United States | 30-09-20 |     7235428 | 207201       | 2.86%           |
| United States | 30-08-20 |     5991507 | 183260       | 3.06%           |
| United States | 30-07-20 |     4498701 | 152910       | 3.4%            |
| United States | 30-06-20 |     2642174 | 127600       | 4.83%           |
```

- 6. Look at Total Cases vs Population in the United States, ordered by date descending
  - Shows the percentage of the population that got Covid

```
SELECT 
    location,
    date,
    population,
    total_cases,
    concat(round((total_cases / population) * 100,2), '%') AS Percent_Population
FROM
    covid
WHERE
    location LIKE '%United States%'
        AND continent IS NOT NULL
ORDER BY 2 DESC;
```

```
+---------------+----------+------------+-------------+--------------------+
| location      | date     | population | total_cases | Percent_Population |
+---------------+----------+------------+-------------+--------------------+
| United States | 31-12-20 |  331002647 |    20099363 | 6.07%              |
| United States | 31-10-20 |  331002647 |     9165619 | 2.77%              |
| United States | 31-08-20 |  331002647 |     6026895 | 1.82%              |
| United States | 31-07-20 |  331002647 |     4567420 | 1.38%              |
| United States | 31-05-20 |  331002647 |     1798718 | 0.54%              |
| United States | 31-03-21 |  331002647 |    30462210 | 9.20%              |
| United States | 31-03-20 |  331002647 |      192301 | 0.06%              |
| United States | 31-01-21 |  331002647 |    26247053 | 7.93%              |
| United States | 31-01-20 |  331002647 |           8 | 0.00%              |
| United States | 30-12-20 |  331002647 |    19863696 | 6.00%              |
| United States | 30-11-20 |  331002647 |    13670332 | 4.13%              |
| United States | 30-10-20 |  331002647 |     9075924 | 2.74%              |
| United States | 30-09-20 |  331002647 |     7235428 | 2.19%              |
```
- 7. Look at Total Cases vs Population in the  United States, ordered by date descending
  - Shows the percentage of the population that got Covid
```
SELECT 
    location,
    date,
    population,
    total_cases,
    concat(round((total_cases / population) * 100,2), '%') AS Percent_Population
FROM
    covid
WHERE
    location = 'Canada' or
    location LIKE '%Canada%' 
        AND continent IS NOT NULL
ORDER BY 2 DESC;
```
- 8. Look at countries with highest infection rate compared to population for each country, ordered by descending PercentPopulationInfected

```
  SELECT
        location,
        population,
        max(total_cases) as Highest_infection_count,
        concat(round(max(total_cases/population)*100,2),'%') as Infect_percent
     from covid 
     group by location, population
     order by Infect_percent desc;
```
```
+----------------------+------------+-------------------------+----------------+
| location             | population | Highest_infection_count | Infect_percent |
+----------------------+------------+-------------------------+----------------+
| United States        |  331002647 |                32346971 | 9.77%          |
| Sweden               |   10099270 |                  973604 | 9.64%          |
| Switzerland          |    8654618 |                  659974 | 7.63%          |
| Spain                |   46754783 |                 3524077 | 7.54%          |
| United Kingdom       |   67886004 |                 4432246 | 6.53%          |
| South America        |  430759772 |                24878216 | 5.78%          |
| Turkey               |   84339067 |                 4820591 | 5.72%          |
| Uruguay              |    3473727 |                  198428 | 5.71%          |
| United Arab Emirates |    9890400 |                  520236 | 5.26%          |
| Ukraine              |   43733759 |                 2124070 | 4.86%          |
| Vatican              |        809 |                      27 | 3.34%          |
| South Africa         |   59308690 |                 1581210 | 2.67%          |
| Tunisia              |   11818618 |                  309119 | 2.62%          |
| Slovenia             |    2078932 |                  240292 | 11.56%         |
| Suriname             |     586634 |                   10363 | 1.77%          |
```

- 9. Show countries with Highest Death Count per Population

```
SELECT 
    location, continent, MAX(total_deaths) AS TotalDeathCount
FROM
    covid
WHERE
    continent IS NOT NULL
GROUP BY location , continent
ORDER BY TotalDeathCount DESC;
```

```
+----------------------+---------------+-----------------+
| location             | continent     | TotalDeathCount |
+----------------------+---------------+-----------------+
| Tunisia              | Africa        | 9993            |
| Switzerland          | Europe        | 9988            |
| South Africa         | Africa        | 998             |
| Syria                | Asia          | 998             |
| Venezuela            | South America | 997             |
| Afghanistan          | Asia          | 996             |
| United States        | North America | 99571           |
| Turkey               | Asia          | 9950            |
| Ukraine              | Europe        | 995             |
| Zambia               | Africa        | 991             |
| Somalia              | Africa        | 99              |
| Sri Lanka            | Asia          | 99              |
| Uganda               | Africa        | 99              |
| Thailand             | Asia          | 99              |
| United Kingdom       | Europe        | 98723           |
```

- 10. Show the continents with the highest death count per population

```
SELECT 
    continent, MAX(total_deaths) AS TotalDeathCount
FROM
    covid
WHERE
    continent IS NOT NULL
GROUP BY location , continent
ORDER BY TotalDeathCount DESC;

```
```
+---------------+-----------------+
| continent     | TotalDeathCount |
+---------------+-----------------+
| Africa        | 9993            |
| Europe        | 9988            |
| Africa        | 998             |
| Asia          | 998             |
| South America | 997             |
| Asia          | 996             |
| North America | 99571           |
| Asia          | 9950            |
| Europe        | 995             |
| Africa        | 991             |
| Africa        | 99              |
| Asia          | 99              |
| Africa        | 99              |
| Asia          | 99              |
```

- 11. New cases and deaths reported on the current date

``` 
SELECT 
    date,
    SUM(new_cases) AS total_cases,
    SUM(CAST(new_deaths AS SIGNED)) AS total_deaths,
    SUM(CAST(new_deaths AS SIGNED)) / SUM(new_cases) * 100 AS DeathPercentage
FROM
    covid
GROUP BY date;
```

```
+----------+-------------+--------------+-----------------+
| date     | total_cases | total_deaths | DeathPercentage |
+----------+-------------+--------------+-----------------+
| 24-02-20 |         236 |            2 |          0.8475 |
| 25-02-20 |         156 |            2 |          1.2821 |
| 26-02-20 |         300 |            2 |          0.6667 |
| 27-02-20 |         523 |            1 |          0.1912 |
| 28-02-20 |         617 |            0 |          0.0000 |
| 29-02-20 |         861 |            4 |          0.4646 |
| 01-03-20 |         688 |            2 |          0.2907 |
| 02-03-20 |         720 |           16 |          2.2222 |
| 03-03-20 |        1009 |            2 |          0.1982 |
| 04-03-20 |         654 |           12 |          1.8349 |
| 05-03-20 |         694 |            3 |          0.4323 |
| 06-03-20 |         953 |           12 |          1.2592 |
```
