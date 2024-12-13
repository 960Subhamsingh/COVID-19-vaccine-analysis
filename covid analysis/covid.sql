-- show databases

show databases;
-- use covid19 databases
use covid19;

-- show table in exitsing of covid19 databases
show tables;
-- select all the row and column in covid existing table
SELECT 
    *
FROM
    covid;
    
-- show how many  enter in each location of  covid table 
SELECT 
    COUNT(*), location
FROM
    covid
GROUP BY location;  
 
-- Select Data that we are going to be starting with
SELECT 
    Location,
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

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT 
    Location,
    date,
    total_cases,
    total_deaths,
    ROUND((total_deaths / total_cases) * 100) AS Death_percentage
FROM
    covid
WHERE
    location LIKE '%Somalia%'
        AND continent IS NOT NULL
ORDER BY 1 , 2;

-- Looking at total cases vs total deaths of location  'Trinidad and Tobago'

SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    new_cases,
    concat(round((total_deaths / total_cases)*100,2) ,'%') AS Death_Percenatge
FROM
    covid
WHERE
    location LIKE '%Trinidad and Tobago'
ORDER BY 1 , 2;

 -- Remove the date from our filter so we can see the totals
 
SELECT 
    SUM(new_cases) AS total_cases,
    SUM(CAST(new_deaths AS SIGNED)) AS total_deaths,
    concat(round(SUM(CAST(new_deaths AS SIGNED)) / SUM(new_cases) * 100,2) ,'%' )AS DeathPercentage
FROM
    covid
WHERE
    continent IS NOT NULL
ORDER BY 1 , 2;

-- Countries with Highest Infection Rate compared to Population

SELECT 
    location,
    population,
    MAX(total_cases) AS Highest_Infection,
    concat(round(MAX((total_cases / population)) * 100,2), '%') AS Infected_people
FROM
    covid
GROUP BY location , population
ORDER BY Infected_people;
 
 -- Countries with Highest Death Count per Population

Select Location, MAX(cast(Total_deaths as signed)) as Totaldeathcount
From  covid
-- Where location like '%states%'
Where continent is not null 
Group by location
order by TotalDeathCount desc;

-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population
SELECT 
    continent,
    MAX(CAST(Total_deaths AS SIGNED)) AS Totaldeathcount
FROM
    covid
WHERE
    continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- GLOBAL NUMBERS

SELECT 
    SUM(new_cases) AS total_cases,
    SUM(CAST(new_deaths AS SIGNED)) AS total_deaths,
    concat(ROUND(SUM(CAST(new_deaths AS SIGNED)) / SUM(New_Cases) * 100,2),'%') AS DeathPercentage
FROM
    Covid
WHERE
    continent IS NOT NULL
ORDER BY 1 , 2;

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select continent, location, date, population, new_vaccinations
, SUM(CONVERT(int, new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
,(RollingPeopleVaccinated/population)*100
From covid;
-- Join PortfolioProject..CovidVaccinations vac
-- 	On dea.location = vac.location
-- 	and dea.date = vac.date
-- where dea.continent is not null 
-- order by 2,3;


-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null ;


select location, date, total_cases, total_deaths, new_cases, population from covid order by 6;


SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    CONCAT(ROUND((total_deaths / total_cases) * 100, 2),
            '%') AS DeathPercentage
FROM
    covid
WHERE
    location LIKE '%States%'
        AND continent IS NOT NULL
ORDER BY 2 DESC;

 
 
 