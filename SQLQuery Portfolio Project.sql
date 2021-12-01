Select*
From [Portfolio Project]..['Covid Deaths 1$']
Order by 3,4

Select*
From [Portfolio Project]..['Covid Vaccinations 1$']
Order by 3,4


Select Location, date, total_cases, total_deaths population
From [Portfolio Project]..['Covid Deaths 1$']
Order by 1,2


Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)
From [Portfolio Project]..['Covid Deaths 1$']
Order by 1,2


Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio Project]..['Covid Deaths 1$']
Order by 1,2

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio Project]..['Covid Deaths 1$']
Where Location like '%states%'
Order by 1,2

Select Location, date, total_cases, population, (total_cases/population)*100 as DeathPercentage
From [Portfolio Project]..['Covid Deaths 1$']
Where Location like '%states%'
Order by 1,2

Select continent, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio Project]..['Covid Deaths 1$']
--Where location like '%states%'
Group by continent
Order by PercentPopulationInfected desc

Select continent, Max(Cast(total_deaths as int)) as TotalDeathCount
From [Portfolio Project]..['Covid Deaths 1$']
--Where Location like '%states%'
Where continent is not null
Group by continent
Order by TotalDeathCount desc


Select continent, Max(Cast(total_deaths as int)) as HighestDeathCount
From [Portfolio Project]..['Covid Deaths 1$']
--Where Location like '%states%'
Where continent is not null
Group by continent
Order by HighestDeathCount desc


Select date, Sum(new_cases) as total_cases, Sum(cast(new_deaths as int))as total_deaths, Sum(cast(new_deaths as int))/ Sum(new_cases)*100 as DeathPercentage
From [Portfolio Project]..['Covid Deaths 1$']
--Where Location like '%states%'
where continent is not null
Group by date
Order by 1,2

Select Sum(new_cases) as total_cases, Sum(cast(new_deaths as int))as total_deaths, Sum(cast(new_deaths as int))/ Sum(new_cases)*100 as DeathPercentage
From [Portfolio Project]..['Covid Deaths 1$']
--Where Location like '%states%'
where continent is not null
--Group by date
Order by 1,2

Select*
From [Portfolio Project]..['Covid Deaths 1$'] dea
Join [Portfolio Project]..['Covid Vaccinations 1$'] vac
  on dea.location = vac.location
  and dea.date = vac.date



Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
, SUM(Convert(int,vac.new_vaccinations)) Over (Partition by dea.location Order by dea.location) as RollingPeopleVaccinated
From [Portfolio Project]..['Covid Deaths 1$'] dea 
Join [Portfolio Project]..['Covid Vaccinations 1$'] vac
On dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
Order by 2,3

