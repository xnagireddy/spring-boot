DROP SEQUENCE IF EXISTS public.city_id_seq CASCADE;
DROP SEQUENCE IF EXISTS public.hotel_id_seq CASCADE;
DROP SEQUENCE IF EXISTS public.review_id_seq CASCADE;

CREATE SEQUENCE public.city_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.city_id_seq
    OWNER TO virsec;


-- FUNCTION: udf_get_cities()

-- DROP FUNCTION udf_get_cities();

CREATE OR REPLACE FUNCTION udf_get_cities()
    RETURNS TABLE(name character varying)
    LANGUAGE 'sql'
    COST 100.0

AS $function$

  SELECT name FROM city
$function$;

ALTER FUNCTION udf_get_cities()
    OWNER TO virsec;


/*

SELECT udf_get_cities()

*/



-- Table: public.city

DROP TABLE IF EXISTS public.city CASCADE;

CREATE TABLE public.city
(
    id integer NOT NULL DEFAULT nextval('city_id_seq'::regclass),
    country character varying(255) NOT NULL,
    map character varying(255) NOT NULL,
    name character varying(255),
    state character varying(255) NOT NULL,
    CONSTRAINT city_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.city
    OWNER to virsec;
    
    
-- Table: public.hotel

DROP TABLE IF EXISTS public.hotel CASCADE;

CREATE TABLE public.hotel
(
    id serial NOT NULL,
    address character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    zip character varying(255) NOT NULL,
    city_id bigint NOT NULL,
    CONSTRAINT hotel_pkey PRIMARY KEY (id),
    CONSTRAINT uk_i80qjsl99gene06k3t31y3sv5 UNIQUE (city_id, name)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.hotel
    OWNER to virsec;
    
    
    
-- Table: public.review

DROP TABLE IF EXISTS public.review CASCADE;

CREATE TABLE public.review
(
    id serial NOT NULL,
    check_in_date date NOT NULL,
    details character varying(5000) NOT NULL,
    idx integer NOT NULL,
    rating integer NOT NULL,
    title character varying(255) NOT NULL,
    trip_type integer NOT NULL,
    hotel_id bigint NOT NULL,
    CONSTRAINT review_pkey PRIMARY KEY (id),
    CONSTRAINT fki0ly7ivbh8ijdgoi7cwtuoavt FOREIGN KEY (hotel_id)
        REFERENCES public.hotel (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.review
    OWNER to virsec;