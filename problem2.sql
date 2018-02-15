
-- first find the common connection for each person
-- find the max the common connection

select temp.name1, max(temp.name1) from
(select t1.person_1 name1, t1.person_2 name2 from connection t1
inner join connection t2
on 
t1.person_2 = t2.person_1 and t1.person_1= t2.person_2) temp
 group by temp.name1