INSERT INTO bus
    (
        number
        , average_time_minutes
        , start_terminal
        , end_terminal
        , route_forward_data_url
        , route_backward_data_url
    )
VALUES
    (
        110
        , 15
        , 1
        , 2
        , 'https://raw.githubusercontent.com/HKM-UNI/busnav-db/main/mock/110.1.geojson'
        , 'https://raw.githubusercontent.com/HKM-UNI/busnav-db/main/mock/110.2.geojson'
    ),
    (
        112
        , 10
        , 3
        , 4
        , 'https://raw.githubusercontent.com/HKM-UNI/busnav-db/main/mock/112.1.geojson'
        , 'https://raw.githubusercontent.com/HKM-UNI/busnav-db/main/mock/112.2.geojson'
    );
