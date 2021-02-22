--
-- PostgreSQL database dump
--

-- Dumped from database version 10.15 (Ubuntu 10.15-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.15 (Ubuntu 10.15-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: donation_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.donation_category (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.donation_category OWNER TO postgres;

--
-- Name: donation_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.donation_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.donation_category_id_seq OWNER TO postgres;

--
-- Name: donation_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.donation_category_id_seq OWNED BY public.donation_category.id;


--
-- Name: donation_donation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.donation_donation (
    id integer NOT NULL,
    quantity smallint NOT NULL,
    address text NOT NULL,
    phone_number character varying(16) NOT NULL,
    city character varying(32) NOT NULL,
    zip_code character varying(8) NOT NULL,
    pick_up_date date NOT NULL,
    pick_up_time time without time zone NOT NULL,
    institution_id integer NOT NULL,
    user_id integer,
    notes text,
    is_taken boolean,
    date_added timestamp with time zone NOT NULL,
    date_update timestamp with time zone NOT NULL
);


ALTER TABLE public.donation_donation OWNER TO postgres;

--
-- Name: donation_donation_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.donation_donation_categories (
    id integer NOT NULL,
    donation_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.donation_donation_categories OWNER TO postgres;

--
-- Name: donation_donation_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.donation_donation_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.donation_donation_categories_id_seq OWNER TO postgres;

--
-- Name: donation_donation_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.donation_donation_categories_id_seq OWNED BY public.donation_donation_categories.id;


--
-- Name: donation_donation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.donation_donation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.donation_donation_id_seq OWNER TO postgres;

--
-- Name: donation_donation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.donation_donation_id_seq OWNED BY public.donation_donation.id;


--
-- Name: donation_institution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.donation_institution (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    description text NOT NULL,
    type character varying(2) NOT NULL
);


ALTER TABLE public.donation_institution OWNER TO postgres;

--
-- Name: donation_institution_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.donation_institution_categories (
    id integer NOT NULL,
    institution_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.donation_institution_categories OWNER TO postgres;

--
-- Name: donation_institution_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.donation_institution_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.donation_institution_categories_id_seq OWNER TO postgres;

--
-- Name: donation_institution_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.donation_institution_categories_id_seq OWNED BY public.donation_institution_categories.id;


--
-- Name: donation_institution_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.donation_institution_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.donation_institution_id_seq OWNER TO postgres;

--
-- Name: donation_institution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.donation_institution_id_seq OWNED BY public.donation_institution.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: donation_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_category ALTER COLUMN id SET DEFAULT nextval('public.donation_category_id_seq'::regclass);


--
-- Name: donation_donation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_donation ALTER COLUMN id SET DEFAULT nextval('public.donation_donation_id_seq'::regclass);


--
-- Name: donation_donation_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_donation_categories ALTER COLUMN id SET DEFAULT nextval('public.donation_donation_categories_id_seq'::regclass);


--
-- Name: donation_institution id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_institution ALTER COLUMN id SET DEFAULT nextval('public.donation_institution_id_seq'::regclass);


--
-- Name: donation_institution_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_institution_categories ALTER COLUMN id SET DEFAULT nextval('public.donation_institution_categories_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add category	7	add_category
26	Can change category	7	change_category
27	Can delete category	7	delete_category
28	Can view category	7	view_category
29	Can add institution	8	add_institution
30	Can change institution	8	change_institution
31	Can delete institution	8	delete_institution
32	Can view institution	8	view_institution
33	Can add donation	9	add_donation
34	Can change donation	9	change_donation
35	Can delete donation	9	delete_donation
36	Can view donation	9	view_donation
37	Can add profile	10	add_profile
38	Can change profile	10	change_profile
39	Can delete profile	10	delete_profile
40	Can view profile	10	view_profile
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$180000$L9IAWtex4ULj$sbgBze/bQtP4G1ftpyKiHJRKAMnHyr46F0ym22FTaD0=	2021-02-22 05:41:38.625865+01	f	madas@mail.pl	Marcin	Adasiewicz	madas@mail.pl	f	t	2021-01-26 14:56:27.993789+01
2	pbkdf2_sha256$180000$5q8ELCGw9RWe$bUNpt8sGRyVZpYSCKmRS5W6+/XiKZw62m2J3JKCJoPw=	2021-02-22 05:43:04.765877+01	t	admin	Admino	Admiński	admin@mail.com	t	t	2021-01-27 21:02:56.971774+01
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2021-01-27 21:05:54.070601+01	1	Fundacja: Fundacja Pomocy Dzieciom	1	[{"added": {}}]	8	2
2	2021-01-27 21:07:17.110452+01	2	Zbiórka lokalna: Zbiórka na Świąteczna	1	[{"added": {}}]	8	2
3	2021-01-27 21:07:40.360726+01	6	Koce	1	[{"added": {}}]	7	2
4	2021-01-27 21:08:57.78732+01	3	Zbiórka lokalna: Zbiórka na schronisko	1	[{"added": {}}]	8	2
5	2021-01-27 21:10:40.459972+01	4	Organizacja pozarządowa: Organizacja pomocy bezdomnym	1	[{"added": {}}]	8	2
6	2021-01-27 21:12:36.55642+01	5	Fundacja: Fundacja "Nie wyrzucaj"	1	[{"added": {}}]	8	2
7	2021-01-27 21:14:16.127165+01	6	Organizacja pozarządowa: Organizacja "Nowy Dom"	1	[{"added": {}}]	8	2
8	2021-02-02 16:50:54.875722+01	2	admin	3		4	2
9	2021-02-18 14:20:49.624863+01	30	adamo@mail.pl	3		4	2
10	2021-02-18 14:21:01.204497+01	32	alex@gmail.com	3		4	2
11	2021-02-18 14:21:01.208904+01	33	kupadupa@gmail.com	3		4	2
12	2021-02-18 14:21:01.211291+01	31	nowak@mail.com	3		4	2
13	2021-02-18 14:21:48.011094+01	2	admin	3		4	2
14	2021-02-18 14:24:05.140919+01	5	Darowizna dla Organizacja pomocy bezdomnym	2	[{"changed": {"fields": ["User"]}}]	9	2
15	2021-02-18 14:24:11.16325+01	4	Darowizna dla Organizacja pomocy bezdomnym	2	[{"changed": {"fields": ["User"]}}]	9	2
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	donation	category
8	donation	institution
9	donation	donation
10	donation	profile
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-01-26 14:55:27.704303+01
2	auth	0001_initial	2021-01-26 14:55:27.750752+01
3	admin	0001_initial	2021-01-26 14:55:27.820405+01
4	admin	0002_logentry_remove_auto_add	2021-01-26 14:55:27.839694+01
5	admin	0003_logentry_add_action_flag_choices	2021-01-26 14:55:27.858504+01
6	contenttypes	0002_remove_content_type_name	2021-01-26 14:55:27.879572+01
7	auth	0002_alter_permission_name_max_length	2021-01-26 14:55:27.885893+01
8	auth	0003_alter_user_email_max_length	2021-01-26 14:55:27.906547+01
9	auth	0004_alter_user_username_opts	2021-01-26 14:55:27.919717+01
10	auth	0005_alter_user_last_login_null	2021-01-26 14:55:27.932126+01
11	auth	0006_require_contenttypes_0002	2021-01-26 14:55:27.943038+01
12	auth	0007_alter_validators_add_error_messages	2021-01-26 14:55:27.958843+01
13	auth	0008_alter_user_username_max_length	2021-01-26 14:55:27.985138+01
14	auth	0009_alter_user_last_name_max_length	2021-01-26 14:55:28.001182+01
15	auth	0010_alter_group_name_max_length	2021-01-26 14:55:28.014253+01
16	auth	0011_update_proxy_permissions	2021-01-26 14:55:28.024686+01
17	donation	0001_initial	2021-01-26 14:55:28.075841+01
18	donation	0002_auto_20200428_2247	2021-01-26 14:55:28.105939+01
19	donation	0003_donation_notes	2021-01-26 14:55:28.121573+01
20	donation	0004_donation_is_taken	2021-01-26 14:55:28.142237+01
21	donation	0005_donation_date_added	2021-01-26 14:55:28.168393+01
22	donation	0006_donation_date_update	2021-01-26 14:55:28.192526+01
23	donation	0007_auto_20200508_0131	2021-01-26 14:55:28.218331+01
24	donation	0008_auto_20200508_1307	2021-01-26 14:55:28.247385+01
25	sessions	0001_initial	2021-01-26 14:55:28.259884+01
26	donation	0009_profile	2021-02-08 13:10:24.523166+01
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
9h73ie1q9lvh64ozhiqxq43co0pg77j4	ZjczYmQzNGZhYWU0MDAxN2U1YWQxYmM5YjliMjcyMjI4Mjk2OGIzODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwMzIwZDMwZWJlOTRhNTJlNzllZTM3MjVjMDQ5MjQyN2ZjMmZlOWYwIn0=	2021-02-09 14:56:35.936112+01
34ti4pwew4v9ggk06t2z6hxyzkzrnro5	NDE2NWM1ZmY5ZjcwOGQ4ZWYwOTg2OTUyMWNmMjc0MTBmYWRmNzAwNDp7ImVtYWlsIjoiYWRtaW5AbWFpbC5jb20iLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDVmYWM5ZmM2YzRlZWM5NDMzYzY0MTE4M2IyYmI5MmVlNTdhODRiNyJ9	2021-02-10 21:04:13.659682+01
4yfwibu06lklbq9noiwxm4huh6m36tey	NWMyOGM2Yzg3YjI4YzU0N2NlNmIxMDZhNGYwMTM0ODc5MTk2NjRlNzp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNWZhYzlmYzZjNGVlYzk0MzNjNjQxMTgzYjJiYjkyZWU1N2E4NGI3In0=	2021-02-10 21:26:08.644183+01
5tnvb38oxgvk3av88z57fl3qkc57nuzt	ZjczYmQzNGZhYWU0MDAxN2U1YWQxYmM5YjliMjcyMjI4Mjk2OGIzODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwMzIwZDMwZWJlOTRhNTJlNzllZTM3MjVjMDQ5MjQyN2ZjMmZlOWYwIn0=	2021-02-16 17:21:55.395083+01
h1q63jp789mq5odrlclgddt1ghdyzva5	ZGFkMTU5ZGZmMTJmZGJkMmM4NDA1NDViZTZlNTE3MzdhZmNjMjM3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYjgwYjhjNzZhOWI4NjQ0MjI3Yjc2MzE2OTA5ZWJmM2Y4Y2U4MjFjIn0=	2021-02-17 16:51:44.909692+01
2zrnis4cz56ia245ooggoysejwn8zob4	MTBjOWVmNTRmMDQyYmY4YTk3NWUzZWUwYzNhYjAyMGJmNjdlNzY4NDp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwZTdjZTg0MjU3ZDVlZjYxNTJiYWZiNjI2NjhkZWU2NDEwZWEwMDZmIn0=	2021-03-08 05:43:04.769007+01
\.


--
-- Data for Name: donation_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.donation_category (id, name) FROM stdin;
1	Jedzenie
2	Chemia gospodaracza
3	Ubrania
4	Kosmetyki
5	Zabawki
6	Koce
\.


--
-- Data for Name: donation_donation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.donation_donation (id, quantity, address, phone_number, city, zip_code, pick_up_date, pick_up_time, institution_id, user_id, notes, is_taken, date_added, date_update) FROM stdin;
1	2	Krakowska	500-500-500	Kraków	00-000	2021-01-31	12:00:00	2	1		\N	2021-01-27 21:16:36.207076+01	2021-01-27 21:16:36.223889+01
3	1	Starożytna 7	500-400-391	Mohendżo Daro	010-11	2021-01-24	10:30:00	6	1		\N	2021-01-27 21:24:49.353651+01	2021-01-27 21:24:49.367978+01
2	3	Nowomiejska 15	500-600-700	Nowe Miasto	01-002	2021-02-03	10:20:00	3	1	Dary zostaną położone przed Klatką schodową.	t	2021-01-27 21:19:05.868234+01	2021-01-27 21:25:13.544372+01
5	1	Admińska 0	100-200-400	Adminowo	123-45	2021-01-17	14:00:00	4	1		t	2021-01-27 21:28:31.559163+01	2021-02-18 14:24:05.134345+01
4	2	Admińska 0	100-200-300	Adminowo	01-212	2021-02-06	15:00:00	4	1		\N	2021-01-27 21:27:36.313136+01	2021-02-18 14:24:11.156889+01
\.


--
-- Data for Name: donation_donation_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.donation_donation_categories (id, donation_id, category_id) FROM stdin;
1	1	2
2	1	4
3	2	1
4	2	6
5	3	3
6	3	5
7	4	4
8	5	1
9	5	3
\.


--
-- Data for Name: donation_institution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.donation_institution (id, name, description, type) FROM stdin;
1	Fundacja Pomocy Dzieciom	Fundacja pomagająca biednym dzieciom	F
2	Zbiórka na Świąteczna	Zbiórka jedzenia, kosmetyków i chemii gospodarczej na Święta dla potrzebujących.	ZL
3	Zbiórka na schronisko	Zbiórka kocy i karmy dla zwierząt ze schroniska	ZL
4	Organizacja pomocy bezdomnym	Organizacja niosąca pomoc osobom bezdomnym.	OP
5	Fundacja "Nie wyrzucaj"	Fundacja zbierająca używaną odzież.	F
6	Organizacja "Nowy Dom"	Organizacja pomagająca młodym rodzinom w ciężkiej sytuacji materialnej.	OP
\.


--
-- Data for Name: donation_institution_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.donation_institution_categories (id, institution_id, category_id) FROM stdin;
1	1	3
2	1	5
3	2	1
4	2	2
5	2	4
6	3	1
7	3	5
8	3	6
9	4	1
10	4	2
11	4	3
12	4	4
13	5	3
14	6	1
15	6	2
16	6	3
17	6	4
18	6	5
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 40, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 33, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 15, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 10, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 26, true);


--
-- Name: donation_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.donation_category_id_seq', 6, true);


--
-- Name: donation_donation_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.donation_donation_categories_id_seq', 12, true);


--
-- Name: donation_donation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.donation_donation_id_seq', 7, true);


--
-- Name: donation_institution_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.donation_institution_categories_id_seq', 18, true);


--
-- Name: donation_institution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.donation_institution_id_seq', 6, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: donation_category donation_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_category
    ADD CONSTRAINT donation_category_pkey PRIMARY KEY (id);


--
-- Name: donation_donation_categories donation_donation_catego_donation_id_category_id_dc7b74e7_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_donation_categories
    ADD CONSTRAINT donation_donation_catego_donation_id_category_id_dc7b74e7_uniq UNIQUE (donation_id, category_id);


--
-- Name: donation_donation_categories donation_donation_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_donation_categories
    ADD CONSTRAINT donation_donation_categories_pkey PRIMARY KEY (id);


--
-- Name: donation_donation donation_donation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_donation
    ADD CONSTRAINT donation_donation_pkey PRIMARY KEY (id);


--
-- Name: donation_institution_categories donation_institution_cat_institution_id_category__f61bc6a2_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_institution_categories
    ADD CONSTRAINT donation_institution_cat_institution_id_category__f61bc6a2_uniq UNIQUE (institution_id, category_id);


--
-- Name: donation_institution_categories donation_institution_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_institution_categories
    ADD CONSTRAINT donation_institution_categories_pkey PRIMARY KEY (id);


--
-- Name: donation_institution donation_institution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_institution
    ADD CONSTRAINT donation_institution_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: donation_donation_categories_category_id_b799ca25; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX donation_donation_categories_category_id_b799ca25 ON public.donation_donation_categories USING btree (category_id);


--
-- Name: donation_donation_categories_donation_id_2b5a9716; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX donation_donation_categories_donation_id_2b5a9716 ON public.donation_donation_categories USING btree (donation_id);


--
-- Name: donation_donation_institution_id_2ae1ccf6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX donation_donation_institution_id_2ae1ccf6 ON public.donation_donation USING btree (institution_id);


--
-- Name: donation_donation_user_id_c2eb4cc0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX donation_donation_user_id_c2eb4cc0 ON public.donation_donation USING btree (user_id);


--
-- Name: donation_institution_categories_category_id_0dae5f89; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX donation_institution_categories_category_id_0dae5f89 ON public.donation_institution_categories USING btree (category_id);


--
-- Name: donation_institution_categories_institution_id_520f7bba; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX donation_institution_categories_institution_id_520f7bba ON public.donation_institution_categories USING btree (institution_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: donation_donation_categories donation_donation_ca_category_id_b799ca25_fk_donation_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_donation_categories
    ADD CONSTRAINT donation_donation_ca_category_id_b799ca25_fk_donation_ FOREIGN KEY (category_id) REFERENCES public.donation_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: donation_donation_categories donation_donation_ca_donation_id_2b5a9716_fk_donation_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_donation_categories
    ADD CONSTRAINT donation_donation_ca_donation_id_2b5a9716_fk_donation_ FOREIGN KEY (donation_id) REFERENCES public.donation_donation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: donation_donation donation_donation_institution_id_2ae1ccf6_fk_donation_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_donation
    ADD CONSTRAINT donation_donation_institution_id_2ae1ccf6_fk_donation_ FOREIGN KEY (institution_id) REFERENCES public.donation_institution(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: donation_donation donation_donation_user_id_c2eb4cc0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_donation
    ADD CONSTRAINT donation_donation_user_id_c2eb4cc0_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: donation_institution_categories donation_institution_category_id_0dae5f89_fk_donation_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_institution_categories
    ADD CONSTRAINT donation_institution_category_id_0dae5f89_fk_donation_ FOREIGN KEY (category_id) REFERENCES public.donation_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: donation_institution_categories donation_institution_institution_id_520f7bba_fk_donation_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donation_institution_categories
    ADD CONSTRAINT donation_institution_institution_id_520f7bba_fk_donation_ FOREIGN KEY (institution_id) REFERENCES public.donation_institution(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

