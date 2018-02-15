--first I have to get all the connection for each person_1
--then find the max of the connections
select temp.person_1, max(temp.total) from
(select `row`, person_1, sum(person_2) as total from connection group by person_1) temp