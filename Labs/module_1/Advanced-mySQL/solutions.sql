# Challenge 1
select au_id, advance + royalty_per_authors.total_royalty as profit
from (
	select title_id, au_id, sum(sales_royalty) as total_royalty, advance
		from (
			select s.title_id, ta.au_id, t.advance * ta.royaltyper/100 as advance, t.price*s.qty*t.royalty/100*ta.royaltyper/100 as sales_royalty
			from  sales s
			inner join titles t on s.title_id = t.title_id
			inner join titleauthor ta on t.title_id = ta.title_id) as royalty_advance
		group by title_id, au_id) as royalty_per_authors
order by profit desc
limit 3;

# Challenge 2
create temporary table publications.royalty_advance
select s.title_id, ta.au_id, t.advance * ta.royaltyper/100 as advance, t.price*s.qty*t.royalty/100*ta.royaltyper/100 as sales_royalty
from  sales s
inner join titles t on s.title_id = t.title_id
inner join titleauthor ta on t.title_id = ta.title_id;

create temporary table publications.royalty_per_authors
select title_id, au_id, sum(sales_royalty) as total_royalty, advance
from royalty_advance
group by title_id, au_id, advance;

select au_id, advance + royalty_per_authors.total_royalty as profit
from royalty_per_authors
order by profit desc
limit 3;

# Challenge 3
create table publications.most_profiting_authors as 
select au_id, advance + royalty_per_authors.total_royalty as profit
from (
	select title_id, au_id, sum(sales_royalty) as total_royalty, advance
		from (
			select s.title_id, ta.au_id, t.advance * ta.royaltyper/100 as advance, t.price*s.qty*t.royalty/100*ta.royaltyper/100 as sales_royalty
			from  sales s
			inner join titles t on s.title_id = t.title_id
			inner join titleauthor ta on t.title_id = ta.title_id) as royalty_advance
		group by title_id, au_id) as royalty_per_authors
order by profit desc
limit 3;

select *
from most_profiting_authors

