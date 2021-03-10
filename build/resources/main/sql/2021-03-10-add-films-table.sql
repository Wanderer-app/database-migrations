create table films
(
    id          bigint          not null constraint films_pkey primary key,
    name        varchar(255)    not null,
    air_date    date            not null,
    rating      bigint          not null
);