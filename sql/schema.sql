--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: banks; Type: TABLE; Schema: public; Owner: u0_a256
--

CREATE TABLE public.banks (
    bank_id integer NOT NULL,
    bank_name character varying(100) NOT NULL,
    app_name character varying(100)
);


ALTER TABLE public.banks OWNER TO u0_a256;

--
-- Name: banks_bank_id_seq; Type: SEQUENCE; Schema: public; Owner: u0_a256
--

CREATE SEQUENCE public.banks_bank_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.banks_bank_id_seq OWNER TO u0_a256;

--
-- Name: banks_bank_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: u0_a256
--

ALTER SEQUENCE public.banks_bank_id_seq OWNED BY public.banks.bank_id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: u0_a256
--

CREATE TABLE public.reviews (
    review_id integer NOT NULL,
    bank_id integer,
    review_text text,
    rating smallint,
    review_date date,
    sentiment_label character varying(50),
    sentiment_score numeric(5,4),
    source character varying(50)
);


ALTER TABLE public.reviews OWNER TO u0_a256;

--
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: u0_a256
--

CREATE SEQUENCE public.reviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_review_id_seq OWNER TO u0_a256;

--
-- Name: reviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: u0_a256
--

ALTER SEQUENCE public.reviews_review_id_seq OWNED BY public.reviews.review_id;


--
-- Name: banks bank_id; Type: DEFAULT; Schema: public; Owner: u0_a256
--

ALTER TABLE ONLY public.banks ALTER COLUMN bank_id SET DEFAULT nextval('public.banks_bank_id_seq'::regclass);


--
-- Name: reviews review_id; Type: DEFAULT; Schema: public; Owner: u0_a256
--

ALTER TABLE ONLY public.reviews ALTER COLUMN review_id SET DEFAULT nextval('public.reviews_review_id_seq'::regclass);


--
-- Name: banks bank_name_unique; Type: CONSTRAINT; Schema: public; Owner: u0_a256
--

ALTER TABLE ONLY public.banks
    ADD CONSTRAINT bank_name_unique UNIQUE (bank_name);


--
-- Name: banks banks_pkey; Type: CONSTRAINT; Schema: public; Owner: u0_a256
--

ALTER TABLE ONLY public.banks
    ADD CONSTRAINT banks_pkey PRIMARY KEY (bank_id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: u0_a256
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- Name: reviews reviews_bank_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: u0_a256
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_bank_id_fkey FOREIGN KEY (bank_id) REFERENCES public.banks(bank_id);


--
-- PostgreSQL database dump complete
--

