
-- create a table names
-- A * A *
-- A * * A
-- finally we can obtain the talbe like A B C where the 2nd and 3rd col are different
-- col 2 and col 3 has a common col 1
with names(name1, name2, name3) as
select t1.person_1 name1, t1.person_2 name2, if(t1.person_1=t2.person_1, t2.person_2, t2.person_1) name3
from connection t1
cross join connection t2
where (t1.person_1 = t2.person_1 and t1.person_2 <> t2.person_2) or
(t1.person_1 = t2.person_2 and t1.person_2 <> t1.person_1);

-- dedup the col 2 and col3
-- A B C 
--       => A B C
-- A C B


-- after dedup I can aggregate the result by the col 2 and col 3
select  temp.name2, temp.name3, temp.name1 from
(select n1.name1, distinct(n1.name2), n1.name3
from names n1 left join names name2
on n1.name2 = n2.name3 and n1.name3 = n2.name2
where n1.name2 < n2.name2 or n2.name2 is null) temp
group by temp.name2, temp.name3