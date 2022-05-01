use covid;

SELECT 
    *
FROM
    covid_deaths;
    
    
SELECT 
    *
FROM
    covid_vaccination;


SELECT 
    *
FROM
    covid_deaths
WHERE
    continent IS NOT NULL
ORDER BY 3 , 4;



-- Select Data that we are going to be starting with
SELECT 
    Location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM
    Covid_Deaths
WHERE
    continent IS NOT NULL
ORDER BY 1 , 2;



-- Total Cases vs Total Deaths

SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 AS DeathPercentage
FROM
    covid_deaths
WHERE
    location = 'United States'
        AND continent IS NOT NULL
ORDER BY 1 , 2;




SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 AS DeathPercentage
FROM
    covid_deaths
WHERE
    location = 'India'
        AND continent IS NOT NULL
ORDER BY 1 , 2;




SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 AS DeathPercentage
FROM
    covid_deaths
WHERE
    location = 'China'
        AND continent IS NOT NULL
ORDER BY 1 , 2;



-- Total Cases vs Population
SELECT 
    Location,
    date,
    Population,
    total_cases,
    (total_cases / population) * 100 AS PercentPopulationInfected
FROM
    Covid_Deaths
WHERE
    location = 'United States'
        AND continent IS NOT NULL
ORDER BY 1 , 2;



SELECT 
    Location,
    date,
    Population,
    total_cases,
    (total_cases / population) * 100 AS PercentPopulationInfected
FROM
    Covid_Deaths
WHERE
    location = 'India'
        AND continent IS NOT NULL
ORDER BY 1 , 2;



SELECT 
    Location,
    date,
    Population,
    total_cases,
    (total_cases / population) * 100 AS PercentPopulationInfected
FROM
    Covid_Deaths
WHERE
    location = 'China'
        AND continent IS NOT NULL
ORDER BY 1 , 2;




-- Countries with Highest Infection Rate compared to Population
SELECT 
    Location,
    Population,
    MAX(total_cases) AS Highest_Infection_Count,
    MAX((total_cases / population)) * 100 AS Percent_Population_Infected
FROM
    Covid_Deaths
WHERE
    location = 'United States'
GROUP BY Location , Population
ORDER BY Percent_Population_Infected DESC;


SELECT 
    Location,
    Population,
    MAX(total_cases) AS Highest_Infection_Count,
    MAX((total_cases / population)) * 100 AS Percent_Population_Infected
FROM
    Covid_Deaths
WHERE
    location = 'India'
GROUP BY Location , Population
ORDER BY Percent_Population_Infected DESC;


SELECT 
    Location,
    Population,
    MAX(total_cases) AS Highest_Infection_Count,
    MAX((total_cases / population)) * 100 AS Percent_Population_Infected
FROM
    Covid_Deaths
WHERE
    location = 'China'
GROUP BY Location , Population
ORDER BY Percent_Population_Infected DESC;



-- Countries with Highest Death Count per Population

SELECT 
    Location, MAX(total_deaths) AS Total_Death_Count
FROM
    Covid_Deaths
WHERE
    location = 'United States'
        AND continent IS NOT NULL
GROUP BY Location
ORDER BY Total_Death_Count DESC;



SELECT 
    Location, MAX(total_deaths) AS Total_Death_Count
FROM
    Covid_Deaths
WHERE
    location = 'India'
        AND continent IS NOT NULL
GROUP BY Location
ORDER BY Total_Death_Count DESC;



SELECT 
    Location, MAX(total_deaths) AS Total_Death_Count
FROM
    Covid_Deaths
WHERE
    location = 'China'
        AND continent IS NOT NULL
GROUP BY Location
ORDER BY Total_Death_Count DESC;



-- Showing contintents with the highest death count per population

SELECT 
    continent, MAX(Total_deaths) AS Total_Death_Count
FROM
    Covid_Deaths
GROUP BY continent
ORDER BY Total_Death_Count DESC;




-- GLOBAL NUMBERS

SELECT 
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    SUM(new_deaths) / SUM(New_Cases) * 100 AS DeathPercentage
FROM
    Covid_Deaths
WHERE
    location = 'India'
        AND continent IS NOT NULL
ORDER BY 1 , 2;




SELECT 
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    SUM(new_deaths) / SUM(New_Cases) * 100 AS DeathPercentage
FROM
    Covid_Deaths
WHERE
    location = 'China'
        AND continent IS NOT NULL
ORDER BY 1 , 2;




SELECT 
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    SUM(new_deaths) / SUM(New_Cases) * 100 AS DeathPercentage
FROM
    Covid_Deaths
WHERE
    location = 'United States'
        AND continent IS NOT NULL
ORDER BY 1 , 2;




SELECT 
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    SUM(new_deaths) / SUM(New_Cases) * 100 AS DeathPercentage
FROM
    Covid_Deaths
WHERE
    location = 'India'
        AND continent IS NOT NULL
ORDER BY 1 , 2;




SELECT 
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    SUM(new_deaths) / SUM(New_Cases) * 100 AS DeathPercentage
FROM
    Covid_Deaths
WHERE
    location = 'China'
        AND continent IS NOT NULL
ORDER BY 1 , 2;




-- Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From Covid_Deaths dea
Join Covid_Vaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3;



-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From Covid_Deaths dea
Join Covid_Vaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac;
