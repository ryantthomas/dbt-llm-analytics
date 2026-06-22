# 3. Staging models

Staging models clean one source each. Nothing fancy. Rename, cast, handle nulls, dedupe.

There are four, one per seed: `stg_species`, `stg_observations`, `stg_parks`, `stg_conservation_categories`.

## Views, not tables

Staging models are materialized as **views**. A view is just a saved query — it does not store data, it runs against the seeds each time. That keeps them cheap and always fresh. The marts, which do real work, are stored as tables. This is set in `dbt_project.yml`.

## stg_species: a real cleaning job

The raw species data has two problems, and `stg_species.sql` fixes both.

**Problem 1: blank conservation status.** Most species have an empty status. Empty does not mean unknown here — it means the species is not at risk. So we fill blanks with `Least Concern`.

**Problem 2: duplicate species.** Some species appear in several rows with different common-name spellings ("Redtop" vs "Black Bent, Redtop, Water Bentgrass"). 5,824 rows, but only 5,541 distinct species names.

So we group by `scientific_name`, combine the common names, and keep one row per species:

```sql
select
    scientific_name,
    any_value(category) as category,
    string_agg(distinct common_names, '; ') as common_names,
    coalesce(max(nullif(conservation_status, '')), 'Least Concern') as conservation_status
from {{ ref('species_info') }}
group by scientific_name
```

We also add an `is_at_risk` flag — true if the species is Endangered, Threatened, or In Recovery. The marts use it constantly, so we compute it once here.

`{{ ref('species_info') }}` is how dbt links models. It points at the seed and tells dbt to build that first.

## Run them

```bash
dbt run --profiles-dir .
```

Next: [04-mart-models.md](04-mart-models.md)
