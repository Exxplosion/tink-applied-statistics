--Сколько уникальных моделей самолетов?
select sum(count_unique_models) from (select count(model) as count_unique_models
	from bookings.aircrafts
	group by model) a;
--Ответ: 9

--Найдите топ 5 самых популярных городов. Ответ в порядке убывания.
with cte as (
	select flights.flight_id,
	airports.city,
	ticket_flights.ticket_no,
	ticket_flights.amount
	from bookings.flights
	inner join bookings.airports on airports.airport_code = flights.arrival_airport
	inner join bookings.ticket_flights on flights.flight_id = ticket_flights.flight_id
)

select distinct city, count(ticket_no) over(partition by city) as popular_city from cte order by popular_city DESC;
--Комментарий: в какой метрике считать "популярность" города? Я выбрал количество купленных билетов для перелета в город.
--Ответ: Москва, Санкт-Петербург, Новосибирск, Екатиренбург, Сочи


--Какая сумма всех потраченных денег на перелет из Москвы?
with cte_1 as (
	select flights.flight_id,
	airports.city,
	ticket_flights.ticket_no,
	ticket_flights.amount
	from bookings.flights
	inner join bookings.airports on airports.airport_code = flights.departure_airport
	inner join bookings.ticket_flights on flights.flight_id = ticket_flights.flight_id
)

select distinct city, sum(amount) over(partition by city) as amount_city from cte_1 where city like 'Москва';
--Ответ: 7462943300

--Задание 4 в след. файле.
