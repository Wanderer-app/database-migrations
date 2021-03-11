create sequence badges_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

create sequence comments_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

create sequence countries_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

create sequence files_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

create sequence levels_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

create sequence notifications_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

create sequence pins_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

create sequence privileges_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

create sequence users_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

create sequence votes_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

create table attached_files
(
    id             bigint    not null
        constraint attached_files_pkey
            primary key,
    entity_created timestamp not null,
    entity_version bigint    not null,
    entity_updated timestamp not null,
    content        bytea     not null
);

create table badges
(
    id                   bigint       not null
        constraint badges_pkey
            primary key,
    entity_created       timestamp    not null,
    entity_version       bigint       not null,
    entity_updated       timestamp    not null,
    minimum_level_number bigint       not null,
    title                varchar(255) not null
);

create table countries
(
    id             bigint       not null
        constraint countries_pkey
            primary key,
    entity_created timestamp    not null,
    entity_version bigint       not null,
    entity_updated timestamp    not null,
    name           varchar(255) not null
);

create table levels
(
    id             bigint    not null
        constraint levels_pkey
            primary key,
    entity_created timestamp not null,
    entity_version bigint    not null,
    entity_updated timestamp not null,
    minimum_score  bigint    not null,
    number         bigint    not null
);

create table privileges
(
    id             bigint    not null
        constraint privileges_pkey
            primary key,
    entity_created timestamp not null,
    entity_version bigint    not null,
    entity_updated timestamp not null,
    name           bigint    not null
);

create table users
(
    id                bigint       not null
        constraint users_pkey
            primary key,
    entity_created    timestamp    not null,
    entity_version    bigint       not null,
    entity_updated    timestamp    not null,
    password          varchar(100),
    date_of_birth     date         not null,
    first_name        varchar(255) not null,
    last_name         varchar(255) not null,
    register_time     timestamp    not null,
    score             bigint       not null,
    country_id        bigint       not null
        constraint fkjlpks00ofkq3sqd9hqiavv5lg
            references countries,
    image_id          bigint       not null
        constraint fkl61ofkcixxtvwlsw2nx65hjxy
            references attached_files,
    level_id          bigint       not null
        constraint fkhjemv8nqu3o0rutwrhlgca5in
            references levels,
    privilege_id      bigint       not null
        constraint fklqsigtdreydubi3kokcs49q4u
            references privileges
);

create table notifications
(
    id                 bigint       not null
        constraint notifications_pkey
            primary key,
    entity_created     timestamp    not null,
    entity_version     bigint       not null,
    entity_updated     timestamp    not null,
    originator_name    varchar(255),
    related_content_id bigint,
    send_date          date,
    type               varchar(255) not null,
    receiver_id        bigint       not null
        constraint fk9kxl0whvhifo6gw4tjq36v53k
            references users
);

create index idx_notifications_users
    on notifications (receiver_id);

create table pins
(
    id               bigint       not null
        constraint pins_pkey
            primary key,
    entity_created   timestamp    not null,
    entity_version   bigint       not null,
    entity_updated   timestamp    not null,
    add_date         date,
    body             varchar(255) not null,
    lat              real         not null,
    lng              real         not null,
    route_code       varchar(50)  not null,
    title            varchar(255) not null,
    type             varchar(50)  not null,
    attached_file_id bigint
        constraint fkmkp8pleo6iffe22jxbbmf76to
            references attached_files,
    author_id        bigint       not null
        constraint fkg9cjr3m6b3nmk868yaqqdns89
            references users
);

create table comments
(
    id             bigint       not null
        constraint comments_pkey
            primary key,
    entity_created timestamp    not null,
    entity_version bigint       not null,
    entity_updated timestamp    not null,
    text           varchar(255) not null,
    author_id      bigint       not null
        constraint fkn2na60ukhs76ibtpt9burkm27
            references users,
    pin_id         bigint       not null
        constraint fklaw91d7oxqdrmmbmpk6falmpv
            references pins,
    replies_to_id  bigint
        constraint fk9rv9kgqs8yop0rgdjn32cceop
            references comments
);

create index idx_comments_users
    on comments (author_id);

create index idx_comments_pins
    on comments (pin_id);

create index idx_pins_users
    on pins (author_id);

create index idx_pins_files
    on pins (attached_file_id);

create table user_badge
(
    user_id  bigint not null
        constraint fka96xbjeyiemypugmi9g8x8fiu
            references users,
    badge_id bigint not null
        constraint fklwink9lit6jtc6cvyc335851w
            references badges,
    constraint user_badge_pkey
        primary key (user_id, badge_id)
);

create index idx_users_countries
    on users (country_id);

create index idx_users_privileges
    on users (privilege_id);

create index idx_users_levels
    on users (level_id);

create index idx_users_images
    on users (image_id);

create table votes
(
    id             bigint    not null
        constraint votes_pkey
            primary key,
    entity_created timestamp not null,
    entity_version bigint    not null,
    entity_updated timestamp not null,
    made_at        date      not null,
    type           integer   not null,
    weight         bigint    not null,
    author_id      bigint    not null
        constraint fk8jpnhv3qkltvbqxwdimfymj27
            references users
);

create table comment_votes
(
    comment_id bigint not null
        constraint fkhdta06oo0umsl3usqm21ra5j8
            references comments,
    vote_id    bigint not null
        constraint fk9m7d1ywljl09ly3v1wu2vr4r8
            references votes,
    constraint comment_votes_pkey
        primary key (comment_id, vote_id)
);

create table pin_votes
(
    pin_id  bigint not null
        constraint fk643atu9gdxfug97kjogfyweax
            references pins,
    vote_id bigint not null
        constraint fkjc0wikpe1wsjbvtda6smbmyv1
            references votes,
    constraint pin_votes_pkey
        primary key (pin_id, vote_id)
);

create index idx_votes_users
    on votes (author_id);


