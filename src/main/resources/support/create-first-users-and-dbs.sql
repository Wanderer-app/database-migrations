create role test with superuser login encrypted password 'test123';
create role prod with superuser login encrypted password 'prod123';


--drop database wanderer_test;
create database wanderer_test with owner test;

--drop database wanderer_prod;
create database wanderer_prod with owner loans;

