# Challenge 1
select district_id, count(distinct account_id)
from account
group by district_id
order by count(account_id) desc
limit 5;


# Challenge 2
select account_id, count(distinct amount) as diff, group_concat(distinct bank_to), group_concat(distinct amount)
from finance.order
where k_symbol = 'SIPO'
group by account_id
having diff>1;


# Challenge 3
Select loan.account_id, loan.amount, account.district_id
from loan
inner join account on loan.account_id = account.account_id
order by payments desc;

# Option 1
create temporary table xxx
select district_id, amount
from account a
inner join loan l on a.account_id = l.account_id;

select district_id, max(amount) as total_amount
from xxx
group by district_id
order by total_amount desc;


# Challenge 4
Create temporary table if not exists loan_b
Select loan.account_id, loan.amount, account.district_id
from loan
inner join account on loan.account_id = account.account_id
order by payments desc;

Select district_id, sum(amount)
from loan_b
group by district_id
order by sum(amount) desc;

#alternative
create temporary table xxx
select district_id, amount
from account a
inner join loan l on a.account_id = l.account_id;

select district_id, sum(amount) as total_amount
from xxx
group by district_id
order by total_amount desc;


# Challenge 5

# Average
Select district_id, avg(amount)
from loan_b
group by district_id
order by avg(amount) desc;

# Median

#1
select xxx.amount, @rownum:=@rownum+1 as `row_number`, @total_rows:=@rownum
from xxx, (select @rownum:=0) r
where xxx.amount is not null
order by xxx.amount;

#2
create table xxx1
select l.account_id, district_id, amount
from account a
inner join loan l on a.account_id = l.account_id;

SELECT x.district_id, x.amount, count(y.amount) as ranking
from xxx1 x , xxx1 y
where x.district_id = y.district_id and x.amount<y.amount
group by x.district_id, x.amount
order by 1,2 desc;

select x.district_id, ceil(count(x.amount/2)) as ranking
from xxx1 x
group by district_id;

select * 
from (
	SELECT x.district_id, x.amount, count(y.amount) as ranking
	from xxx1 x , xxx1 y
	where x.district_id = y.district_id and x.amount<y.amount
	group by x.district_id, x.amount) as ranked_table
where exists(
select x.district_id, ceil(count(x.amount/2)) as ranking
from xxx1 x
group by district_id
having ranked_table.district_id = x.district_id and ranked_table.ranking=ranking
);
