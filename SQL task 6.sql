-- creating table (no.of rows 12694)

-- table 1 match

create table match (
	Match_Id int,
	Match_Date varchar,
	Team_Name_Id int,
	Opponent_Team_Id int,
	Season_Id int,
	Venue_Name varchar,
	Toss_Winner_Id int,
	Toss_Decision varchar,
	IS_Superover int,
	IS_Result int,
	Is_DuckWorthLewis int,
	Win_Type varchar,
	Won_By varchar,
	Match_Winner_Id int,
	Man_Of_The_Match_Id int,
	First_Umpire_Id int,
	Second_Umpire_Id int,
	City_Name varchar,
	Host_Country varchar
)

copy match from 'D:/data analyst/sql/task 6/Match.csv' delimiter ',' csv header;

select * from match


	
-- table 2 player
	
create table player (
	Player_Id int,
	Player_Name varchar,
	DOB varchar default Null,
	Batting_Hand varchar default Null,
	Bowling_Skill varchar default Null,
	Country varchar default Null,
	Is_Umpire int
)

copy player from 'D:/data analyst/sql/task 6/Player.csv' delimiter ',' csv header;

select * from player


-- table 3 player_match
	
create table player_match (
	Match_Id int,
	Player_Id int,
	Team_Id int,
	Is_Keeper int,
	Is_Captain int
)

copy player_match from 'D:/data analyst/sql/task 6/Player_Match.csv' delimiter ',' csv header;

select * from player_match


-- examples
	
-- joins (contains functions like where,group by,having,limit and order by)

select * from match
select * from player
select * from player_match

-- inner join
select m.venue_name,m.win_type,m.won_by,m.city_name,sum(m.is_duckworthlewis),pm.is_keeper,pm.is_captain from match as m
inner join player_match as pm
on m.match_id = pm.match_id
group by  m.venue_name,m.win_type,m.won_by,m.city_name,pm.is_keeper,pm.is_captain

-- left join
select p.player_id,p.player_name,p.batting_hand,p.country,pm.is_keeper,avg(pm.is_keeper),pm.is_captain from player as p
left join player_match as pm
on p.player_id = pm.player_id
group by p.player_id,p.player_name,p.batting_hand,p.country,pm.is_keeper,pm.is_captain
having avg(pm.is_keeper) = 1
order by player_id
limit 10

-- right join
select p.player_id,p.player_name,p.batting_hand,p.country,pm.is_keeper,pm.is_captain from player as p
right join player_match as pm
on p.player_id = pm.player_id

-- full join 
select pm.player_id,p.player_name,p.dob,m.match_date,m.venue_name,m.won_by,m.win_type,m.city_name,pm.is_captain from match as m
full join player_match as pm
on m.match_id = pm.match_id
full join player as p
on p.player_id = pm.player_id
where pm.is_captain = 1
limit 10


-- union

select match_id from match where toss_decision = 'bat'
union
select match_id from player_match 


-- end
