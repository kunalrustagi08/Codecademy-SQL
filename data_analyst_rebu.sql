SELECT * FROM trips
LIMIT 10;

SELECT * FROM riders
LIMIT 10;

SELECT * FROM cars
LIMIT 10;

SELECT *
FROM riders
CROSS JOIN cars;

SELECT *
FROM trips
LEFT JOIN riders
  ON trips.rider_id = riders.id;
  
SELECT trips.id, trips.date,
  trips.pickup, trips.dropoff,
  cars.model, cars.OS
FROM trips
JOIN cars
  ON trips.car_id = cars.id;
  
SELECT *
FROM riders
UNION
SELECT *
FROM riders2;

SELECT AVG(cost)
FROM trips;

SELECT riders.first, riders.last
FROM riders
WHERE total_trips < 500
UNION
SELECT riders2.first, riders2.last
FROM riders2
WHERE total_trips < 500;

SELECT COUNT(status)
FROM cars
WHERE status = 'active';

SELECT cars.id, cars.model, cars.OS
FROM cars
ORDER BY trips_completed DESC
LIMIT 2;
