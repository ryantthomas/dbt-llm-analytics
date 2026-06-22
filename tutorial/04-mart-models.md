# 4. Mart models

Marts are the payoff. Each one answers a question. They join the staging models and aggregate, and they are stored as real tables.

There are three.

## wildlife_by_park

One row per park. Total observations, broken down by animal group, plus at-risk counts.

Answers: *Which park has the most wildlife activity?*

Real result after building:

```
Yellowstone National Park            1,443,562
Yosemite National Park                 863,332
Bryce National Park                    576,025
Great Smoky Mountains National Park    431,820
```

## conservation_summary

One row per conservation status. How many species, and how many observations, at each risk level.

Answers: *How many species are endangered, and how often are they seen?*

```
Least Concern        5,362 species
Species of Concern     151 species
Endangered              14 species
Threatened              10 species
In Recovery              4 species
```

## species_spotlight

One row per wildlife species (plants excluded), ordered by how often it was seen, with its conservation status and how many parks it lives in.

Answers: *What are the most-observed animals, and are any of them at risk?*

## A note on the join

`wildlife_by_park` joins observations to species to parks. The join is on names, so the names have to match exactly. The raw data calls one park "Bryce National Park" — so the parks seed has to use that exact string, or the park silently disappears from the results. Small detail, real bug. Clean join keys matter.

```bash
dbt run --profiles-dir .
```

Next: [05-testing-and-docs.md](05-testing-and-docs.md)
