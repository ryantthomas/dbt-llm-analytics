select
    park_code,
    park_name,
    state,
    cast(established_year as integer) as established_year,
    cast(area_km2 as double) as area_km2,
    cast(latitude as double) as latitude,
    cast(longitude as double) as longitude
from {{ ref('parks') }}
