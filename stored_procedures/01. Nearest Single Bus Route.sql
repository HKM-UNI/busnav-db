DELIMITER //

CREATE PROCEDURE sp_nearest_single_bus_route(
    IN location POINT,
    IN destination POINT
)
BEGIN
    WITH loc_near_stop AS (
        SELECT 
            bs.bus_id AS bus_id,
            bs.name AS location_stop_name,
            bs.location AS location_point,
            ST_Distance(bs.location, location) AS location_distance
        FROM 
            bus_stop bs
        ORDER BY 
            location_distance
        LIMIT 1
    ), dest_near_stop AS (
        SELECT
            bs.bus_id AS bus_id,
            bs.name AS destination_stop_name,
            bs.location AS destination_point,
            ST_Distance(bs.location, destination) AS destination_distance
        FROM 
            bus_stop bs
    ), bp_forward AS (
        SELECT bus_id, path, backward
        FROM bus_path
        WHERE backward = FALSE
    )
    SELECT
        lcs.bus_id AS bus_id,
        bus.number AS bus_number,
        lcs.location_stop_name AS location_stop_name,
        lcs.location_point AS location_point,
        dcs.destination_stop_name AS destination_stop_name,
        dcs.destination_point AS destination_point,
        bpf.path AS `route_forward`
    FROM loc_near_stop lcs
    JOIN dest_near_stop dcs ON lcs.bus_id = dcs.bus_id
    JOIN bus ON lcs.bus_id = bus.id
    JOIN bp_forward bpf ON bpf.bus_id = lcs.bus_id
    ORDER BY destination_distance
    LIMIT 1;
END //

DELIMITER ;

-- CALL sp_nearest_single_bus_route(
--     ST_GeomFromText('POINT(12.145209 -86.273800)', 4326),
--     ST_GeomFromText('POINT(12.138144 -86.290502)', 4326)
-- )
