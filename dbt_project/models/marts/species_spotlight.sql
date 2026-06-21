with species as (
    select * from {{ ref('stg_species') }}
),

obs as (
    select * from {{ ref('stg_observations') }}
)

select
    s.scientific_name,
    s.common_names,
    s.category,
    s.conservation_status,
    s.is_at_risk,
    count(distinct o.park_name) as parks_present,
    sum(o.observations) as total_observations
from species s
join obs o on s.scientific_name = o.scientific_name
where s.category not in ('Vascular Plant', 'Nonvascular Plant')
group by
    s.scientific_name,
    s.common_names,
    s.category,
    s.conservation_status,
    s.is_at_risk
order by total_observations desc
