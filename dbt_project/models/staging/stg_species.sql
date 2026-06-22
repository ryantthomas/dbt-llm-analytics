-- The raw NPS data has multiple rows for some species (same scientific_name,
-- different common name spellings). We dedupe to one row per species here,
-- combining the common names and keeping a real conservation status when one exists.

with source as (
    select * from {{ ref('species_info') }}
),

deduped as (
    select
        scientific_name,
        any_value(category) as category,
        string_agg(distinct common_names, '; ') as common_names,
        coalesce(max(nullif(conservation_status, '')), 'Least Concern') as conservation_status
    from source
    group by scientific_name
)

select
    scientific_name,
    category,
    common_names,
    conservation_status,
    conservation_status in ('Endangered', 'Threatened', 'In Recovery') as is_at_risk
from deduped
