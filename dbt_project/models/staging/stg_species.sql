select
    scientific_name,
    category,
    common_names,
    case
        when conservation_status = '' or conservation_status is null then 'Least Concern'
        else conservation_status
    end as conservation_status,
    conservation_status in ('Endangered', 'Threatened', 'In Recovery') as is_at_risk
from {{ ref('species_info') }}
