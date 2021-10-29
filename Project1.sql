select * from PortfolioProject ..CovidDeaths;

--SELECT Location, date , total_cases, new_cases, total_deaths,population_density
--select date from PortfolioProject ..CovidDeaths



----Total cases vs Total Deaths
SELECT Location, date , total_cases, total_deaths,population,(total_deaths/total_cases)*100
AS DeathRate
from PortfolioProject ..CovidDeaths
WHERE location = 'Burkina faso'
ORDER BY 1,2;


---Total Cases vs populaton
SELECT Location, date , total_cases,population,(total_cases/population)*100
AS InfectionRate
from PortfolioProject ..CovidDeaths
WHERE location = 'Burkina faso'
ORDER BY 1,2;

--Most Infection rate countries vs population
SELECT Location,population, MAX(total_cases)AS HighestInfectionCount, MAx((total_cases/population))*100
AS PocentagePopulationInfected
from PortfolioProject ..CovidDeaths
GROUP BY location, population
ORDER BY PocentagePopulationInfected desc

--Countries With highest Death
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject ..CovidDeaths
WhERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount desc

--By continent
SELECT location,MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject ..CovidDeaths
WhERE continent is  null
GROUP BY location
ORDER BY TotalDeathCount desc

--CGlobal numbers
SELECT Location, date , total_cases, total_deaths,population,(total_deaths/total_cases)*100
AS DeathRate
from PortfolioProject ..CovidDeaths

ORDER BY 1,2;

--Vaccinations tables
SELECT * 
FROM PortfolioProject ..CovidDeaths dth
JOIN PortfolioProject..CovidVaccinations vac
	on dth.location = vac.location
	and dth.date= vac.date

	--total population vs Vaccination
SELECT dth.continent, dth.date, dth.population, vac.new_vaccinations
FROM PortfolioProject ..CovidDeaths dth
JOIN PortfolioProject..CovidVaccinations vac
	on dth.location = vac.location
	and dth.date= vac.date
	where dth.continent is not null
	ORDER BY 2,3

	---rolling count
SELECT dth.continent, dth.date, dth.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) over (Partition by dth.location ORDER BY dth.location
,dth.date) as RollingVaccinationCount

FROM PortfolioProject ..CovidDeaths dth
JOIN PortfolioProject..CovidVaccinations vac
	on dth.location = vac.location
	and dth.date= vac.date
	where dth.continent is not null
	ORDER BY 2,3


	--CReate View
	CREATE VIEW TotalDeathCount as
	SELECT location,MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject ..CovidDeaths
WhERE continent is  null
GROUP BY location
--ORDER BY TotalDeathCount desc