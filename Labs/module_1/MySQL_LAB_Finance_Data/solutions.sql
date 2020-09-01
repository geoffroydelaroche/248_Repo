# Challenge 1
select district_id, count(account_id)
from account
group by district_id
order by count(account_id) desc
limit 5;

# Challenge 2
alter table district
rename column A1 to district_id;

select *
from district;