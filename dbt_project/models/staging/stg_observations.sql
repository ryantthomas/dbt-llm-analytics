select
    scientific_name,
    park_name,
    cast(observations as integer) as observations
from {{ ref('observations') }}
