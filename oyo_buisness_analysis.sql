create database oyo;

use oyo;

create table oyo_hotels(
	booking_id integer not null,
    customer_id bigint,
    status text,
    check_in text,
    check_out text,
    no_of_rooms integer,
    hotel_id integer,
    amount float,
    discount float,
    date_of_booking text
);


create table city_hotels(
	Hotel_id integer,
    City text
);
select * from oyo_hotels;
select * from city_hotels;

# No. of hotels in teh dataset
select count(distinct hotel_id) No_of_hotels from city_hotels;

# No. of cities in the data set
select count(distinct city) No_of_cities from city_hotels;

select * from oyo_hotels;

# Changing the check in, check out and date of booking to SQL format
alter table oyo_hotels add column newcheck_in date;
update oyo_hotels
set newcheck_in = str_to_date(substr(check_in, 1,10), '%d-%m-%Y');

alter table oyo_hotels add column newdate_of_booking date;
update oyo_hotels
set newdate_of_booking = str_to_date(substr(date_of_booking,1,10), '%d-%m-%Y');

alter table oyo_hotels add column newcheck_out date;
update oyo_hotels
set newcheck_out = str_to_date(substr(check_out,1,10), '%d-%m-%Y');

select * from oyo_hotels;

# No. of hotels in every city
select count(hotel_id) as hotel_id,city from city_hotels group by city;

# New column price is added
# amount represents the money pais by the customer. So if discount is added then it represents the total cost which is shown as price
alter table oyo_hotels add column price float;
update oyo_hotels set price = amount * discount;

alter table oyo_hotels add column no_of_nights int;
update oyo_hotels set no_of_nights = datediff(newcheck_out,newcheck_in);

# New column rate is added
alter table oyo_hotels add column rate float;
update oyo_hotels set rate = round(if(no_of_rooms = 1, (price/no_of_nights),
							(price/no_of_nights)/no_of_rooms),2);
                            
# Average room rate by city
select round(avg(rate),2) as avg_rate_by_city, city 
from oyo_hotels o, city_hotels c 
where o.hotel_id = c.hotel_id 
group by city
order by 1 desc;

select * from oyo_hotels;

# Bookingd made in the months of January, February and March. This can even contain bookings made for months other than Jan, Feb and March also
select  count(booking_id) as booking_id,city, month(newdate_of_booking) 
from oyo_hotels o, city_hotels c 
where month(newdate_of_booking) between 1 and 3 and o.hotel_id = c.hotel_id
group by city, month(newdate_of_booking);


-- Bookings made for the months of January, February and March.
select count(booking_id),city,month(newcheck_in) 
from oyo_hotels o, city_hotels c
where month(newcheck_in) between 1 and 3 and o.hotel_id = c.hotel_id
group by city, month(newcheck_in);

select count(customer_id) from oyo_hotels where no_of_nights > 5;

-- How many days prior the bookings were made
select count(*), datediff(newcheck_in,newdate_of_booking) as date_diff 
from oyo_hotels 
group by 2 
order by 2 asc;