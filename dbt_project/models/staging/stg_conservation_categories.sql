select
    status,
    description,
    iucn_equivalent,
    cast(is_at_risk as boolean) as is_at_risk
from {{ ref('conservation_categories') }}
