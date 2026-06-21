with parks as (
    select * from {{ ref('stg_parks') }}
),

obs as (
    select * from {{ ref('stg_observations') }}
),

species as (
    select * from {{ ref('stg_species') }}
),

joined as (
    select
        p.park_name,
        p.park_code,
        p.state,
        p.established_year,
        p.area_km2,
        s.category,
        s.is_at_risk,
        o.observations
    from obs o
    join species s on o.scientific_name = s.scientific_name
    join parks p on o.park_name = p.park_name
)

select
    park_name,
    park_code,
    state,
    established_year,
    area_km2,
    count(distinct case when category != 'Vascular Plant' and category != 'Nonvascular Plant' then joined.park_name || '-' || category end) as wildlife_category_count,
    count(distinct joined.park_name || '-' || category) as total_category_count,
    sum(observations) as total_observations,
    sum(case when category = 'Mammal' then observations else 0 end) as mammal_observations,
    sum(case when category = 'Bird' then observations else 0 end) as bird_observations,
    sum(case when category = 'Fish' then observations else 0 end) as fish_observations,
    sum(case when category = 'Amphibian' then observations else 0 end) as amphibian_observations,
    sum(case when category = 'Reptile' then observations else 0 end) as reptile_observations,
    count(distinct case when is_at_risk then joined.park_name || '-' || joined.category end) as at_risk_category_count
from joined
group by park_name, park_code, state, established_year, area_km2
order by total_observations desc
