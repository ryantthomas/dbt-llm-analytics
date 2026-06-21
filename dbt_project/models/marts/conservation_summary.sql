with species as (
    select * from {{ ref('stg_species') }}
),

obs as (
    select * from {{ ref('stg_observations') }}
),

cats as (
    select * from {{ ref('stg_conservation_categories') }}
),

species_obs as (
    select
        s.scientific_name,
        s.category,
        s.conservation_status,
        s.is_at_risk,
        sum(o.observations) as total_observations
    from species s
    join obs o on s.scientific_name = o.scientific_name
    group by s.scientific_name, s.category, s.conservation_status, s.is_at_risk
)

select
    c.status as conservation_status,
    c.description,
    c.iucn_equivalent,
    c.is_at_risk,
    count(distinct so.scientific_name) as species_count,
    count(distinct case when so.category = 'Mammal' then so.scientific_name end) as mammal_count,
    count(distinct case when so.category = 'Bird' then so.scientific_name end) as bird_count,
    count(distinct case when so.category = 'Fish' then so.scientific_name end) as fish_count,
    count(distinct case when so.category = 'Amphibian' then so.scientific_name end) as amphibian_count,
    count(distinct case when so.category = 'Reptile' then so.scientific_name end) as reptile_count,
    sum(so.total_observations) as total_observations
from cats c
left join species_obs so on c.status = so.conservation_status
group by c.status, c.description, c.iucn_equivalent, c.is_at_risk
order by species_count desc
