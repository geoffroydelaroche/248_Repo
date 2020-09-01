#1. What are the different genres?
select distinct(prime_genre)
from Appstore;

#2. Which is the genre with the most apps rated?
select prime_genre, count(rating_count_tot)
from Appstore
where rating_count_tot is not null and rating_count_tot>0
group by prime_genre
order by 2 desc
limit 1;

#3. Which is the genre with most apps?
select prime_genre, count(id)
from Appstore
group by prime_genre
order by count(id) desc
limit 1;

#4. Which is the one with least?
select prime_genre, count(id)
from Appstore
group by prime_genre
order by count(id)
limit 1;

#5. Find the top 10 apps most rated.
select id, track_name, rating_count_tot
from Appstore
order by rating_count_tot DESC
limit 10;

#6. Find the top 10 apps best rated by users.
select id, track_name, user_rating
from Appstore
order by user_rating DESC
limit 10;

#7. Take a look at the data you retrieved in question 5. Give some insights.
# Every apps in the output is well known. The query is efficient, it permits to know what is the best well known apps.

#8. Take a look at the data you retrieved in question 6. Give some insights.
# The apps present in the output are not all well known, this is explain by the fact that an app rated by only one user could be present in this output if the rate of the user is 5. Also the rating are from 0 to 5, we only select the 10 highest ratings which are 5 but there are a lots of apps which have a rating of 5. So this query is not efficient.

#9. Now compare the data from questions 5 and 6. What do you see?
# As I said in question 7 and 8, the outputs are really different. In the output 5,we have well known apps but in output 6, apps are not all wellknown.

#10. How could you take the top 3 regarding both user ratings and number of votes?
select id, track_name, rating_count_tot, user_rating
from Appstore
order by user_rating desc, rating_count_tot desc
limit 3;

#11. Do people care about the price of an app?

select avg(rating_count_tot)
from Appstore
where price = 0;
# In this query, I try to know what is the average number of rating count when apps are free in order to see if the rating count is higher or lower for free or non-free apps
#Avg rating for free apps = 19 750

select avg(rating_count_tot)
from Appstore
where price != 0;
# Avg rating for non free apps = 4 038
# So we see that free apps are a lot more rated than non free apps, it permits to know that free apps are a lot more used than non free apps

select track_name, price, rating_count_tot
from Appstore
where price != 0
order by rating_count_tot desc
limit 5;
# Here I identify non free apps with the more rating count limit to 5. All apps rating count are between 395 261 and 698 516

select track_name, price, rating_count_tot
from Appstore
where price = 0
order by rating_count_tot desc
limit 5;
# Here I identify free apps with the more rating count limit to 5. All apps rating count are between 1 126 879 and 2 974 676
# If we compare with last query, we can say that free apps are a lot more rated and so more used than non free apps. So people do care about the price.
