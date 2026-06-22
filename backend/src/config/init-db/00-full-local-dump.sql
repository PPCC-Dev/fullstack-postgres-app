--
-- PostgreSQL database dump
--

\restrict f7VrWXVIfXPVvypEfnf76J4woXt353qGwSWKXJ4q3pD9fjffnQWGgdbJvDoIczU

-- Dumped from database version 15.18 (Homebrew)
-- Dumped by pg_dump version 15.18 (Homebrew)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: customer_contacts; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.customer_contacts (
    id integer NOT NULL,
    contact_name character varying(255),
    cust_num character varying(100),
    first_name character varying(255),
    last_name character varying(255),
    department character varying(255),
    email character varying(255),
    phone character varying(100),
    tel character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customer_contacts OWNER TO tunited;

--
-- Name: customer_contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: tunited
--

CREATE SEQUENCE public.customer_contracts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_contracts_id_seq OWNER TO tunited;

--
-- Name: customer_contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tunited
--

ALTER SEQUENCE public.customer_contracts_id_seq OWNED BY public.customer_contacts.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    cust_num character varying(50) NOT NULL,
    cust_name character varying(150) NOT NULL,
    contact_email character varying(100),
    version character varying(100),
    license character varying(100),
    account_owner character varying(100),
    infor_ma character varying(100),
    ppcc_app_ma character varying(100),
    ppcc_cust_ma character varying(100),
    ppcc_tech_ma character varying(100),
    prefix character varying(50)
);


ALTER TABLE public.customers OWNER TO tunited;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: tunited
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO tunited;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tunited
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: error_types; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.error_types (
    error_id character varying(10) NOT NULL,
    description character varying(150) NOT NULL,
    remark text
);


ALTER TABLE public.error_types OWNER TO tunited;

--
-- Name: issue_types; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.issue_types (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.issue_types OWNER TO tunited;

--
-- Name: issue_types_id_seq; Type: SEQUENCE; Schema: public; Owner: tunited
--

CREATE SEQUENCE public.issue_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.issue_types_id_seq OWNER TO tunited;

--
-- Name: issue_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tunited
--

ALTER SEQUENCE public.issue_types_id_seq OWNED BY public.issue_types.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    ticket_id integer,
    sender_id integer,
    message_text text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_internal boolean DEFAULT false
);


ALTER TABLE public.messages OWNER TO tunited;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: tunited
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO tunited;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tunited
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: module_program_group; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.module_program_group (
    id integer NOT NULL,
    module character varying(100),
    program_group character varying(255),
    note character varying(255)
);


ALTER TABLE public.module_program_group OWNER TO tunited;

--
-- Name: module_program_group_id_seq; Type: SEQUENCE; Schema: public; Owner: tunited
--

CREATE SEQUENCE public.module_program_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.module_program_group_id_seq OWNER TO tunited;

--
-- Name: module_program_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tunited
--

ALTER SEQUENCE public.module_program_group_id_seq OWNED BY public.module_program_group.id;


--
-- Name: modules; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.modules (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(255)
);


ALTER TABLE public.modules OWNER TO tunited;

--
-- Name: modules_id_seq; Type: SEQUENCE; Schema: public; Owner: tunited
--

CREATE SEQUENCE public.modules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modules_id_seq OWNER TO tunited;

--
-- Name: modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tunited
--

ALTER SEQUENCE public.modules_id_seq OWNED BY public.modules.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer,
    title character varying(200) NOT NULL,
    message text NOT NULL,
    is_read boolean DEFAULT false,
    type character varying(50),
    ticket_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.notifications OWNER TO tunited;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: tunited
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO tunited;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tunited
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: program_types; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.program_types (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    value character varying(50)
);


ALTER TABLE public.program_types OWNER TO tunited;

--
-- Name: program_types_id_seq; Type: SEQUENCE; Schema: public; Owner: tunited
--

CREATE SEQUENCE public.program_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.program_types_id_seq OWNER TO tunited;

--
-- Name: program_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tunited
--

ALTER SEQUENCE public.program_types_id_seq OWNED BY public.program_types.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    base_role character varying(20) DEFAULT 'customer'::character varying NOT NULL,
    CONSTRAINT roles_base_role_check CHECK (((base_role)::text = ANY ((ARRAY['customer'::character varying, 'agent'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.roles OWNER TO tunited;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: tunited
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO tunited;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tunited
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: support_stats; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.support_stats (
    stat character varying(10) NOT NULL,
    description character varying(255) NOT NULL,
    remark text,
    seq integer DEFAULT 9999
);


ALTER TABLE public.support_stats OWNER TO tunited;

--
-- Name: ticket_attachments; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.ticket_attachments (
    id integer NOT NULL,
    ticket_id integer,
    file_url character varying(255) NOT NULL,
    file_name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ticket_attachments OWNER TO tunited;

--
-- Name: ticket_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: tunited
--

CREATE SEQUENCE public.ticket_attachments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticket_attachments_id_seq OWNER TO tunited;

--
-- Name: ticket_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tunited
--

ALTER SEQUENCE public.ticket_attachments_id_seq OWNED BY public.ticket_attachments.id;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.tickets (
    id integer NOT NULL,
    title character varying(500) NOT NULL,
    description text NOT NULL,
    priority character varying(20) DEFAULT 'medium'::character varying NOT NULL,
    status character varying(20),
    customer_id integer,
    agent_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    module character varying(50) DEFAULT 'GeneralLedger'::character varying NOT NULL,
    resolved_at timestamp without time zone,
    solution text,
    workaround text,
    attachment_url character varying(255),
    attachment_name character varying(255),
    resolved_by integer,
    cust_num character varying(50),
    ticket_number character varying(30),
    assigned_at timestamp without time zone,
    form_name character varying(255),
    additional_email character varying(255),
    program_type character varying(100) DEFAULT 'Standard'::character varying,
    issue_type character varying(100) DEFAULT 'Technical'::character varying,
    contact_name character varying(255),
    request_date date DEFAULT CURRENT_TIMESTAMP,
    request_time time without time zone DEFAULT CURRENT_TIME,
    cause text,
    remark text,
    projected_date date,
    CONSTRAINT tickets_priority_check CHECK (((priority)::text = ANY ((ARRAY['low'::character varying, 'medium'::character varying, 'high'::character varying])::text[])))
);


ALTER TABLE public.tickets OWNER TO tunited;

--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: tunited
--

CREATE SEQUENCE public.tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tickets_id_seq OWNER TO tunited;

--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tunited
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: tunited
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role character varying(20) DEFAULT 'customer'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_verified boolean DEFAULT false,
    cust_num character varying(255),
    reset_password_token character varying(255),
    reset_password_expires timestamp without time zone
);


ALTER TABLE public.users OWNER TO tunited;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: tunited
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO tunited;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tunited
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: customer_contacts id; Type: DEFAULT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.customer_contacts ALTER COLUMN id SET DEFAULT nextval('public.customer_contracts_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: issue_types id; Type: DEFAULT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.issue_types ALTER COLUMN id SET DEFAULT nextval('public.issue_types_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: module_program_group id; Type: DEFAULT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.module_program_group ALTER COLUMN id SET DEFAULT nextval('public.module_program_group_id_seq'::regclass);


--
-- Name: modules id; Type: DEFAULT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.modules ALTER COLUMN id SET DEFAULT nextval('public.modules_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: program_types id; Type: DEFAULT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.program_types ALTER COLUMN id SET DEFAULT nextval('public.program_types_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: ticket_attachments id; Type: DEFAULT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.ticket_attachments ALTER COLUMN id SET DEFAULT nextval('public.ticket_attachments_id_seq'::regclass);


--
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: customer_contacts; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.customer_contacts (id, contact_name, cust_num, first_name, last_name, department, email, phone, tel, created_at, updated_at) FROM stdin;
1	K.Kanjana	ADI	Kanjana			kanjana@ad-castingth.com			2026-06-21 16:00:20.008968	2026-06-21 16:00:20.008968
2	K.Natthakan	ADI	Natthakan		IT	it@ad-castingth.com			2026-06-21 16:00:20.035105	2026-06-21 16:00:20.035105
3	K.Panida	ADI	Panida						2026-06-21 16:00:20.03599	2026-06-21 16:00:20.03599
4	K.Rachani	ADI	Rachani			rachani@ad-castingth.com			2026-06-21 16:00:20.036905	2026-06-21 16:00:20.036905
5	K.Tarn	ADI	Tarn			tarn@ad-castingth.com			2026-06-21 16:00:20.03942	2026-06-21 16:00:20.03942
6	Natty	ADI	Natty			it@ad-castingth.com			2026-06-21 16:00:20.040283	2026-06-21 16:00:20.040283
7	Akebodin Srimuan	BISW	Akebodin	Srimuan					2026-06-21 16:00:20.040673	2026-06-21 16:00:20.040673
8	Amnart Sornyai	BISW	Amnart	Sornyai					2026-06-21 16:00:20.041086	2026-06-21 16:00:20.041086
9	Arisara Supawadee	BISW	Arisara	Supawadee					2026-06-21 16:00:20.04193	2026-06-21 16:00:20.04193
10	ASP	ART	ASP			ac2@art-piston.co.th			2026-06-21 16:00:20.043748	2026-06-21 16:00:20.043748
11	K.Anchalee	ART	Anchalee			anchalee@art-piston.co.th			2026-06-21 16:00:20.044307	2026-06-21 16:00:20.044307
12	K.Chananart	ART	อี๊ด						2026-06-21 16:00:20.044776	2026-06-21 16:00:20.044776
13	K.Chinda	ART	จินดา			chinda@art-piston.co.th			2026-06-21 16:00:20.045156	2026-06-21 16:00:20.045156
14	K.Lawan	ART	Lawan			lawan@art-piston.co.th			2026-06-21 16:00:20.045471	2026-06-21 16:00:20.045471
15	K.Nuntana	ART	Nuntana						2026-06-21 16:00:20.045842	2026-06-21 16:00:20.045842
16	K.Pornpimol	ART	Pornpimol						2026-06-21 16:00:20.046159	2026-06-21 16:00:20.046159
17	K.Rungnapa	ART	แหม่ม						2026-06-21 16:00:20.0465	2026-06-21 16:00:20.0465
18	K.Suwat	ART	Suwat			it@art-piston.co.th			2026-06-21 16:00:20.046817	2026-06-21 16:00:20.046817
19	K.Withaya	ART	Withaya						2026-06-21 16:00:20.047234	2026-06-21 16:00:20.047234
20	K.มด	ART	มด						2026-06-21 16:00:20.048044	2026-06-21 16:00:20.048044
21	K.เอี้ยม	ART	Visan			visan@art-piston.co.th			2026-06-21 16:00:20.048456	2026-06-21 16:00:20.048456
22	Prapaporn Lhaprom	ART	Prapaporn		Marketing Department	mk1@art-piston.co.th			2026-06-21 16:00:20.048795	2026-06-21 16:00:20.048795
23	Akebodin	BISW	นัท		IT CCH /  Programmer CCH	it@bisw.co.th			2026-06-21 16:00:20.049111	2026-06-21 16:00:20.049111
24	Amnart	BISW	อำนาจ		IT BISW / Programmer	it@bisw.co.th			2026-06-21 16:00:20.051423	2026-06-21 16:00:20.051423
25	Arisara	BISW	กอ						2026-06-21 16:00:20.052267	2026-06-21 16:00:20.052267
26	Aum	BISW	อุ้ม						2026-06-21 16:00:20.052686	2026-06-21 16:00:20.052686
27	BISW Marketing	BISW	BISW		ส่วนกลาง ตลาด / ส่วนกลาง SALE	bisw.marketing@hotmail.com			2026-06-21 16:00:20.053096	2026-06-21 16:00:20.053096
28	BISW Purchase	BISW	BISW			purchase.bisw@gmail.com			2026-06-21 16:00:20.053418	2026-06-21 16:00:20.053418
29	Boonreing	BISW	หมี		ควมคุมคุณภาพและวิศวกรรม / QC-LAB	kantiwam@bisw.co.th			2026-06-21 16:00:20.053689	2026-06-21 16:00:20.053689
30	Charinya	BISW	แอน		ประสานงานบริการ / ธุรการ	wuttichais@bisw.co.th			2026-06-21 16:00:20.054738	2026-06-21 16:00:20.054738
31	Chiradet	BISW	คิง		ผลิตเหล็กแท่ง / ผลิต Production เหล็กแท่ง	chiradett@bisw.co.th			2026-06-21 16:00:20.056709	2026-06-21 16:00:20.056709
32	Chuleeporn	BISW	Chuleeporn						2026-06-21 16:00:20.057348	2026-06-21 16:00:20.057348
33	Dawin	BISW	แคร์		พัฒนาผลิตภัณฑ์  / R&D ผลิตภัณฑ์ใหม่	dawink@bisw.co.th			2026-06-21 16:00:20.057681	2026-06-21 16:00:20.057681
34	Jeab	BISW	เจี๊ยบ			neojeab25@gmail.com			2026-06-21 16:00:20.05799	2026-06-21 16:00:20.05799
35	K. Nitaya	BISW	Nitaya		บัญชี / บัญชี	kabdanitya@gmail.com			2026-06-21 16:00:20.059524	2026-06-21 16:00:20.059524
36	K. ทิพวรรณ	BISW	ทิพวรรณ		บัญชี / บัญชี	aumaemtip@gmail.com			2026-06-21 16:00:20.060043	2026-06-21 16:00:20.060043
37	K.Best	BISW	K.Best		Warehouse				2026-06-21 16:00:20.060362	2026-06-21 16:00:20.060362
38	k.Luksana	BISW	k.Luksana			bisw.support@ppcc.co.th			2026-06-21 16:00:20.060641	2026-06-21 16:00:20.060641
39	K.Thawach	BISW	คุณธวัช						2026-06-21 16:00:20.060951	2026-06-21 16:00:20.060951
40	Kantiwat	BISW	ปาล์ม		ควมคุมคุณภาพและวิศวกรรม / QC-LAB	kantiwam@bisw.co.th			2026-06-21 16:00:20.061271	2026-06-21 16:00:20.061271
41	Korn	BISW	Korn						2026-06-21 16:00:20.061638	2026-06-21 16:00:20.061638
42	Kritsadakorn	BISW	เบส		วางแผนและพัฒนาสินค้าคงคลัง / วางแผน	krisadakornt@bisw.co.th			2026-06-21 16:00:20.061959	2026-06-21 16:00:20.061959
43	Laksana	BISW	แต๋ว		บัญชี / บัญชี	pasi-bisw@hotmail.co.th			2026-06-21 16:00:20.06225	2026-06-21 16:00:20.06225
44	Narong	BISW	หนุ่ม		ลาออก				2026-06-21 16:00:20.062535	2026-06-21 16:00:20.062535
45	Nittaya	BISW	นิตย์		ประสานงานบริการ / ผลิตภัณฑ์ฯ	wuttichais@bisw.co.th			2026-06-21 16:00:20.062811	2026-06-21 16:00:20.062811
46	Nuppadol	BISW	เซง		บัญชี / บัญชี	noppadols@bisw.co.th			2026-06-21 16:00:20.063094	2026-06-21 16:00:20.063094
47	Nuttapat	BISW	ตุ้ม Nuttapat		ควมคุมคุณภาพและวิศวกรรม / QC-LAB	nuttapaty@bisw.co.th			2026-06-21 16:00:20.063384	2026-06-21 16:00:20.063384
48	Paibon	BISW	ไพบูลย์		ผลิตเหล็กรีด / ซ่อมบำรุงไฟฟ้า RM9	paiboonu@bisw.co.th			2026-06-21 16:00:20.063655	2026-06-21 16:00:20.063655
49	Phanida	BISW	จุ๋ม		การตลาด /  SALE	bisw.marketing@hotmail.com			2026-06-21 16:00:20.06393	2026-06-21 16:00:20.06393
50	pichits	BISW	pichits		ควมคุมคุณภาพและวิศวกรรม / IT@สื่อสาร	pichits@bisw.oc.th			2026-06-21 16:00:20.064206	2026-06-21 16:00:20.064206
51	Pitiya	BISW	เมย์		การตลาด /  การตลาด	pitiyap@bisw.co.th			2026-06-21 16:00:20.064491	2026-06-21 16:00:20.064491
52	Piyangkoon	BISW	Piyangkoon			bisw.marketing@hotmail.com			2026-06-21 16:00:20.064762	2026-06-21 16:00:20.064762
53	PP.	BISW	PP.						2026-06-21 16:00:20.065013	2026-06-21 16:00:20.065013
54	Prakaidaw	BISW	Prakaidaw		การตลาด /  SALE	bisw.marketing@hotmail.com			2026-06-21 16:00:20.065302	2026-06-21 16:00:20.065302
55	Prasad	BISW	ประสาท		จัดซือและสโตร์กลาง / สโตร์กลาง	Store@bisw.co.th			2026-06-21 16:00:20.065566	2026-06-21 16:00:20.065566
56	Prasit	BISW	ประสิทธิ		บัญชี / บัญชี	pasi-bisw@hotmail.co.th			2026-06-21 16:00:20.065814	2026-06-21 16:00:20.065814
57	Prisan	BISW	เปี๊ยก		IT CCH /  Programmer CCH	it@bisw.co.th			2026-06-21 16:00:20.066064	2026-06-21 16:00:20.066064
58	Pueng	BISW	ผึ้ง						2026-06-21 16:00:20.066303	2026-06-21 16:00:20.066303
59	Punlop	BISW	เกมส์		ควมคุมคุณภาพและวิศวกรรม / IT@สื่อสาร	it@bisw.co.th			2026-06-21 16:00:20.066554	2026-06-21 16:00:20.066554
60	Renu	BISW	เรณู		บัญชี / บัญชี	renur@bisw.co.th			2026-06-21 16:00:20.066785	2026-06-21 16:00:20.066785
61	Sakchai	BISW	ดำ		การตลาด /  การตลาด	bisw.marketing@hotmail.com			2026-06-21 16:00:20.067049	2026-06-21 16:00:20.067049
62	Seksan	BISW	เสก		ผลิตเหล็กรีด / ผลิต Production RM9	seksonk@bisw.co.th			2026-06-21 16:00:20.067755	2026-06-21 16:00:20.067755
63	Siriporn	BISW	จิ๋ม		ลาออก				2026-06-21 16:00:20.068339	2026-06-21 16:00:20.068339
64	Supawadee	BISW	กอ		จัดซือและสโตร์กลาง / จัดซือ	officepurchasing@bisw.co.th	02-0918500 # 1802		2026-06-21 16:00:20.068698	2026-06-21 16:00:20.068698
65	Tacha	BISW	เจิ้น		โรงรีด Rolling Mill / ผลิตไฟฟ้า RM.9	tachan@bisw.co.th			2026-06-21 16:00:20.069051	2026-06-21 16:00:20.069051
301	Nittaya Wongsuwan	BISW	Nittaya	Wongsuwan					2026-06-21 16:00:20.125742	2026-06-21 16:00:20.125742
66	Thawat	BISW	ธวัช		การตลาด /  การตลาด	thawatj@bisw.co.th			2026-06-21 16:00:20.069436	2026-06-21 16:00:20.069436
67	Ubon	BISW	ติ๋ม		บัญชี / บัญชี	pasi-bisw@hotmail.co.th			2026-06-21 16:00:20.071897	2026-06-21 16:00:20.071897
68	Unchana	BISW	นิว		จัดซือและสโตร์กลาง / จัดซือ	unchanas@bisw.co.th			2026-06-21 16:00:20.073115	2026-06-21 16:00:20.073115
69	Wanna	BISW	ฮ้ว		บัญชี CCH  / บัญชี CCH	pasi-bisw@hotmail.co.th			2026-06-21 16:00:20.073459	2026-06-21 16:00:20.073459
70	Weera	BISW	วีระ		ผลิตเหล็กแท่ง / ซ่อมบำรุงไฟฟ้าเหล็กแท่ง	weerar@bisw.co.th			2026-06-21 16:00:20.073769	2026-06-21 16:00:20.073769
71	Weerathep	BISW	ท็อป		ลาออก				2026-06-21 16:00:20.074069	2026-06-21 16:00:20.074069
72	Wuttichai	BISW	ปิง		ประสานงานบริการ / ส่วนประสานงานบริการ	wuttichais@bisw.co.th			2026-06-21 16:00:20.074353	2026-06-21 16:00:20.074353
73	Boonreing Prathumchompoo	BISW	Prathumchompoo		BISW	หมี			2026-06-21 16:00:20.074631	2026-06-21 16:00:20.074631
74	Accounting Pole	CCH	Accounting			accounting_pole@cch.co.th			2026-06-21 16:00:20.074919	2026-06-21 16:00:20.074919
75	K. ธีรภัทร	CCH	ธีรภัทร			scen944@gmail.com			2026-06-21 16:00:20.075296	2026-06-21 16:00:20.075296
76	K.Ariwan	CCH	Ariwan						2026-06-21 16:00:20.077254	2026-06-21 16:00:20.077254
77	K.Chirawan	CCH	Chirawan						2026-06-21 16:00:20.077817	2026-06-21 16:00:20.077817
78	K.Chudaporn	CCH	Chudaporn						2026-06-21 16:00:20.078086	2026-06-21 16:00:20.078086
79	K.Kanlaya	CCH	Kanlaya			kanlaya321@hotmail.com			2026-06-21 16:00:20.078374	2026-06-21 16:00:20.078374
80	K.Kanokkon	CCH	Kanokkon			nu_koyacc@hotmail.com			2026-06-21 16:00:20.078662	2026-06-21 16:00:20.078662
81	K.Kanokkorn	CCH	Kanokkorn			Kanokkorn.cch@hotmail.com			2026-06-21 16:00:20.078928	2026-06-21 16:00:20.078928
82	K.Ketsuda	CCH	Ketsuda						2026-06-21 16:00:20.079219	2026-06-21 16:00:20.079219
83	K.Khanisorn	CCH	Khanisorn			kannakalove@gmail.com			2026-06-21 16:00:20.079655	2026-06-21 16:00:20.079655
84	K.Nipaporn	CCH	Nipaporn						2026-06-21 16:00:20.079929	2026-06-21 16:00:20.079929
85	K.Paisan	CCH	K.Paisan			peakerdi@outlook.com			2026-06-21 16:00:20.08038	2026-06-21 16:00:20.08038
86	K.Pakorn	CCH	Pakorn		IT	pakorn.thetchantug@gmail.com			2026-06-21 16:00:20.080636	2026-06-21 16:00:20.080636
87	K.Pornnipa	CCH	Pornnipa			nppr28@yahoo.com			2026-06-21 16:00:20.080872	2026-06-21 16:00:20.080872
88	K.Pranee	CCH	Pranee						2026-06-21 16:00:20.081135	2026-06-21 16:00:20.081135
89	K.Thamonwan	CCH	Thamonwan						2026-06-21 16:00:20.081445	2026-06-21 16:00:20.081445
90	K.ธมนวรรณ	CCH	ธมนวรรณ			thamonwan_nooploy@hotmail.com			2026-06-21 16:00:20.081691	2026-06-21 16:00:20.081691
91	K.เปี๊ยก	CCH	เปี๊ยก			cch.support@ppcc.co.th			2026-06-21 16:00:20.081946	2026-06-21 16:00:20.081946
92	K.ภาณุวัฒน์	CCH	ภาณุวัฒน์			panuwat170411@gmail.com			2026-06-21 16:00:20.082189	2026-06-21 16:00:20.082189
93	K.วันดี	CCH	วันดี			wandee.t@cch.co.th			2026-06-21 16:00:20.082517	2026-06-21 16:00:20.082517
94	เอกบดินทร์	CCH	เอกบดินทร์			itsupport@cch.co.th			2026-06-21 16:00:20.082784	2026-06-21 16:00:20.082784
95	Charinya Kaikaew	BISW	Kaikaew		BISW	แอน			2026-06-21 16:00:20.083054	2026-06-21 16:00:20.083054
96	Chiradet Thammasirilak	BISW	Thammasirilak		BISW	คิง			2026-06-21 16:00:20.083326	2026-06-21 16:00:20.083326
97	Accounting	CNI	Accounting			acc_cni@cni-eng.co.th			2026-06-21 16:00:20.083583	2026-06-21 16:00:20.083583
98	Ao	CNI	Ao		ACC	ao_kinre@cni-eng.co.th			2026-06-21 16:00:20.083862	2026-06-21 16:00:20.083862
99	K.Arin	CNI	Arin						2026-06-21 16:00:20.084158	2026-06-21 16:00:20.084158
100	K.Dear	CNI	K. Dear						2026-06-21 16:00:20.084465	2026-06-21 16:00:20.084465
101	K.Fai	CNI	K.Fai						2026-06-21 16:00:20.084921	2026-06-21 16:00:20.084921
102	K.Fern	CNI	Fern						2026-06-21 16:00:20.085552	2026-06-21 16:00:20.085552
103	K.Kae	CNI	Kae			cni.support@ppcc.co.th			2026-06-21 16:00:20.085859	2026-06-21 16:00:20.085859
104	K.Kanya	CNI	Kanya			kanya_r@cni-eng.co.th			2026-06-21 16:00:20.086179	2026-06-21 16:00:20.086179
105	K.Ketsuda	CNI	Ketsuda			ketsuda_p@cni-eng.co.th			2026-06-21 16:00:20.086463	2026-06-21 16:00:20.086463
106	K.Kung	CNI	Sunisa		ACC				2026-06-21 16:00:20.086735	2026-06-21 16:00:20.086735
107	K.Kwanchanok	CNI	ขวัญชนก						2026-06-21 16:00:20.086975	2026-06-21 16:00:20.086975
108	K.Monthakan	CNI	K.			cni.support@ppcc.co.th			2026-06-21 16:00:20.087393	2026-06-21 16:00:20.087393
109	K.Nanthita	CNI	Nanthita			nanthita_r@cni-eng.co.th			2026-06-21 16:00:20.087829	2026-06-21 16:00:20.087829
110	K.Nattanicha	CNI	Nattanicha			nattanicha_s@cni-eng.co.th			2026-06-21 16:00:20.08813	2026-06-21 16:00:20.08813
111	K.Nittaya	CNI	Nittaya						2026-06-21 16:00:20.088424	2026-06-21 16:00:20.088424
112	K.Nuanwan	CNI	Nuanwan			nuanwan_s@cni-eng.co.th			2026-06-21 16:00:20.088719	2026-06-21 16:00:20.088719
113	K.Pang	CNI	Pang						2026-06-21 16:00:20.089006	2026-06-21 16:00:20.089006
114	K.Pimpa	CNI	Pimpa						2026-06-21 16:00:20.089268	2026-06-21 16:00:20.089268
115	K.Ple	CNI	Ple						2026-06-21 16:00:20.089518	2026-06-21 16:00:20.089518
116	K.Rungnapa	CNI	Rungnapa			Rungnapa_p@cni-eng.co.th			2026-06-21 16:00:20.089773	2026-06-21 16:00:20.089773
117	K.Sopit (จัย)	CNI	Sopit						2026-06-21 16:00:20.090027	2026-06-21 16:00:20.090027
118	K.Sornsupat	CNI	Sorn						2026-06-21 16:00:20.090281	2026-06-21 16:00:20.090281
119	K.Tuk	CNI	Tuk						2026-06-21 16:00:20.090524	2026-06-21 16:00:20.090524
120	K.Wassana	CNI	Wassana						2026-06-21 16:00:20.090767	2026-06-21 16:00:20.090767
121	K.Witaya	CNI	Wittaya			wittaya_it@cni-eng.co.th			2026-06-21 16:00:20.091078	2026-06-21 16:00:20.091078
122	K.Yada	CNI	Yada						2026-06-21 16:00:20.091333	2026-06-21 16:00:20.091333
123	K.Yupin	CNI	Yupin			yupin@cni-eng.co.th			2026-06-21 16:00:20.091555	2026-06-21 16:00:20.091555
124	K.โด้	CNI	Pramot						2026-06-21 16:00:20.091771	2026-06-21 16:00:20.091771
125	K.ทราย	CNI	ทรายแสบ						2026-06-21 16:00:20.092001	2026-06-21 16:00:20.092001
126	K.ลัดดา	CNI	K.ลัดดา			cni.support@ppcc.co.th			2026-06-21 16:00:20.092247	2026-06-21 16:00:20.092247
127	Narin	CNI	narin		ACC	narin_f@cni-eng.co.th			2026-06-21 16:00:20.092476	2026-06-21 16:00:20.092476
128	Nutdanai	CNI	nutdanai		ACC	nutdanai@cni-eng.co.th			2026-06-21 16:00:20.092715	2026-06-21 16:00:20.092715
129	Ploy	CNI	Ploy						2026-06-21 16:00:20.092911	2026-06-21 16:00:20.092911
130	Dawin Klinbua	Dawin	Klinbua		BISW	แคร์			2026-06-21 16:00:20.093166	2026-06-21 16:00:20.093166
131	K.ampan	HA	ampan		Costing	ampan.pe@patkol.com			2026-06-21 16:00:20.093402	2026-06-21 16:00:20.093402
132	K.Anchalee	HA	Anchalee		Accounting	anchalee@patkol.com			2026-06-21 16:00:20.093609	2026-06-21 16:00:20.093609
133	K.Benchawan	HA	Benchawa			benchawan@patkol.com			2026-06-21 16:00:20.093802	2026-06-21 16:00:20.093802
134	K.Chanachon	HA	K>Chanachon		ICT Department	chanachon.pr@patkol.com	0-2328-1035 # 1820	095-705-2658	2026-06-21 16:00:20.093996	2026-06-21 16:00:20.093996
135	K.Charinrat	HA	Charinrat		Accounting -AR	charinrat.bo@patkol.com			2026-06-21 16:00:20.094229	2026-06-21 16:00:20.094229
136	K.Jantrawan	HA	Jantrawan			jantrawan.mo@patkol.com			2026-06-21 16:00:20.09442	2026-06-21 16:00:20.09442
137	K.Jeerachai	HA	Jeerachai						2026-06-21 16:00:20.094627	2026-06-21 16:00:20.094627
138	K.Jeeraporn	HA	Jeeraporn			jeeraporn.sa@patkol.com			2026-06-21 16:00:20.094847	2026-06-21 16:00:20.094847
139	K.Jongjit	HA	Jongjit			jongjit.pe@patkol.com			2026-06-21 16:00:20.095046	2026-06-21 16:00:20.095046
140	K.Jureerat	HA	Jureerat		Programmer /IT	Jureerat.bo@patkol.com	02-328-1035-49  # 1816		2026-06-21 16:00:20.095192	2026-06-21 16:00:20.095192
141	K.Kanonraya	HA	Kanonraya			kanonraya.th@patkol.com			2026-06-21 16:00:20.095328	2026-06-21 16:00:20.095328
142	K.Kanungnij	HA	Kanungnij		Accounting AP-AR	kanungnij@patkol.com			2026-06-21 16:00:20.095476	2026-06-21 16:00:20.095476
143	K.Kanya	HA	K.Kanya						2026-06-21 16:00:20.095612	2026-06-21 16:00:20.095612
144	K.Kanyaphak	HA	Kanyaphak		Finance	kanyaphak.ti@patkol.com			2026-06-21 16:00:20.095749	2026-06-21 16:00:20.095749
145	K.Kitchawan	HA	Kitchawan			kitchawan.sa@patkol.com		02 328 1035	2026-06-21 16:00:20.0959	2026-06-21 16:00:20.0959
146	K.Kitiya	HA	K.Kitiya						2026-06-21 16:00:20.096113	2026-06-21 16:00:20.096113
147	K.Lalita	HA	K.Lalita			lalita.we@patkol.com			2026-06-21 16:00:20.096275	2026-06-21 16:00:20.096275
148	K.Mewadee	HA	Mewadee		ICT Department	mewadee.th@patkol.com	0-2328-1035 # 1808		2026-06-21 16:00:20.096419	2026-06-21 16:00:20.096419
149	K.Nakorn	HA	K.Nakorn						2026-06-21 16:00:20.096553	2026-06-21 16:00:20.096553
150	K.Nan	HA	K.Nan		Finance		0-2328-1035 # 1808		2026-06-21 16:00:20.096691	2026-06-21 16:00:20.096691
151	K.Nannaphat	HA	Nannaphat			nannaphat.tr@patkol.com			2026-06-21 16:00:20.096828	2026-06-21 16:00:20.096828
152	K.Nanthiya	HA	Nanthiya			nanthiya.ka@patkol.com			2026-06-21 16:00:20.096993	2026-06-21 16:00:20.096993
153	K.Napaphat	HA	Naphphat			Napaphat.ru@patkol.com			2026-06-21 16:00:20.097126	2026-06-21 16:00:20.097126
154	K.Nid	HA	Nittaya		Accounting AP				2026-06-21 16:00:20.097255	2026-06-21 16:00:20.097255
155	K.Nipa	HA	Nipa		Fianace	nipa.sa@patkol.com			2026-06-21 16:00:20.097533	2026-06-21 16:00:20.097533
156	K.Nittaya	HA	Nittaya		Accounting AP				2026-06-21 16:00:20.097665	2026-06-21 16:00:20.097665
157	K.Orayanee	HA	Orayanee			orayanee.sa@patkol.com			2026-06-21 16:00:20.097797	2026-06-21 16:00:20.097797
158	K.Pattariya	HA	K.Pattariya			pattariya.su@patkol.com			2026-06-21 16:00:20.097926	2026-06-21 16:00:20.097926
159	K.Pornpimol	HA	Pornpimol		Accounting AP	pornpimol.ko@patkol.com			2026-06-21 16:00:20.098057	2026-06-21 16:00:20.098057
160	K.Praputsorn	HA	Praputsorn			praputsorn@patkol.com			2026-06-21 16:00:20.098186	2026-06-21 16:00:20.098186
161	K.Prasert	HA	Prasert			prasert.po@patkol.com			2026-06-21 16:00:20.098316	2026-06-21 16:00:20.098316
162	K.Prissana	HA	Prissana		ICT Department	prissana.to@patkol.com	0-2328-1035 # 1805		2026-06-21 16:00:20.098455	2026-06-21 16:00:20.098455
163	K.Rachpapha	HA	Rachpapha		Accounting -AP	rachpapha.ch@patkol.com			2026-06-21 16:00:20.098589	2026-06-21 16:00:20.098589
164	K.Ratmanee	HA	Ratmanee		Accounting AP	ratmanee.bo@patkol.com			2026-06-21 16:00:20.098735	2026-06-21 16:00:20.098735
165	K.Rattikan	HA	Rattikan			rattikan.kh@patkol.com			2026-06-21 16:00:20.098949	2026-06-21 16:00:20.098949
166	K.Saifon	HA	Saifon		Accounting	saifon.ma@patkol.com			2026-06-21 16:00:20.099138	2026-06-21 16:00:20.099138
167	K.Sirinat	HA	Sirinnat		ICT	sirinnat.ch@patkol.com	094-2245388	0-2328-1035 # 1810	2026-06-21 16:00:20.099309	2026-06-21 16:00:20.099309
168	K.Sirirak	HA	Sirirak		Accounting -FA				2026-06-21 16:00:20.099492	2026-06-21 16:00:20.099492
169	K.Somsri	HA	Somsri		Accounting AP	somsri.sa@patkol.com			2026-06-21 16:00:20.099704	2026-06-21 16:00:20.099704
170	K.Supaporn	HA	K.Supaporn			supaporn.lu@patkol.com		0-2328-1035 # 1803	2026-06-21 16:00:20.099921	2026-06-21 16:00:20.099921
171	K.Suprapa	HA	K.Suprapa			suprapa.ch@patkol.com			2026-06-21 16:00:20.100117	2026-06-21 16:00:20.100117
172	K.Tosapon	HA	Tosapon			tosapon@patkol.com			2026-06-21 16:00:20.100333	2026-06-21 16:00:20.100333
173	K.Wanlapa	HA	Wanlapa			wanlapa@patkol.com	089-524-0083	0-2328-1035 # 1815	2026-06-21 16:00:20.100708	2026-06-21 16:00:20.100708
174	K.Warattaya	HA	Warattaya			warattaya.jo@patkol.com			2026-06-21 16:00:20.101364	2026-06-21 16:00:20.101364
175	K.Warunee	HA	Warunee		Fianace				2026-06-21 16:00:20.101605	2026-06-21 16:00:20.101605
176	K.Watcharee	HA	Watcharee			watcharee@patkol.com			2026-06-21 16:00:20.101812	2026-06-21 16:00:20.101812
177	K.Watsana	HA	Watsana			watsana.pr@patkol.com			2026-06-21 16:00:20.102091	2026-06-21 16:00:20.102091
178	Nattakit Chairob	HA	Nattakit			nattakit.ch@patkol.com			2026-06-21 16:00:20.10231	2026-06-21 16:00:20.10231
179	PK.Panchai	HA	Panchai			panchai.th@patkol.com			2026-06-21 16:00:20.10251	2026-06-21 16:00:20.10251
180	PK-Anyarat	HA	Anyarat			anyarat.ja@patkol.com			2026-06-21 16:00:20.102678	2026-06-21 16:00:20.102678
181	PK-Chaiwat	HA	Chaiwat			chaiwat.wo@patkol.com			2026-06-21 16:00:20.102861	2026-06-21 16:00:20.102861
182	PK-Costing	HA	PK-Costing		PK-Costing				2026-06-21 16:00:20.103071	2026-06-21 16:00:20.103071
183	PK-Jaruwan	HA	Jaruwan			jaruwan.pu@heataway.net			2026-06-21 16:00:20.103269	2026-06-21 16:00:20.103269
184	PK-Jittiporn.pa	HA	Jittiporn			jittiporn.pa@patkol.com			2026-06-21 16:00:20.103458	2026-06-21 16:00:20.103458
185	PK-kanonraya	HA	Kanonraya			kanonraya.th@patkol.com			2026-06-21 16:00:20.103707	2026-06-21 16:00:20.103707
186	PK-Ladawan	HA	Ladawan			ladawan@patkol.com			2026-06-21 16:00:20.103897	2026-06-21 16:00:20.103897
187	PKM- Yaowapa	HA	Yaowapa		Accounting	yaowapa.ka@tygienic.com			2026-06-21 16:00:20.104066	2026-06-21 16:00:20.104066
188	PKM-Pattariya	HA	Pattariya		Accounting	pattariya.su@patkol.com			2026-06-21 16:00:20.10424	2026-06-21 16:00:20.10424
189	PKM-Puangpen	HA	Puangpen						2026-06-21 16:00:20.104416	2026-06-21 16:00:20.104416
190	PKM-Sunee	HA	Sunee			sunee@patkol.com			2026-06-21 16:00:20.104586	2026-06-21 16:00:20.104586
191	PK-Naiyana.jo	HA	Naiyana			naiyana.jo@patkol.com			2026-06-21 16:00:20.104752	2026-06-21 16:00:20.104752
192	PK-Natphaknaphat.ph	HA	Natphaknaphat			natphaknaphat.ph@patkol.com			2026-06-21 16:00:20.104937	2026-06-21 16:00:20.104937
193	PK-Panrawe	HA	PK-Panrawe						2026-06-21 16:00:20.105101	2026-06-21 16:00:20.105101
194	PK-Patcharakorn.we	HA	PK-Patcharakorn			patcharakorn.we@patkol.com			2026-06-21 16:00:20.10527	2026-06-21 16:00:20.10527
195	PK-Patcharapol.ru	HA	Patcharapol			patcharapol.ru@patkol.com			2026-06-21 16:00:20.105432	2026-06-21 16:00:20.105432
196	PK-Pisit	HA	Pisit			pisit.wi@patkol.com			2026-06-21 16:00:20.105595	2026-06-21 16:00:20.105595
197	PK-Pratana.yu	HA	Pratana			pratana.yu@patkol.com			2026-06-21 16:00:20.10579	2026-06-21 16:00:20.10579
198	PK-Sittidate	HA	Sittidate			Sittidate.bo@patkol.com			2026-06-21 16:00:20.105986	2026-06-21 16:00:20.105986
199	PK-Suksiri	HA	Suksiri		Section Head-Account	suksiri@patkol.com			2026-06-21 16:00:20.106172	2026-06-21 16:00:20.106172
200	PK-Sunisa.la	HA	Sunisa			Sunisa.la@patkol.com			2026-06-21 16:00:20.106358	2026-06-21 16:00:20.106358
201	PK-Supaporn.th	HA	Supaporn						2026-06-21 16:00:20.106542	2026-06-21 16:00:20.106542
202	PK-Supattra.pu	HA	Supattra			supattra.pu@patkol.com			2026-06-21 16:00:20.106702	2026-06-21 16:00:20.106702
203	PK-Tunyarat.nu	HA	Tunyara			tunyarat.nu@patkol.com			2026-06-21 16:00:20.106895	2026-06-21 16:00:20.106895
204	PK-warout.si	HA	Warout			warout.si@patkol.com			2026-06-21 16:00:20.107059	2026-06-21 16:00:20.107059
205	PK-Wilaiporn.pa	HA	Wilaiporn			wilaiporn.pa@patkol.com			2026-06-21 16:00:20.107223	2026-06-21 16:00:20.107223
206	PK-Wiroje	HA	K.Wiroje			wiroje.ob@patkol.com			2026-06-21 16:00:20.10739	2026-06-21 16:00:20.10739
207	Wanida	HA	Wanida			wanida.ho@heataway.net			2026-06-21 16:00:20.107549	2026-06-21 16:00:20.107549
208	K.Kittinut	HATO	Kittinut		IT				2026-06-21 16:00:20.107708	2026-06-21 16:00:20.107708
209	K.Ratri	HATO	Ratri						2026-06-21 16:00:20.107866	2026-06-21 16:00:20.107866
210	K.Siam	HATO	Siam			siam@hatopaint.com			2026-06-21 16:00:20.108027	2026-06-21 16:00:20.108027
211	K.Thitiwat	HATO	Thitiwat						2026-06-21 16:00:20.108191	2026-06-21 16:00:20.108191
212	K.Wisanu	HATO	Wisanu						2026-06-21 16:00:20.108348	2026-06-21 16:00:20.108348
213	K.Boy	HHT	Suphawat			ssrithawirat@harmlessharvest.com			2026-06-21 16:00:20.108509	2026-06-21 16:00:20.108509
214	K.Natcha	HHT	Natcha			nniljaeng@harmlessharvest.com			2026-06-21 16:00:20.10868	2026-06-21 16:00:20.10868
215	K.Suda	HHT	Suda			suda@harmlessharvest.com			2026-06-21 16:00:20.108831	2026-06-21 16:00:20.108831
216	K.Sujitra	HHT	Sujitra			ssrithawirat@harmlessharvest.com			2026-06-21 16:00:20.108997	2026-06-21 16:00:20.108997
217	K.Tongty	HHT	K.			bthongma@harmlessharvest.com			2026-06-21 16:00:20.109233	2026-06-21 16:00:20.109233
218	Maprang	HHT	Maprang			ssrithawirat@harmlessharvest.com			2026-06-21 16:00:20.109383	2026-06-21 16:00:20.109383
219	K' Jeeraporn.sa	ICE	Jeeraporn			jeeraporn.sa@patkol.com			2026-06-21 16:00:20.109561	2026-06-21 16:00:20.109561
220	K.Ampan	ICE	Ampan		Costing	ampan.pe@patkol.com			2026-06-21 16:00:20.109762	2026-06-21 16:00:20.109762
221	K.Anchalee	ICE	Anchalee		Accounting	anchalee@patkol.com			2026-06-21 16:00:20.109945	2026-06-21 16:00:20.109945
222	K.Benchawan	ICE	Benchawa			benchawan@patkol.com			2026-06-21 16:00:20.110098	2026-06-21 16:00:20.110098
223	K.Chanachon	ICE	K>Chanachon		ICT Department	chanachon.pr@patkol.com	0-2328-1035 # 1820	095-705-2658	2026-06-21 16:00:20.110246	2026-06-21 16:00:20.110246
224	K.Charinrat	ICE	Charinrat		Accounting -AR	charinrat.bo@patkol.com			2026-06-21 16:00:20.111259	2026-06-21 16:00:20.111259
225	K.Jantrawan	ICE	Jantrawan			jantrawan.mo@patkol.com			2026-06-21 16:00:20.111873	2026-06-21 16:00:20.111873
226	K.Jongjit	ICE	Jongjit			jongjit.pe@patkol.com			2026-06-21 16:00:20.112062	2026-06-21 16:00:20.112062
227	K.Jureerat	ICE	JUREERAT		Programmer /IT	Jureerat.bo@patkol.com	02-328-1035-49  # 1816		2026-06-21 16:00:20.112244	2026-06-21 16:00:20.112244
228	K.Kanungnij	ICE	kanungnij		Accounting AP-AR	kanungnij@patkol.com			2026-06-21 16:00:20.112451	2026-06-21 16:00:20.112451
229	K.Kanya	ICE	Kanya						2026-06-21 16:00:20.112637	2026-06-21 16:00:20.112637
230	K.Kanyaphak	ICE	Kanyaphak		Finance	kanyaphak.ti@patkol.com			2026-06-21 16:00:20.112802	2026-06-21 16:00:20.112802
231	K.kitchawan	ICE	K.kitchawan			kitchawan.sa@patkol.com		02 328 1035	2026-06-21 16:00:20.112988	2026-06-21 16:00:20.112988
232	K.Lalita	ICE	Lalita			lalita.we@patkol.com			2026-06-21 16:00:20.113169	2026-06-21 16:00:20.113169
233	K.Mewadee	ICE	Mewadee		ICT Department	mewadee.th@patkol.com	0-2328-1035 # 1808		2026-06-21 16:00:20.113351	2026-06-21 16:00:20.113351
234	K.Nakorn	ICE	Nakorn			nakorn.sr@patkol.com			2026-06-21 16:00:20.113532	2026-06-21 16:00:20.113532
235	K.Nannaphat	ICE	Nannaphat			nannaphat.tr@patkol.com			2026-06-21 16:00:20.113712	2026-06-21 16:00:20.113712
236	K.Nanthiya	ICE	Nanthiya			nanthiya.ka@patkol.com			2026-06-21 16:00:20.113893	2026-06-21 16:00:20.113893
237	K.Napaphat	ICE	Naphphat			Napaphat.ru@patkol.com			2026-06-21 16:00:20.114093	2026-06-21 16:00:20.114093
238	K.Nattakit	ICE	Nattakit		IT	nattakit.ch@patkol.com	5499	02-328-1035 Ext.1842	2026-06-21 16:00:20.114267	2026-06-21 16:00:20.114267
239	K.Nipa	ICE	Nipa		Fianace	nipa.sa@patkol.com			2026-06-21 16:00:20.114477	2026-06-21 16:00:20.114477
240	K.Nittaya	ICE	Nittaya		Accounting AP				2026-06-21 16:00:20.114671	2026-06-21 16:00:20.114671
241	K.Orathai	ICE	Orathai			orathai.ja@patkol.com			2026-06-21 16:00:20.114851	2026-06-21 16:00:20.114851
242	K.Orayanee	ICE	Orayanee			orayanee.sa@patkol.com			2026-06-21 16:00:20.115	2026-06-21 16:00:20.115
243	K.Pattariya	ICE	Pattariya			pattariya.su@patkol.com			2026-06-21 16:00:20.115179	2026-06-21 16:00:20.115179
244	K.Petchada	ICE	Petchada			petchada.bo@patkol.com			2026-06-21 16:00:20.115359	2026-06-21 16:00:20.115359
245	K.Pornpimol	ICE	Pornpimol		Accounting AP	pornpimol.ko@patkol.com			2026-06-21 16:00:20.115538	2026-06-21 16:00:20.115538
246	K.Praputsorn	ICE	Praputsorn			praputsorn@patkol.com			2026-06-21 16:00:20.115717	2026-06-21 16:00:20.115717
247	K.Prasert	ICE	Prasert			prasert.po@patkol.com			2026-06-21 16:00:20.115885	2026-06-21 16:00:20.115885
248	K.Prissana	ICE	Prissana		ICT Department	prissana.to@patkol.com	0-2328-1035 # 1805		2026-06-21 16:00:20.116053	2026-06-21 16:00:20.116053
249	K.Pu	ICE	คุณปุ๊						2026-06-21 16:00:20.116219	2026-06-21 16:00:20.116219
250	K.Rachpapha	ICE	Rachpapha		Accounting -AP	rachpapha.ch@patkol.com			2026-06-21 16:00:20.116382	2026-06-21 16:00:20.116382
251	K.Ratmanee	ICE	Ratmanee		Accounting AP	ratmanee.bo@patkol.com			2026-06-21 16:00:20.116551	2026-06-21 16:00:20.116551
252	K.Saifon	ICE	Saifon		Accounting	saifon.ma@patkol.com			2026-06-21 16:00:20.116731	2026-06-21 16:00:20.116731
253	K.Sirinat	ICE	Sirinnat		ICT	sirinnat.ch@patkol.com	094-2245388	0-2328-1035 # 1810	2026-06-21 16:00:20.11695	2026-06-21 16:00:20.11695
254	K.Sirirak	ICE	Sirirak		Accounting -FA				2026-06-21 16:00:20.117122	2026-06-21 16:00:20.117122
255	K.Somsri	ICE	Somsri		Accounting AP	somsri.sa@patkol.com			2026-06-21 16:00:20.11742	2026-06-21 16:00:20.11742
256	K.Supaporn	ICE	Supaporn			supaporn.lu@patkol.com		0-2328-1035 # 1803	2026-06-21 16:00:20.11765	2026-06-21 16:00:20.11765
257	K.Suprapa	ICE	Suprapa			suprapa.ch@patkol.com			2026-06-21 16:00:20.118139	2026-06-21 16:00:20.118139
258	K.Tosapon	ICE	Tosapon			tosapon@patkol.com			2026-06-21 16:00:20.118548	2026-06-21 16:00:20.118548
259	K.Wanlapa	ICE	Wanlapa			wanlapa@patkol.com	089-524-0083	0-2328-1035 # 1815	2026-06-21 16:00:20.118823	2026-06-21 16:00:20.118823
260	K.Warattaya	ICE	Warattaya			warattaya.jo@patkol.com			2026-06-21 16:00:20.118989	2026-06-21 16:00:20.118989
261	K.Warunee	ICE	Warunee		Fianace				2026-06-21 16:00:20.119152	2026-06-21 16:00:20.119152
262	K.Watcharee	ICE	Watcharee			watcharee@patkol.com			2026-06-21 16:00:20.11934	2026-06-21 16:00:20.11934
263	K.Watsana	ICE	Watsana			watsana.pr@patkol.com			2026-06-21 16:00:20.119554	2026-06-21 16:00:20.119554
264	K.Wiphawee	ICE	Wiphawee			wiphawee.su@patkol.com			2026-06-21 16:00:20.119748	2026-06-21 16:00:20.119748
265	PK.Panchai	ICE	Panchai			panchai.th@patkol.com			2026-06-21 16:00:20.119941	2026-06-21 16:00:20.119941
266	PK-Anyarat	ICE	Anyarat			anyarat.ja@patkol.com			2026-06-21 16:00:20.12012	2026-06-21 16:00:20.12012
267	PK-Chaiwat	ICE	Chaiwat			chaiwat.wo@patkol.com			2026-06-21 16:00:20.120302	2026-06-21 16:00:20.120302
268	PK-Costing	ICE	PK-Costing		PK-Costing				2026-06-21 16:00:20.120461	2026-06-21 16:00:20.120461
269	PK-Jaruwan	ICE	Jaruwan			jaruwan.pu@heataway.net			2026-06-21 16:00:20.12065	2026-06-21 16:00:20.12065
270	PK-Jittiporn.pa	ICE	Jittiporn			jittiporn.pa@patkol.com			2026-06-21 16:00:20.120827	2026-06-21 16:00:20.120827
271	PK-kanonraya	ICE	Kanonraya			kanonraya.th@patkol.com			2026-06-21 16:00:20.121005	2026-06-21 16:00:20.121005
272	PK-Ladawan	ICE	Ladawan			ladawan@patkol.com			2026-06-21 16:00:20.121159	2026-06-21 16:00:20.121159
273	PKM- Yaowapa	ICE	Yaowapa		Accounting	yaowapa.ka@tygienic.com			2026-06-21 16:00:20.121308	2026-06-21 16:00:20.121308
274	PKM-Pattariya	ICE	Pattariya		Accounting	pattariya.su@patkol.com			2026-06-21 16:00:20.121454	2026-06-21 16:00:20.121454
275	pkm-pattariya.su	ICE	Pattariya			pattariya.su@patkol.com			2026-06-21 16:00:20.12162	2026-06-21 16:00:20.12162
276	PKM-Puangpen	ICE	Puangpen						2026-06-21 16:00:20.121769	2026-06-21 16:00:20.121769
277	PKM-Sunee	ICE	Sunee			sunee@patkol.com			2026-06-21 16:00:20.121919	2026-06-21 16:00:20.121919
278	PK-Naiyana.jo	ICE	Naiyana			naiyana.jo@patkol.com			2026-06-21 16:00:20.122066	2026-06-21 16:00:20.122066
279	PK-Natphaknaphat.ph	ICE	Natphaknaphat			natphaknaphat.ph@patkol.com			2026-06-21 16:00:20.122211	2026-06-21 16:00:20.122211
280	PK-Panrawe	ICE	Panrawe						2026-06-21 16:00:20.122356	2026-06-21 16:00:20.122356
281	PK-Patcharakorn.we	ICE	Patcharakorn			patcharakorn.we@patkol.com			2026-06-21 16:00:20.122502	2026-06-21 16:00:20.122502
282	PK-Patcharapol.ru	ICE	Patcharapol			patcharapol.ru@patkol.com			2026-06-21 16:00:20.122679	2026-06-21 16:00:20.122679
283	PK-Pisit	ICE	Pisit			pisit.wi@patkol.com			2026-06-21 16:00:20.122855	2026-06-21 16:00:20.122855
284	PK-Pratana.yu	ICE	PK-Pratana			pratana.yu@patkol.com			2026-06-21 16:00:20.123031	2026-06-21 16:00:20.123031
285	PK-Sittidate	ICE	Sittidate			Sittidate.bo@patkol.com			2026-06-21 16:00:20.123207	2026-06-21 16:00:20.123207
286	PK-Suksiri	ICE	Suksiri		Section Head-Account	suksiri@patkol.com			2026-06-21 16:00:20.123391	2026-06-21 16:00:20.123391
287	PK-Sunisa.la	ICE	Sunisa			sunisa.la@patkol.com			2026-06-21 16:00:20.123548	2026-06-21 16:00:20.123548
288	PK-Supaporn.th	ICE	Supaporn			supaporn.th@patkol.com			2026-06-21 16:00:20.123706	2026-06-21 16:00:20.123706
289	PK-Supattra.pu	ICE	Supattra			supattra.pu@patkol.com			2026-06-21 16:00:20.123865	2026-06-21 16:00:20.123865
290	PK-Tunyarat.nu	ICE	Tunyara			tunyarat.nu@patkol.com			2026-06-21 16:00:20.124007	2026-06-21 16:00:20.124007
291	PK-warout.si	ICE	Warout			warout.si@patkol.com			2026-06-21 16:00:20.124327	2026-06-21 16:00:20.124327
292	PK-Wilaiporn.pa	ICE	Wilaiporn			wilaiporn.pa@patkol.com			2026-06-21 16:00:20.124472	2026-06-21 16:00:20.124472
293	PK-Wiroje	ICE	Wiroje			wiroje.ob@patkol.com			2026-06-21 16:00:20.124614	2026-06-21 16:00:20.124614
294	P'PED (PKM)	ICE	Sunee			sunee@patkol.com			2026-06-21 16:00:20.124756	2026-06-21 16:00:20.124756
295	K.Na	IIT	Na Rattanaporn						2026-06-21 16:00:20.124897	2026-06-21 16:00:20.124897
296	SUPANNIKA	IIT	Supannika			account.iit@inoac.co.th			2026-06-21 16:00:20.125041	2026-06-21 16:00:20.125041
297	Kantiwat Meesang	BISW	Kantiwat	Meesang					2026-06-21 16:00:20.125181	2026-06-21 16:00:20.125181
298	Kritsadakorn Thonsuthi	BISW	Kritsadako	Thonsuthi					2026-06-21 16:00:20.125318	2026-06-21 16:00:20.125318
299	Laksana Chankhum	BISW	Laksana	Chankhum					2026-06-21 16:00:20.125462	2026-06-21 16:00:20.125462
300	Narong Kaikaew	BISW	Narong	Kaikaew					2026-06-21 16:00:20.125604	2026-06-21 16:00:20.125604
302	K.Kritthana	NST	Kritthana						2026-06-21 16:00:20.125889	2026-06-21 16:00:20.125889
303	K.Pinyo	NST	Pinyo						2026-06-21 16:00:20.126135	2026-06-21 16:00:20.126135
304	K.Suchada	NST	Suchada			pepsidj1177@gmail.com			2026-06-21 16:00:20.126289	2026-06-21 16:00:20.126289
305	K.Wilailuk	NST	Wilailuk			wilailuk@nst.co.th			2026-06-21 16:00:20.126436	2026-06-21 16:00:20.126436
306	K.พี่แดง	NST	Dang						2026-06-21 16:00:20.12658	2026-06-21 16:00:20.12658
307	K.Butsaba	NTH	Butsaba			butsaba.s@nichicon.com			2026-06-21 16:00:20.126733	2026-06-21 16:00:20.126733
308	K.Chanisa	NTH	Chanisa			chanisa.j@nichicon.com			2026-06-21 16:00:20.12688	2026-06-21 16:00:20.12688
309	K.Chinchutha	NTH	Chinchutha			chinchutha.a@nichicon.com			2026-06-21 16:00:20.127057	2026-06-21 16:00:20.127057
310	K.Chuanpis	NTH	Chuanpis			chuanpis@nichicon.co.jp		02-6700150-2 Ext.17	2026-06-21 16:00:20.127232	2026-06-21 16:00:20.127232
311	K.Dararat	NTH	Dararat			dararat.m@nichicon.com			2026-06-21 16:00:20.127418	2026-06-21 16:00:20.127418
312	K.Fujino	NTH	Fujino			fujino.takao@nichicon.com			2026-06-21 16:00:20.127592	2026-06-21 16:00:20.127592
313	K.Giffy	NTH	K.			nth.supporrt@ppcc.co.th			2026-06-21 16:00:20.127767	2026-06-21 16:00:20.127767
314	K.Hamewadee	NTH	Hamewadee			rangchame.h@nichicon.com			2026-06-21 16:00:20.127939	2026-06-21 16:00:20.127939
315	K.Joom	NTH	Joom						2026-06-21 16:00:20.128106	2026-06-21 16:00:20.128106
316	K.Jutatip	NTH	Jutatip			jutatip.u@nichicon.com			2026-06-21 16:00:20.128278	2026-06-21 16:00:20.128278
317	K.Kimata	NTH	Yasuhiro						2026-06-21 16:00:20.12849	2026-06-21 16:00:20.12849
318	K.Kwanjai	NTH	Kwanjai						2026-06-21 16:00:20.12867	2026-06-21 16:00:20.12867
319	K.Manita	NTH	Manita			manita.s@nichicon.com			2026-06-21 16:00:20.128847	2026-06-21 16:00:20.128847
320	K.Muntana	NTH	Muntana						2026-06-21 16:00:20.129071	2026-06-21 16:00:20.129071
321	K.Nisakarn	NTH	Nisakarn			nisakarn.s@nichicon.com		0 2670 0150 Ext:18	2026-06-21 16:00:20.129244	2026-06-21 16:00:20.129244
322	K.Piyapat	NTH	Piyapat			piyapat.k@nichicon.com			2026-06-21 16:00:20.129417	2026-06-21 16:00:20.129417
323	K.Praweena	NTH	Praweena			praweena.p@nichicon.com			2026-06-21 16:00:20.129596	2026-06-21 16:00:20.129596
324	K.Rataporn	NTH	Rataporn			rataporn.s@nichicon.com			2026-06-21 16:00:20.129774	2026-06-21 16:00:20.129774
325	K.Subin	NTH	K.Subin			Subin.kw@thaitakagi.com			2026-06-21 16:00:20.129941	2026-06-21 16:00:20.129941
326	K.Suladda	NTH	Suladda			suladda.p@nichicon.com			2026-06-21 16:00:20.130116	2026-06-21 16:00:20.130116
327	K.Sumintra	NTH	Sumintra						2026-06-21 16:00:20.1303	2026-06-21 16:00:20.1303
328	K.Supata	NTH	Supata			thawewikyakan.s@nichicon.com			2026-06-21 16:00:20.13046	2026-06-21 16:00:20.13046
329	K.Tharini	NTH	Tharini			tharini.m@nichicon.com			2026-06-21 16:00:20.130646	2026-06-21 16:00:20.130646
330	K.Tippa	NTH	Tippa			tippa.b@nichicon.com			2026-06-21 16:00:20.130818	2026-06-21 16:00:20.130818
331	K.Tom	NTH	Tom						2026-06-21 16:00:20.130993	2026-06-21 16:00:20.130993
332	K.Varrin	NTH	Varrin			varrin.c@nichicon.com			2026-06-21 16:00:20.131169	2026-06-21 16:00:20.131169
333	Ms.Khavinrut	NTH	Ms.Khavinrut			chuanpis.k@nichicon.com	66891390042		2026-06-21 16:00:20.131345	2026-06-21 16:00:20.131345
334	Nuppadol Suwannakulrut	BISW	Suwannakulrut		BISW	เซง			2026-06-21 16:00:20.131521	2026-06-21 16:00:20.131521
335	Nuttapat Yawila	BISW	Yawila		BISW	ตุ้ม			2026-06-21 16:00:20.131696	2026-06-21 16:00:20.131696
336	K.Arporn	OTC	Arporn			arporn@ogihara.co.th			2026-06-21 16:00:20.131872	2026-06-21 16:00:20.131872
337	K.Benchamad	OTC	Benchamad			benchamad@ogihara.co.th		ต่อ 202	2026-06-21 16:00:20.132047	2026-06-21 16:00:20.132047
338	K.Dararay	OTC	Dararay		Account	dararay@ogihara.co.th		02-326-0433-6 Ext.202	2026-06-21 16:00:20.132196	2026-06-21 16:00:20.132196
339	K.Jittinan	OTC	Jittinan			jitinan@ogihara.co.th			2026-06-21 16:00:20.132368	2026-06-21 16:00:20.132368
340	K.Juthamas	OTC	Juthamas			juthamas@ogihara.co.th			2026-06-21 16:00:20.13251	2026-06-21 16:00:20.13251
341	K.Nantaya	OTC	Nantaya						2026-06-21 16:00:20.132661	2026-06-21 16:00:20.132661
342	K.Narissara	OTC	Narissara			narissara@ogihara.co.th			2026-06-21 16:00:20.132816	2026-06-21 16:00:20.132816
343	K.Nendnutcha	OTC	Nendnutcha			nendnutcha@ogihara.co.th			2026-06-21 16:00:20.132992	2026-06-21 16:00:20.132992
344	k.Pimtanatchaya	OTC	Pimtanatchaya		Purchasing	pimtanatchaya@ogihara.co.th			2026-06-21 16:00:20.133173	2026-06-21 16:00:20.133173
345	K.Rawisara	OTC	Rawisara			rawisara@ogihara.co.th			2026-06-21 16:00:20.133353	2026-06-21 16:00:20.133353
346	K.Suchada	OTC	Suchada			suchada@ogihara.co.th			2026-06-21 16:00:20.133509	2026-06-21 16:00:20.133509
347	K.Sukanya	OTC	Sukanya			sukanya@ogihara.co.th			2026-06-21 16:00:20.133747	2026-06-21 16:00:20.133747
348	K.Tanaprud	OTC	Tanaprud			tanaprud@ogihara.co.th			2026-06-21 16:00:20.133941	2026-06-21 16:00:20.133941
349	K.Wannachai	OTC	K.Wannachai			wannachai@ogihara.co.th			2026-06-21 16:00:20.134153	2026-06-21 16:00:20.134153
350	K.Wassana	OTC	Wassana			wassana@ogihara.co.th			2026-06-21 16:00:20.13435	2026-06-21 16:00:20.13435
351	K.Wilailak	OTC	Wilailak			wilailak@ogihara.co.th			2026-06-21 16:00:20.134513	2026-06-21 16:00:20.134513
352	Store	OTC	Store			store@ogihara.co.th			2026-06-21 16:00:20.134691	2026-06-21 16:00:20.134691
353	Thikamporn Damban	OTC	Thikamporn			thikamporn.d@ppcc.co.th			2026-06-21 16:00:20.1349	2026-06-21 16:00:20.1349
354	Paibon Uathaisong	BISW	Paibon		BISW	ไพบูลย์			2026-06-21 16:00:20.135061	2026-06-21 16:00:20.135061
355	Pichit Sriveerachai	BISW	Pichit		BISW	เล็ก			2026-06-21 16:00:20.1352	2026-06-21 16:00:20.1352
356	Pitiya Phothasri	BISW	Pitiya		BISW	เมย์			2026-06-21 16:00:20.135393	2026-06-21 16:00:20.135393
357	Alex Bozo (Line)	PK	Alex			IT-Support@patkol.com			2026-06-21 16:00:20.135537	2026-06-21 16:00:20.135537
358	K' Jeeraporn.sa	PK	Jeeraporn			jeeraporn.sa@patkol.com			2026-06-21 16:00:20.135677	2026-06-21 16:00:20.135677
359	K.Ampan	PK	Ampan		Costing	ampan.pe@patkol.com			2026-06-21 16:00:20.135823	2026-06-21 16:00:20.135823
360	K.Anchalee	PK	Anchalee		Accounting	anchalee@patkol.com			2026-06-21 16:00:20.135953	2026-06-21 16:00:20.135953
361	K.Benchawan	PK	Benchawa			benchawan@patkol.com			2026-06-21 16:00:20.136314	2026-06-21 16:00:20.136314
362	K.Chanachon	PK	K>Chanachon		ICT Department	chanachon.pr@patkol.com	0-2328-1035 # 1820	095-705-2658	2026-06-21 16:00:20.136448	2026-06-21 16:00:20.136448
363	K.Charinrat	PK	Charinrat		Accounting -AR	charinrat.bo@patkol.com			2026-06-21 16:00:20.136592	2026-06-21 16:00:20.136592
364	K.Jantrawan	PK	Jantrawan			jantrawan.mo@patkol.com			2026-06-21 16:00:20.136723	2026-06-21 16:00:20.136723
365	K.Jongjit	PK	Jongjit			jongjit.pe@patkol.com			2026-06-21 16:00:20.136886	2026-06-21 16:00:20.136886
366	K.Jureerat	PK	JUREERAT		Programmer /IT	Jureerat.bo@patkol.com	02-328-1035-49  # 1816		2026-06-21 16:00:20.137067	2026-06-21 16:00:20.137067
367	K.Kanungnij	PK	kanungnij		Accounting AP-AR	kanungnij@patkol.com			2026-06-21 16:00:20.137293	2026-06-21 16:00:20.137293
368	K.Kanya	PK	Kanya						2026-06-21 16:00:20.137445	2026-06-21 16:00:20.137445
369	K.Kanyaphak	PK	Kanyaphak		Finance	kanyaphak.ti@patkol.com			2026-06-21 16:00:20.137592	2026-06-21 16:00:20.137592
370	K.kitchawan	PK	K.kitchawan			kitchawan.sa@patkol.com		02 328 1035	2026-06-21 16:00:20.137728	2026-06-21 16:00:20.137728
371	K.Lalita	PK	Lalita			lalita.we@patkol.com			2026-06-21 16:00:20.137869	2026-06-21 16:00:20.137869
372	K.Mewadee	PK	Mewadee		ICT Department	mewadee.th@patkol.com	0-2328-1035 # 1808		2026-06-21 16:00:20.138004	2026-06-21 16:00:20.138004
373	K.Nakorn	PK	Nakorn			nakorn.sr@patkol.com			2026-06-21 16:00:20.138137	2026-06-21 16:00:20.138137
374	K.Nannaphat	PK	Nannaphat			nannaphat.tr@patkol.com			2026-06-21 16:00:20.138311	2026-06-21 16:00:20.138311
375	K.Nanthiya	PK	Nanthiya			nanthiya.ka@patkol.com			2026-06-21 16:00:20.138503	2026-06-21 16:00:20.138503
376	K.Napaphat	PK	Naphphat			Napaphat.ru@patkol.com			2026-06-21 16:00:20.138654	2026-06-21 16:00:20.138654
377	K.Nattakit	PK	Nattakit		IT	nattakit.ch@patkol.com	5499	02-328-1035 Ext.1842	2026-06-21 16:00:20.138785	2026-06-21 16:00:20.138785
378	K.Nipa	PK	Nipa		Fianace	nipa.sa@patkol.com			2026-06-21 16:00:20.138915	2026-06-21 16:00:20.138915
379	K.Nittaya	PK	Nittaya		Accounting AP				2026-06-21 16:00:20.13905	2026-06-21 16:00:20.13905
380	K.Orathai	PK	Orathai			orathai.ja@patkol.com			2026-06-21 16:00:20.139169	2026-06-21 16:00:20.139169
381	K.Orayanee	PK	Orayanee			orayanee.sa@patkol.com			2026-06-21 16:00:20.139287	2026-06-21 16:00:20.139287
382	K.Pattariya	PK	Pattariya			pattariya.su@patkol.com			2026-06-21 16:00:20.139404	2026-06-21 16:00:20.139404
383	K.Petchada	PK	Petchada			petchada.bo@patkol.com			2026-06-21 16:00:20.140507	2026-06-21 16:00:20.140507
384	K.Pornpimol	PK	Pornpimol		Accounting AP	pornpimol.ko@patkol.com			2026-06-21 16:00:20.140667	2026-06-21 16:00:20.140667
385	K.Praputsorn	PK	Praputsorn			praputsorn@patkol.com			2026-06-21 16:00:20.140797	2026-06-21 16:00:20.140797
386	K.Prasert	PK	Prasert			prasert.po@patkol.com			2026-06-21 16:00:20.140916	2026-06-21 16:00:20.140916
387	K.Prissana	PK	Prissana		ICT Department	prissana.to@patkol.com	0-2328-1035 # 1805		2026-06-21 16:00:20.141056	2026-06-21 16:00:20.141056
388	K.Pu	PK	คุณปุ๊						2026-06-21 16:00:20.14117	2026-06-21 16:00:20.14117
389	K.Rachpapha	PK	Rachpapha		Accounting -AP	rachpapha.ch@patkol.com			2026-06-21 16:00:20.141286	2026-06-21 16:00:20.141286
390	K.Ratmanee	PK	Ratmanee		Accounting AP	ratmanee.bo@patkol.com			2026-06-21 16:00:20.141397	2026-06-21 16:00:20.141397
391	K.Saifon	PK	Saifon		Accounting	saifon.ma@patkol.com			2026-06-21 16:00:20.141538	2026-06-21 16:00:20.141538
392	K.Sirinat	PK	Sirinnat		ICT	sirinnat.ch@patkol.com	094-2245388	0-2328-1035 # 1810	2026-06-21 16:00:20.141707	2026-06-21 16:00:20.141707
393	K.Sirirak	PK	Sirirak		Accounting -FA				2026-06-21 16:00:20.141827	2026-06-21 16:00:20.141827
394	K.Somsri	PK	Somsri		Accounting AP	somsri.sa@patkol.com			2026-06-21 16:00:20.141976	2026-06-21 16:00:20.141976
395	K.Supaporn	PK	Supaporn			supaporn.lu@patkol.com		0-2328-1035 # 1803	2026-06-21 16:00:20.142114	2026-06-21 16:00:20.142114
396	K.Suprapa	PK	Suprapa			suprapa.ch@patkol.com			2026-06-21 16:00:20.142302	2026-06-21 16:00:20.142302
397	K.Tosapon	PK	Tosapon			tosapon@patkol.com			2026-06-21 16:00:20.142436	2026-06-21 16:00:20.142436
398	K.Wanlapa	PK	Wanlapa			wanlapa@patkol.com	089-524-0083	0-2328-1035 # 1815	2026-06-21 16:00:20.142596	2026-06-21 16:00:20.142596
399	K.Warattaya	PK	Warattaya			warattaya.jo@patkol.com			2026-06-21 16:00:20.142834	2026-06-21 16:00:20.142834
400	K.Warunee	PK	Warunee		Fianace				2026-06-21 16:00:20.143197	2026-06-21 16:00:20.143197
401	K.Watcharee	PK	Watcharee			watcharee@patkol.com			2026-06-21 16:00:20.143361	2026-06-21 16:00:20.143361
402	K.Watsana	PK	Watsana			watsana.pr@patkol.com			2026-06-21 16:00:20.143504	2026-06-21 16:00:20.143504
403	K.Wiphawee	PK	Wiphawee			wiphawee.su@patkol.com			2026-06-21 16:00:20.143662	2026-06-21 16:00:20.143662
404	PK.Panchai	PK	Panchai			panchai.th@patkol.com			2026-06-21 16:00:20.143791	2026-06-21 16:00:20.143791
405	PK-Anyarat	PK	Anyarat			anyarat.ja@patkol.com			2026-06-21 16:00:20.143911	2026-06-21 16:00:20.143911
406	PK-Chaiwat	PK	Chaiwat			chaiwat.wo@patkol.com			2026-06-21 16:00:20.144048	2026-06-21 16:00:20.144048
407	PK-Costing	PK	PK-Costing		PK-Costing				2026-06-21 16:00:20.144174	2026-06-21 16:00:20.144174
408	PK-Jaruwan	PK	Jaruwan			jaruwan.pu@heataway.net			2026-06-21 16:00:20.144311	2026-06-21 16:00:20.144311
409	PK-Jittiporn.pa	PK	Jittiporn			jittiporn.pa@patkol.com			2026-06-21 16:00:20.144907	2026-06-21 16:00:20.144907
410	PK-kanonraya	PK	Kanonraya			kanonraya.th@patkol.com			2026-06-21 16:00:20.145053	2026-06-21 16:00:20.145053
411	PK-Ladawan	PK	Ladawan			ladawan@patkol.com			2026-06-21 16:00:20.145202	2026-06-21 16:00:20.145202
412	PKM- Yaowapa	PK	Yaowapa		Accounting	yaowapa.ka@tygienic.com			2026-06-21 16:00:20.145348	2026-06-21 16:00:20.145348
413	PKM-Pattariya	PK	Pattariya		Accounting	pattariya.su@patkol.com			2026-06-21 16:00:20.145478	2026-06-21 16:00:20.145478
414	pkm-pattariya.su	PK	Pattariya			pattariya.su@patkol.com			2026-06-21 16:00:20.145599	2026-06-21 16:00:20.145599
415	PKM-Puangpen	PK	Puangpen						2026-06-21 16:00:20.14573	2026-06-21 16:00:20.14573
416	PKM-Sunee	PK	Sunee			sunee@patkol.com			2026-06-21 16:00:20.145848	2026-06-21 16:00:20.145848
417	PK-Naiyana.jo	PK	Naiyana			naiyana.jo@patkol.com			2026-06-21 16:00:20.145974	2026-06-21 16:00:20.145974
418	PK-Natphaknaphat.ph	PK	Natphaknaphat			natphaknaphat.ph@patkol.com			2026-06-21 16:00:20.146082	2026-06-21 16:00:20.146082
419	PK-Panrawe	PK	Panrawe						2026-06-21 16:00:20.146183	2026-06-21 16:00:20.146183
420	PK-Patcharakorn.we	PK	Patcharakorn			patcharakorn.we@patkol.com			2026-06-21 16:00:20.146278	2026-06-21 16:00:20.146278
421	PK-Patcharapol.ru	PK	Patcharapol			patcharapol.ru@patkol.com			2026-06-21 16:00:20.146368	2026-06-21 16:00:20.146368
422	PK-Pisit	PK	Pisit			pisit.wi@patkol.com			2026-06-21 16:00:20.146468	2026-06-21 16:00:20.146468
423	PK-Pratana.yu	PK	PK-Pratana			pratana.yu@patkol.com			2026-06-21 16:00:20.146561	2026-06-21 16:00:20.146561
424	PK-Sittidate	PK	Sittidate			Sittidate.bo@patkol.com			2026-06-21 16:00:20.146656	2026-06-21 16:00:20.146656
425	PK-Suksiri	PK	Suksiri		Section Head-Account	suksiri@patkol.com			2026-06-21 16:00:20.146898	2026-06-21 16:00:20.146898
426	PK-Sunisa.la	PK	Sunisa			sunisa.la@patkol.com			2026-06-21 16:00:20.146987	2026-06-21 16:00:20.146987
427	PK-Supaporn.th	PK	Supaporn			supaporn.th@patkol.com			2026-06-21 16:00:20.147074	2026-06-21 16:00:20.147074
428	PK-Supattra.pu	PK	Supattra			supattra.pu@patkol.com			2026-06-21 16:00:20.147167	2026-06-21 16:00:20.147167
429	PK-Tunyarat.nu	PK	Tunyara			tunyarat.nu@patkol.com			2026-06-21 16:00:20.147268	2026-06-21 16:00:20.147268
430	PK-warout.si	PK	Warout			warout.si@patkol.com			2026-06-21 16:00:20.147368	2026-06-21 16:00:20.147368
431	PK-Wilaiporn.pa	PK	Wilaiporn			wilaiporn.pa@patkol.com			2026-06-21 16:00:20.147458	2026-06-21 16:00:20.147458
432	PK-Wiroje	PK	Wiroje			wiroje.ob@patkol.com			2026-06-21 16:00:20.147544	2026-06-21 16:00:20.147544
433	P'PED (PKM)	PK	Sunee			sunee@patkol.com			2026-06-21 16:00:20.147629	2026-06-21 16:00:20.147629
434	Alex Bozo (Line)	PKF	Alex			IT-Support@patkol.com			2026-06-21 16:00:20.147715	2026-06-21 16:00:20.147715
435	K' Jeeraporn.sa	PKF	Jeeraporn			jeeraporn.sa@patkol.com			2026-06-21 16:00:20.14781	2026-06-21 16:00:20.14781
436	K.Ampan	PKF	Ampan		Costing	ampan.pe@patkol.com			2026-06-21 16:00:20.147902	2026-06-21 16:00:20.147902
437	K.Anchalee	PKF	Anchalee		Accounting	anchalee@patkol.com			2026-06-21 16:00:20.147992	2026-06-21 16:00:20.147992
438	K.Benchawan	PKF	Benchawa			benchawan@patkol.com			2026-06-21 16:00:20.148077	2026-06-21 16:00:20.148077
439	K.Chanachon	PKF	K>Chanachon		ICT Department	chanachon.pr@patkol.com	0-2328-1035 # 1820	095-705-2658	2026-06-21 16:00:20.148162	2026-06-21 16:00:20.148162
440	K.Charinrat	PKF	Charinrat		Accounting -AR	charinrat.bo@patkol.com			2026-06-21 16:00:20.148247	2026-06-21 16:00:20.148247
441	K.Jantrawan	PKF	Jantrawan			jantrawan.mo@patkol.com			2026-06-21 16:00:20.14834	2026-06-21 16:00:20.14834
442	K.Jongjit	PKF	Jongjit			jongjit.pe@patkol.com			2026-06-21 16:00:20.148437	2026-06-21 16:00:20.148437
443	K.Jureerat	PKF	JUREERAT		Programmer /IT	Jureerat.bo@patkol.com	02-328-1035-49  # 1816		2026-06-21 16:00:20.148543	2026-06-21 16:00:20.148543
444	K.Kanungnij	PKF	kanungnij		Accounting AP-AR	kanungnij@patkol.com			2026-06-21 16:00:20.148637	2026-06-21 16:00:20.148637
445	K.Kanya	PKF	Kanya						2026-06-21 16:00:20.148729	2026-06-21 16:00:20.148729
446	K.Kanyaphak	PKF	Kanyaphak		Finance	kanyaphak.ti@patkol.com			2026-06-21 16:00:20.14883	2026-06-21 16:00:20.14883
447	K.kitchawan	PKF	K.kitchawan			kitchawan.sa@patkol.com		02 328 1035	2026-06-21 16:00:20.148924	2026-06-21 16:00:20.148924
448	K.Lalita	PKF	Lalita			lalita.we@patkol.com			2026-06-21 16:00:20.149014	2026-06-21 16:00:20.149014
449	K.Mewadee	PKF	Mewadee		ICT Department	mewadee.th@patkol.com	0-2328-1035 # 1808		2026-06-21 16:00:20.149102	2026-06-21 16:00:20.149102
450	K.Nakorn	PKF	Nakorn			nakorn.sr@patkol.com			2026-06-21 16:00:20.149187	2026-06-21 16:00:20.149187
451	K.Nannaphat	PKF	Nannaphat			nannaphat.tr@patkol.com			2026-06-21 16:00:20.149277	2026-06-21 16:00:20.149277
452	K.Nanthiya	PKF	Nanthiya			nanthiya.ka@patkol.com			2026-06-21 16:00:20.149373	2026-06-21 16:00:20.149373
453	K.Napaphat	PKF	Naphphat			Napaphat.ru@patkol.com			2026-06-21 16:00:20.149463	2026-06-21 16:00:20.149463
454	K.Nattakit	PKF	Nattakit		IT	nattakit.ch@patkol.com	5499	02-328-1035 Ext.1842	2026-06-21 16:00:20.149554	2026-06-21 16:00:20.149554
455	K.Nipa	PKF	Nipa		Fianace	nipa.sa@patkol.com			2026-06-21 16:00:20.149641	2026-06-21 16:00:20.149641
456	K.Nittaya	PKF	Nittaya		Accounting AP				2026-06-21 16:00:20.149731	2026-06-21 16:00:20.149731
457	K.Orathai	PKF	Orathai			orathai.ja@patkol.com			2026-06-21 16:00:20.149841	2026-06-21 16:00:20.149841
458	K.Orayanee	PKF	Orayanee			orayanee.sa@patkol.com			2026-06-21 16:00:20.149945	2026-06-21 16:00:20.149945
459	K.Pattariya	PKF	Pattariya			pattariya.su@patkol.com			2026-06-21 16:00:20.150066	2026-06-21 16:00:20.150066
460	K.Pornpimol	PKF	Pornpimol		Accounting AP	pornpimol.ko@patkol.com			2026-06-21 16:00:20.15024	2026-06-21 16:00:20.15024
461	K.Praputsorn	PKF	Praputsorn			praputsorn@patkol.com			2026-06-21 16:00:20.150393	2026-06-21 16:00:20.150393
462	K.Prasert	PKF	Prasert			prasert.po@patkol.com			2026-06-21 16:00:20.15055	2026-06-21 16:00:20.15055
463	K.Prissana	PKF	Prissana		ICT Department	prissana.to@patkol.com	0-2328-1035 # 1805		2026-06-21 16:00:20.150694	2026-06-21 16:00:20.150694
464	K.Pu	PKF	คุณปุ๊						2026-06-21 16:00:20.150804	2026-06-21 16:00:20.150804
465	K.Rachpapha	PKF	Rachpapha		Accounting -AP	rachpapha.ch@patkol.com			2026-06-21 16:00:20.150916	2026-06-21 16:00:20.150916
466	K.Ratmanee	PKF	Ratmanee		Accounting AP	ratmanee.bo@patkol.com			2026-06-21 16:00:20.151047	2026-06-21 16:00:20.151047
467	K.Saifon	PKF	Saifon		Accounting	saifon.ma@patkol.com			2026-06-21 16:00:20.15116	2026-06-21 16:00:20.15116
468	K.Sirinat	PKF	Sirinnat		ICT	sirinnat.ch@patkol.com	094-2245388	0-2328-1035 # 1810	2026-06-21 16:00:20.151267	2026-06-21 16:00:20.151267
469	K.Sirirak	PKF	Sirirak		Accounting -FA				2026-06-21 16:00:20.151376	2026-06-21 16:00:20.151376
470	K.Somsri	PKF	Somsri		Accounting AP	somsri.sa@patkol.com			2026-06-21 16:00:20.15151	2026-06-21 16:00:20.15151
471	K.Supaporn	PKF	Supaporn			supaporn.lu@patkol.com		0-2328-1035 # 1803	2026-06-21 16:00:20.151638	2026-06-21 16:00:20.151638
472	K.Suprapa	PKF	Suprapa			suprapa.ch@patkol.com			2026-06-21 16:00:20.151808	2026-06-21 16:00:20.151808
473	K.Tosapon	PKF	Tosapon			tosapon@patkol.com			2026-06-21 16:00:20.152062	2026-06-21 16:00:20.152062
474	K.Wanlapa	PKF	Wanlapa			wanlapa@patkol.com	089-524-0083	0-2328-1035 # 1815	2026-06-21 16:00:20.152251	2026-06-21 16:00:20.152251
475	K.Warattaya	PKF	Warattaya			warattaya.jo@patkol.com			2026-06-21 16:00:20.152418	2026-06-21 16:00:20.152418
476	K.Watcharee	PKF	Watcharee			watcharee@patkol.com			2026-06-21 16:00:20.152602	2026-06-21 16:00:20.152602
477	K.Watsana	PKF	Watsana			watsana.pr@patkol.com			2026-06-21 16:00:20.15276	2026-06-21 16:00:20.15276
478	K.Wiphawee	PKF	Wiphawee			wiphawee.su@patkol.com			2026-06-21 16:00:20.152908	2026-06-21 16:00:20.152908
479	PK.Panchai	PKF	Panchai			panchai.th@patkol.com			2026-06-21 16:00:20.153041	2026-06-21 16:00:20.153041
480	PK-Anyarat	PKF	Anyarat			anyarat.ja@patkol.com			2026-06-21 16:00:20.153191	2026-06-21 16:00:20.153191
481	PK-Chaiwat	PKF	Chaiwat			chaiwat.wo@patkol.com			2026-06-21 16:00:20.153319	2026-06-21 16:00:20.153319
482	PK-Costing	PKF	PK-Costing		PK-Costing				2026-06-21 16:00:20.153432	2026-06-21 16:00:20.153432
483	PK-Jaruwan	PKF	Jaruwan			jaruwan.pu@heataway.net			2026-06-21 16:00:20.153559	2026-06-21 16:00:20.153559
484	PK-Jittiporn.pa	PKF	Jittiporn			jittiporn.pa@patkol.com			2026-06-21 16:00:20.153693	2026-06-21 16:00:20.153693
485	PK-kanonraya	PKF	Kanonraya			kanonraya.th@patkol.com			2026-06-21 16:00:20.153821	2026-06-21 16:00:20.153821
486	PK-Ladawan	PKF	Ladawan			ladawan@patkol.com			2026-06-21 16:00:20.153938	2026-06-21 16:00:20.153938
487	PKM- Yaowapa	PKF	Yaowapa		Accounting	yaowapa.ka@tygienic.com			2026-06-21 16:00:20.154062	2026-06-21 16:00:20.154062
488	PKM-Pattariya	PKF	Pattariya		Accounting	pattariya.su@patkol.com			2026-06-21 16:00:20.154201	2026-06-21 16:00:20.154201
489	pkm-pattariya.su	PKF	Pattariya			pattariya.su@patkol.com			2026-06-21 16:00:20.154316	2026-06-21 16:00:20.154316
490	PKM-Puangpen	PKF	Puangpen						2026-06-21 16:00:20.154435	2026-06-21 16:00:20.154435
491	PKM-Sunee	PKF	Sunee			sunee@patkol.com			2026-06-21 16:00:20.154585	2026-06-21 16:00:20.154585
492	PK-Naiyana.jo	PKF	Naiyana			naiyana.jo@patkol.com			2026-06-21 16:00:20.154732	2026-06-21 16:00:20.154732
493	PK-Natphaknaphat.ph	PKF	Natphaknaphat			natphaknaphat.ph@patkol.com			2026-06-21 16:00:20.155009	2026-06-21 16:00:20.155009
494	PK-Panrawe	PKF	Panrawe						2026-06-21 16:00:20.155159	2026-06-21 16:00:20.155159
495	PK-Patcharakorn.we	PKF	Patcharakorn			patcharakorn.we@patkol.com			2026-06-21 16:00:20.155313	2026-06-21 16:00:20.155313
496	PK-Pisit	PKF	Pisit			pisit.wi@patkol.com			2026-06-21 16:00:20.155452	2026-06-21 16:00:20.155452
497	PK-Pratana.yu	PKF	PK-Pratana			pratana.yu@patkol.com			2026-06-21 16:00:20.155598	2026-06-21 16:00:20.155598
498	PK-Sittidate	PKF	Sittidate			Sittidate.bo@patkol.com			2026-06-21 16:00:20.155744	2026-06-21 16:00:20.155744
499	PK-Suksiri	PKF	Suksiri		Section Head-Account	suksiri@patkol.com			2026-06-21 16:00:20.155865	2026-06-21 16:00:20.155865
500	PK-Sunisa.la	PKF	Sunisa			sunisa.la@patkol.com			2026-06-21 16:00:20.156052	2026-06-21 16:00:20.156052
501	PK-Supaporn.th	PKF	Supaporn			supaporn.th@patkol.com			2026-06-21 16:00:20.156173	2026-06-21 16:00:20.156173
502	PK-Supattra.pu	PKF	Supattra			supattra.pu@patkol.com			2026-06-21 16:00:20.15632	2026-06-21 16:00:20.15632
503	PK-Tunyarat.nu	PKF	Tunyara			tunyarat.nu@patkol.com			2026-06-21 16:00:20.156461	2026-06-21 16:00:20.156461
504	PK-warout.si	PKF	Warout			warout.si@patkol.com			2026-06-21 16:00:20.156604	2026-06-21 16:00:20.156604
505	PK-Wilaiporn.pa	PKF	Wilaiporn			wilaiporn.pa@patkol.com			2026-06-21 16:00:20.156741	2026-06-21 16:00:20.156741
506	PK-Wiroje	PKF	Wiroje			wiroje.ob@patkol.com			2026-06-21 16:00:20.156879	2026-06-21 16:00:20.156879
507	P'PED (PKM)	PKF	Sunee			sunee@patkol.com			2026-06-21 16:00:20.157109	2026-06-21 16:00:20.157109
508	Prasad Sribupha	BISW	Prasad		BISW	ประสาท			2026-06-21 16:00:20.157261	2026-06-21 16:00:20.157261
509	Prasit Chantanupakorn	BISW	Prasit		BISW	ประสิทธิ			2026-06-21 16:00:20.157412	2026-06-21 16:00:20.157412
510	Prisan Saranarth	BISW	Prisan		BISW	เปี๊ยก			2026-06-21 16:00:20.157626	2026-06-21 16:00:20.157626
511	Punlop Tatun	BISW	Punlop		BISW	เกมส์			2026-06-21 16:00:20.158107	2026-06-21 16:00:20.158107
512	Renu Rujisan	BISW	Renu		BISW	เรณู			2026-06-21 16:00:20.158442	2026-06-21 16:00:20.158442
513	K.Lawan	RX	Lawan			lawan@rx.co.th			2026-06-21 16:00:20.158575	2026-06-21 16:00:20.158575
514	K.Maruud	RX	Maruud			maruud@rx.co.th		02-910-0951-68 # 3301,1152	2026-06-21 16:00:20.158756	2026-06-21 16:00:20.158756
515	K.Nalatporn	RX	นลัทพร			nalatporn@rx.co.th			2026-06-21 16:00:20.158959	2026-06-21 16:00:20.158959
516	K.Peerasak	RX	พีรศักดิ์			peerasak@rx.co.th		0 2910 0950	2026-06-21 16:00:20.159108	2026-06-21 16:00:20.159108
517	K.Phattharamon	RX	Phattharamon			Phattharamon.su@rx.co.th			2026-06-21 16:00:20.159289	2026-06-21 16:00:20.159289
518	K.Supa	RX	Supa			supa.pe@rx.co.th			2026-06-21 16:00:20.15948	2026-06-21 16:00:20.15948
519	K.Supaksorn	RX	Supaksorn			supaksorn@rx.co.th			2026-06-21 16:00:20.159637	2026-06-21 16:00:20.159637
520	K.Yosanan	RX	Yosanan			yosanan@rx.co.th			2026-06-21 16:00:20.15997	2026-06-21 16:00:20.15997
521	Sakchai Chitprommetta	BISW	Sakchai		BISW	ดำ			2026-06-21 16:00:20.160178	2026-06-21 16:00:20.160178
522	Seksan Khakong	BISW	Seksan		BISW	เสก			2026-06-21 16:00:20.160335	2026-06-21 16:00:20.160335
523	Siriporn Klinjan	BISW	Siriporn		BISW	จิ๋ม			2026-06-21 16:00:20.160495	2026-06-21 16:00:20.160495
524	Ammy Parinee	SNPR	พาริณี			parinee@snpr.co.th			2026-06-21 16:00:20.16069	2026-06-21 16:00:20.16069
525	AO	SNPR	พงษ์วริษฐ์			phongwarit@snpr.co.th			2026-06-21 16:00:20.160818	2026-06-21 16:00:20.160818
526	Aoy na ja	SNPR	อรพรรณ			orapan@snpr.co.th			2026-06-21 16:00:20.160967	2026-06-21 16:00:20.160967
527	Apiwat	SNPR	อภิวัฒน์			apiwat@snpr.co.th			2026-06-21 16:00:20.161114	2026-06-21 16:00:20.161114
528	ƃuodɐssɐd	SNPR	ภาสพงษ์			passapong@snpr.co.th			2026-06-21 16:00:20.16133	2026-06-21 16:00:20.16133
529	Chatchai J.	SNPR	ฉัตรชัย		หน่วยงานไอที & แอดมิน	chatchai@snpr.co.th			2026-06-21 16:00:20.161483	2026-06-21 16:00:20.161483
530	🎈D A O W I I E 🎈	SNPR	วรรณฑริกา			wantarika@snpr.co.th			2026-06-21 16:00:20.161618	2026-06-21 16:00:20.161618
531	Jetsada	SNPR	เจษฎา			jetsada@snpr.co.th			2026-06-21 16:00:20.16184	2026-06-21 16:00:20.16184
532	K.JATURONG	SNPR	จตุรงค			jaturong@snpr.co.th			2026-06-21 16:00:20.161999	2026-06-21 16:00:20.161999
533	lek	SNPR	คณากร			prasan@snpr.co.th			2026-06-21 16:00:20.162212	2026-06-21 16:00:20.162212
534	Nareerat	SNPR	นารีรัตน์			nareerat@snpr.co.th			2026-06-21 16:00:20.162416	2026-06-21 16:00:20.162416
535	Narongchai Semora	SNPR	ณรงค์ชัย			narongchai@snpr.co.th			2026-06-21 16:00:20.162572	2026-06-21 16:00:20.162572
536	Omuzaki	SNPR	กิจศิธา			kitsita@snpr.co.th			2026-06-21 16:00:20.163402	2026-06-21 16:00:20.163402
537	Orathai	SNPR	อรทัย			orathai@snpr.co.th			2026-06-21 16:00:20.163551	2026-06-21 16:00:20.163551
538	Plant1-VSI	SNPR	หัวหน้างาน			sl-plant1@snpr.co.th			2026-06-21 16:00:20.16372	2026-06-21 16:00:20.16372
539	QC Ins	SNPR	หัวหน้างาน			sl-qc@snpr.co.th			2026-06-21 16:00:20.163849	2026-06-21 16:00:20.163849
540	R.SAOWANEE	SNPR	เสาวนีย์			saowanee@snpr.co.th			2026-06-21 16:00:20.163959	2026-06-21 16:00:20.163959
541	Supamart	SNPR	สุภมาต			supamart@snpr.co.th			2026-06-21 16:00:20.164101	2026-06-21 16:00:20.164101
542	Suriya Thongsing	SNPR	สุริยา			suriya_t@snpr.co.th			2026-06-21 16:00:20.164217	2026-06-21 16:00:20.164217
543	wannisa kik	SNPR	วรรณนิษา			wannisa@snpr.co.th			2026-06-21 16:00:20.16438	2026-06-21 16:00:20.16438
544	Witoon Line COM	SNPR	วิฑูรย์			witoon@snpr.co.th			2026-06-21 16:00:20.164507	2026-06-21 16:00:20.164507
545	กอล์ฟยิ้ม ขวัญข้าว	SNPR	ทรงพล			sl-store@snpr.co.th			2026-06-21 16:00:20.164633	2026-06-21 16:00:20.164633
546	ข้าวเม่า	SNPR	อรพรรณ			orapan_p@snpr.co.th			2026-06-21 16:00:20.164768	2026-06-21 16:00:20.164768
547	ทวีรัตน์	SNPR	ทวีรัตน์			taweerat@snpr.co.th			2026-06-21 16:00:20.164886	2026-06-21 16:00:20.164886
548	แปง	SNPR	เจษฎา			jetsada@snpr.co.th			2026-06-21 16:00:20.165012	2026-06-21 16:00:20.165012
549	สายชล ปาทะวิง	SNPR	สายชล			saichon@snpr.co.th			2026-06-21 16:00:20.165141	2026-06-21 16:00:20.165141
550	หัวหน้างาน SINTER	SNPR	หัวหน้างาน			sl-plant2@snpr.co.th			2026-06-21 16:00:20.16524	2026-06-21 16:00:20.16524
551	ETAX ACC-Center	SRN	ETAX			etax@srnsoundproof.com			2026-06-21 16:00:20.165342	2026-06-21 16:00:20.165342
552	K.Benjawan	SRN	Benjawan			delivery@srnsoundproof.com			2026-06-21 16:00:20.165448	2026-06-21 16:00:20.165448
553	K.Bow	SRN	BOW						2026-06-21 16:00:20.165563	2026-06-21 16:00:20.165563
554	K.Chalanda	SRN	Chalanda			Chalanda@srnsoundproof.com			2026-06-21 16:00:20.165664	2026-06-21 16:00:20.165664
555	K.Chompupan	SRN	Chompupan		Marketing	Chompupan@srnsoundproof.com	065-742-6324		2026-06-21 16:00:20.165755	2026-06-21 16:00:20.165755
556	K.Duangporn	SRN	Duangporn			duangporn@srnsoundproof.com			2026-06-21 16:00:20.165853	2026-06-21 16:00:20.165853
557	K.Fang	SRN	Fang						2026-06-21 16:00:20.165957	2026-06-21 16:00:20.165957
558	K.Jintana	SRN	Jintana			Package-control@srnsoundproof.			2026-06-21 16:00:20.166047	2026-06-21 16:00:20.166047
559	K.Jiraporn	SRN	Jiraporn			jiraporn@srnsoundproof.com			2026-06-21 16:00:20.166136	2026-06-21 16:00:20.166136
560	K.Jutathip	SRN	Jutathip			jutathip@srnsoundproof.com			2026-06-21 16:00:20.166385	2026-06-21 16:00:20.166385
561	K.Kornrada	SRN	Kornrada			kornrada@srnsoundproof.com			2026-06-21 16:00:20.166485	2026-06-21 16:00:20.166485
562	K.Kritsada	SRN	Kritsada						2026-06-21 16:00:20.166595	2026-06-21 16:00:20.166595
563	K.Laongdaow	SRN	Laongdaow			laongdaow@srnsoundproof.com			2026-06-21 16:00:20.166697	2026-06-21 16:00:20.166697
564	K.Meena	SRN	Meena			meena@srnsoundproof.com			2026-06-21 16:00:20.16679	2026-06-21 16:00:20.16679
565	K.Mitchai	SRN	Mitchai			mitchai@srnsoundproof.com			2026-06-21 16:00:20.166891	2026-06-21 16:00:20.166891
566	K.NanJaa	SRN	Nanjaa						2026-06-21 16:00:20.166987	2026-06-21 16:00:20.166987
567	K.Narada	SRN	Narada						2026-06-21 16:00:20.167083	2026-06-21 16:00:20.167083
568	K.Nattanan	SRN	Nattanan			Nattanan@srnsoundproof.com			2026-06-21 16:00:20.167184	2026-06-21 16:00:20.167184
569	K.Nhan	SRN	Nhan			jutathip@srnsoundproof.com			2026-06-21 16:00:20.167287	2026-06-21 16:00:20.167287
570	K.Nhattapat	SRN	Nhattapat			nhattapat@srnsoundproof.com			2026-06-21 16:00:20.167432	2026-06-21 16:00:20.167432
571	K.Panarath	SRN	Panarath			panarath@srnsoundproof.com			2026-06-21 16:00:20.167676	2026-06-21 16:00:20.167676
572	K.Panita	SRN	Panita			panita.s@srnsoundproof.com			2026-06-21 16:00:20.167823	2026-06-21 16:00:20.167823
573	K.Panleka	SRN	Panleka			panleka@srnsoundproof.com			2026-06-21 16:00:20.167928	2026-06-21 16:00:20.167928
574	K.Phakakrong	SRN	Phakakrong			pakakorng@srnsoundproof.com			2026-06-21 16:00:20.168045	2026-06-21 16:00:20.168045
575	K.Phatphonrung	SRN	Phatphonrung PD			phatphonrung@srnsoundproof.com			2026-06-21 16:00:20.168141	2026-06-21 16:00:20.168141
576	K.Ploypailin	SRN	Ploypailin			ploypailin@srnsoundproof.com			2026-06-21 16:00:20.16827	2026-06-21 16:00:20.16827
577	K.POPPYLOVE	SRN	POPPYLOVE			package-control@srnsoundproof.com			2026-06-21 16:00:20.16837	2026-06-21 16:00:20.16837
578	K.Pucharaporn	SRN	Pucharaporn			pucharaporn@srnsoundproof.com			2026-06-21 16:00:20.168458	2026-06-21 16:00:20.168458
579	K.Ruedee	SRN	Ruedee			ruedee@srnsoundproof.com			2026-06-21 16:00:20.168546	2026-06-21 16:00:20.168546
580	K.Siriwan	SRN	Siriwan		MK	siriwan.y@srnsoundproof.com	087-5815220		2026-06-21 16:00:20.168654	2026-06-21 16:00:20.168654
581	K.Sunisa	SRN	Sunisa			sunisa.b@srnsoundproof.com			2026-06-21 16:00:20.168772	2026-06-21 16:00:20.168772
582	K.Thanasak	SRN	Thanasak			thanasak@srnsoundproof.com			2026-06-21 16:00:20.168875	2026-06-21 16:00:20.168875
583	K.Unnariyar	SRN	Unnariyar			Unnariyar@srnsoundproof.com			2026-06-21 16:00:20.168964	2026-06-21 16:00:20.168964
584	K.Wanphen	SRN	Wanphen			purchase1@srnsoundproof.com			2026-06-21 16:00:20.169049	2026-06-21 16:00:20.169049
585	K.Wichittra	SRN	Wichittra			wichittra@srnsoundproof.com			2026-06-21 16:00:20.169136	2026-06-21 16:00:20.169136
586	K.Wilaipan	SRN	Wilaipan			Wilaipan.p@srnsoundproof.com			2026-06-21 16:00:20.16922	2026-06-21 16:00:20.16922
587	K.Wilawan	SRN	Wilawan			Wilawan@srnsoundproof.com			2026-06-21 16:00:20.169304	2026-06-21 16:00:20.169304
588	K.Wipa	SRN	วิภา			wipa@srnsoundproof.com			2026-06-21 16:00:20.169389	2026-06-21 16:00:20.169389
589	K.อิ๊ก	SRN	อิ๊ก						2026-06-21 16:00:20.169471	2026-06-21 16:00:20.169471
590	Narongsak	SRN	Narongsak			narongsak.it@srnsoundproof.com			2026-06-21 16:00:20.169552	2026-06-21 16:00:20.169552
591	NooJib	SRN	NooJib						2026-06-21 16:00:20.169642	2026-06-21 16:00:20.169642
592	Nuttapron Charoenchang	SRN	Nuttapron			delivery@srnsoundproof.com			2026-06-21 16:00:20.169726	2026-06-21 16:00:20.169726
593	Songapson	SRN	Songapson			Songapson@srnsoundproof.com			2026-06-21 16:00:20.169813	2026-06-21 16:00:20.169813
594	Thidaporn	SRN	Thidaporn			Thidaporn@srnsoundproof.com			2026-06-21 16:00:20.169896	2026-06-21 16:00:20.169896
595	UserLine	SRN	UserLine						2026-06-21 16:00:20.169978	2026-06-21 16:00:20.169978
596	K.Wanida	SST	K.Wanida			vk@siamsenater.co.th	086-004-5322		2026-06-21 16:00:20.170067	2026-06-21 16:00:20.170067
597	K.ปาริชาติ	SST	K.ปาริชาติ						2026-06-21 16:00:20.170156	2026-06-21 16:00:20.170156
598	Supornchai	SST	Supornchai		IT	supornchai@siamsenater.co.th			2026-06-21 16:00:20.170239	2026-06-21 16:00:20.170239
599	K.Atcha	STAR	Atcha			atcha-ke@starsmicro.com			2026-06-21 16:00:20.170324	2026-06-21 16:00:20.170324
600	K.Fah	STAR	Kabillaphaktra						2026-06-21 16:00:20.170413	2026-06-21 16:00:20.170413
601	K.Kanya Kateewong	STAR	K.Kanya		Costing				2026-06-21 16:00:20.170502	2026-06-21 16:00:20.170502
602	K.Katekanok	STAR	Katekanok			katekanok-p@starsmicro.com			2026-06-21 16:00:20.170587	2026-06-21 16:00:20.170587
603	Tacha Na Suwan	Tacha	Na Suwan		BISW	เจิ้น			2026-06-21 16:00:20.17067	2026-06-21 16:00:20.17067
604	K.Kaewalin	TAIYO	Kee						2026-06-21 16:00:20.170776	2026-06-21 16:00:20.170776
605	K.Kanokwan	TAIYO	Kanokwan			kanokwan.n@tcapgroup.com			2026-06-21 16:00:20.17086	2026-06-21 16:00:20.17086
606	K.Paweena	TAIYO	Paweena		Accounting	paweena.p@tcapgroup.com			2026-06-21 16:00:20.170946	2026-06-21 16:00:20.170946
607	K.Phusanisa	TAIYO	Phusanisa		Accounting	phusanisa.r@tcapgroup.com			2026-06-21 16:00:20.171028	2026-06-21 16:00:20.171028
608	K.Prapai	TAIYO	K.Prapai		Accounting	prapai.k@tcapgroup.com			2026-06-21 16:00:20.171114	2026-06-21 16:00:20.171114
609	K.Rangson	TAIYO	Rangson			rangson.s@tcapgroup.com			2026-06-21 16:00:20.171202	2026-06-21 16:00:20.171202
610	K.Sineenart	TAIYO	Sineenart		Sales	sineenart.m@tcapgroup.com	083-049-4489	038-185573-5	2026-06-21 16:00:20.171296	2026-06-21 16:00:20.171296
611	K.Thanyamas	TAIYO	Thanyamas		Account	thanyamas.w@tcapgroup.com			2026-06-21 16:00:20.171403	2026-06-21 16:00:20.171403
612	K.Theeraparp	TAIYO	Theeraparp						2026-06-21 16:00:20.171584	2026-06-21 16:00:20.171584
613	K.Vitoon	TAIYO	Vitoon		Inventory Control	vitoon.y@tcapgroup.com		038-185573-5	2026-06-21 16:00:20.171672	2026-06-21 16:00:20.171672
614	K.Waraporn	TAIYO	Waraporn		Accounting	waraporn.p@tcapgroup.com			2026-06-21 16:00:20.171757	2026-06-21 16:00:20.171757
615	K.Weeraya	TAIYO	Weeraya		Accounting	weeraya.c@tcapgroup.com		038-185573-5	2026-06-21 16:00:20.171837	2026-06-21 16:00:20.171837
616	K.Yupin	TAIYO	Yupin		Accounting				2026-06-21 16:00:20.171925	2026-06-21 16:00:20.171925
617	AdminPlanning	TAK	AdminPlanning						2026-06-21 16:00:20.172011	2026-06-21 16:00:20.172011
618	ap_tak	TAK	ap_tak			ap_tak@tpbigroup.com			2026-06-21 16:00:20.172091	2026-06-21 16:00:20.172091
619	K.Amawasi	TAK	Amawasi			amawasi@tpbigroup.com			2026-06-21 16:00:20.172195	2026-06-21 16:00:20.172195
620	K.Amornrat	TAK	Amornrat			amornrat.kh@tpbigroup.com			2026-06-21 16:00:20.172283	2026-06-21 16:00:20.172283
621	K.Budsaya	TAK	Budsaya			budsaya.pr@tpbigroup.com			2026-06-21 16:00:20.172364	2026-06-21 16:00:20.172364
622	K.Chintana	TAK	Chintana			chintana@tpbigroup.com			2026-06-21 16:00:20.172448	2026-06-21 16:00:20.172448
623	K.Darinee	TAK	Darinee			darinee.se@tpbigroup.com			2026-06-21 16:00:20.172534	2026-06-21 16:00:20.172534
624	K.Jaruwan	TAK	Jaruwan			jaruwan.sr@tpbigroup.com			2026-06-21 16:00:20.172615	2026-06-21 16:00:20.172615
625	K.Jiravatch	TAK	Jiravatch			jiravatch.su@takpack.co.th			2026-06-21 16:00:20.172704	2026-06-21 16:00:20.172704
626	K.Jittima	TAK	Jittima			jittima.ch@tpbigroup.com			2026-06-21 16:00:20.172789	2026-06-21 16:00:20.172789
627	K.Kanyamas	TAK	Kanyamas			ap_tak@tpbigroup.com			2026-06-21 16:00:20.172876	2026-06-21 16:00:20.172876
628	K.Kewalin	TAK	Kewalin			kewalin.se@tpbigroup.com			2026-06-21 16:00:20.173097	2026-06-21 16:00:20.173097
629	K.Manatsawee	TAK	Manatsawee						2026-06-21 16:00:20.173179	2026-06-21 16:00:20.173179
630	K.Naruedee	TAK	Naruedee			naruedee.se@tpbigroup.com			2026-06-21 16:00:20.173264	2026-06-21 16:00:20.173264
631	K.Nattakan	TAK	Nattakan			Nattakan.be@tpbigroup.com			2026-06-21 16:00:20.173352	2026-06-21 16:00:20.173352
632	K.Nittaya	TAK	Nittaya			nittaya.us@tpbigroup.com			2026-06-21 16:00:20.173438	2026-06-21 16:00:20.173438
633	K.Parichat	TAK	Parichat			parichat.ma@tpbigroup.com			2026-06-21 16:00:20.173525	2026-06-21 16:00:20.173525
634	K.Patama	TAK	Patama			patama.sa@tpbigroup.com			2026-06-21 16:00:20.173618	2026-06-21 16:00:20.173618
635	K.Pimpira	TAK	Pimpira			pimpira.j@tpbigroup.com			2026-06-21 16:00:20.173705	2026-06-21 16:00:20.173705
636	K.Prontawee	TAK	Prontawee			prontawee.su@tpbigroup.com			2026-06-21 16:00:20.173789	2026-06-21 16:00:20.173789
637	K.Punyaweethamon	TAK	Punyaweethamon			punyaweethamon.po@tpbigroup.com			2026-06-21 16:00:20.17388	2026-06-21 16:00:20.17388
638	K.Saifon	TAK	Saifon			saifon@tpbigroup.com			2026-06-21 16:00:20.173967	2026-06-21 16:00:20.173967
639	K.Saowapa	TAK	Saowapa			saowapa@tpbigroup.com			2026-06-21 16:00:20.174051	2026-06-21 16:00:20.174051
640	K.Sirirat	TAK	Sirirat			sirirat.ar@tpbigroup.com			2026-06-21 16:00:20.174139	2026-06-21 16:00:20.174139
641	K.Siriwan	TAK	Siriwan			siriwan.ph@tpbigroup.com			2026-06-21 16:00:20.174231	2026-06-21 16:00:20.174231
642	K.Sukanya	TAK	Sukanya			sukanya.tr@tpbigroup.com			2026-06-21 16:00:20.17431	2026-06-21 16:00:20.17431
643	K.Supattra	TAK	Supattra		store-fg	supattra.de@tpbigroup.com			2026-06-21 16:00:20.174426	2026-06-21 16:00:20.174426
644	K.Tatsawan	TAK	Tatsawan			tatsawan@tpbigroup.com			2026-06-21 16:00:20.174517	2026-06-21 16:00:20.174517
645	K.Tipprapa	TAK	Tipprapa			tipprapa@tpbigroup.com			2026-06-21 16:00:20.174603	2026-06-21 16:00:20.174603
646	K.Wanida	TAK	Wanida			wanida.ya@tpbigroup.com			2026-06-21 16:00:20.174686	2026-06-21 16:00:20.174686
647	K.Ya Pa	TAK	Ya			naruedee.se@tpbigroup.com			2026-06-21 16:00:20.17479	2026-06-21 16:00:20.17479
648	Kamoltip	TAK	Kamoltip			kamoltip@tpbigroup.com			2026-06-21 16:00:20.17488	2026-06-21 16:00:20.17488
649	May	TAK	May						2026-06-21 16:00:20.174976	2026-06-21 16:00:20.174976
650	Mesa	TAK	Mesa			mesa.yu@tpbigroup.com			2026-06-21 16:00:20.175062	2026-06-21 16:00:20.175062
651	Saranrut	TAK	Saranrut						2026-06-21 16:00:20.175145	2026-06-21 16:00:20.175145
652	Technical Service T.A.K	TAK	K.Max			technical_service@tpbigroup.com			2026-06-21 16:00:20.175227	2026-06-21 16:00:20.175227
653	โร	TAK	โร						2026-06-21 16:00:20.175309	2026-06-21 16:00:20.175309
654	Chanya	TBFST	Chanya			chanya.nitisombut@toyota-boshoku.com			2026-06-21 16:00:20.175391	2026-06-21 16:00:20.175391
655	Chayanisa	TBFST	Chayanisa			chayanisa.buranawong@toyota-boshoku.com			2026-06-21 16:00:20.175477	2026-06-21 16:00:20.175477
656	Chitchai	TBFST	Chitchai			chitchai.panalak@toyota-boshoku.com			2026-06-21 16:00:20.175559	2026-06-21 16:00:20.175559
657	Cost Accounting	TBFST	Cost Accounting			tbfst_acc_cost@toyota-boshoku.com			2026-06-21 16:00:20.175644	2026-06-21 16:00:20.175644
658	Dorn	TBFST	Dorn			dorn.suwantha@toyota-boshoku.com			2026-06-21 16:00:20.175729	2026-06-21 16:00:20.175729
659	GL Accounting	TBFST	GL			tbfst_acc_gl@toyota-boshoku.co			2026-06-21 16:00:20.175814	2026-06-21 16:00:20.175814
660	Jeerapong	TBFST	Jeerapong			jeerapong.nouljam@toyota-boshoku.com			2026-06-21 16:00:20.175899	2026-06-21 16:00:20.175899
661	Kriangkrai	TBFST	Kriangkrai			kriangkrai.wichian@toyota-boshoku.com			2026-06-21 16:00:20.175981	2026-06-21 16:00:20.175981
662	Kriangsak	TBFST	Kriangsak			kriangsak.jeungtanasirikul@toyota-boshoku.com			2026-06-21 16:00:20.176064	2026-06-21 16:00:20.176064
663	Namfon	TBFST	Namfon			namfon.jidcharoen@toyota-boshoku.com			2026-06-21 16:00:20.176146	2026-06-21 16:00:20.176146
664	Nanthicha	TBFST	Nanthicha			nanthicha.namjantra@toyota-boshoku.com			2026-06-21 16:00:20.176228	2026-06-21 16:00:20.176228
665	Napakaporn	TBFST	Napakaporn			napakaporn.punnan@toyota-boshoku.com			2026-06-21 16:00:20.176317	2026-06-21 16:00:20.176317
666	Oranuch	TBFST	Oranuch			oranuch.treevongwattana@toyota-boshoku.com			2026-06-21 16:00:20.17641	2026-06-21 16:00:20.17641
667	Orratai	TBFST	Orratai			orratai.sukthai@toyota-boshoku.com			2026-06-21 16:00:20.176494	2026-06-21 16:00:20.176494
668	Phannipa	TBFST	Phannipa			phannipa.trithuchaporn@toyota-boshoku.com			2026-06-21 16:00:20.176578	2026-06-21 16:00:20.176578
669	Pragasit	TBFST	Pragasit			pragasit.tangman@toyota-boshoku.com			2026-06-21 16:00:20.176662	2026-06-21 16:00:20.176662
670	Receiving Warehouse	TBFST	Receiving Warehouse			tbfst_warehouse_receiving@toyota-boshoku.com			2026-06-21 16:00:20.176746	2026-06-21 16:00:20.176746
671	Supansa	TBFST	Supansa			tbfst_itc@toyota-boshoku.com			2026-06-21 16:00:20.176826	2026-06-21 16:00:20.176826
672	Supunni	TBFST	Supunni			supunni.srisurach@toyota-boshoku.com			2026-06-21 16:00:20.176909	2026-06-21 16:00:20.176909
673	System IT	TBFST	System IT			tbfst_its@toyota-boshoku.com			2026-06-21 16:00:20.176992	2026-06-21 16:00:20.176992
674	TBFST ITC	TBFST	TBFST ITC			tbfst_itc@toyota-boshoku.com			2026-06-21 16:00:20.177075	2026-06-21 16:00:20.177075
675	TBFST Purchase	TBFST	TBFST Purchase			tbfst-purchase@toyota-boshoku.com			2026-06-21 16:00:20.177158	2026-06-21 16:00:20.177158
676	Thanom	TBFST	Thanom			thanom.thareram@toyota-boshoku.com			2026-06-21 16:00:20.17724	2026-06-21 16:00:20.17724
677	Thitima	TBFST	Thitima			thitima.choanapan@toyota-boshoku.com			2026-06-21 16:00:20.177322	2026-06-21 16:00:20.177322
678	Alex Bozo (Line)	TG	Alex			IT-Support@patkol.com			2026-06-21 16:00:20.177402	2026-06-21 16:00:20.177402
679	Jongjit  Pengjaem	TG	Jongjit						2026-06-21 16:00:20.177487	2026-06-21 16:00:20.177487
680	K,Panchai	TG	Panchai						2026-06-21 16:00:20.17757	2026-06-21 16:00:20.17757
681	K. Watsana	TG	Watsana			watsana.pr@patkol.com			2026-06-21 16:00:20.177654	2026-06-21 16:00:20.177654
682	K.ampan	TG	ampan		Costing	ampan.pe@patkol.com			2026-06-21 16:00:20.177737	2026-06-21 16:00:20.177737
683	K.Anchalee	TG	Anchalee		Accounting				2026-06-21 16:00:20.177819	2026-06-21 16:00:20.177819
684	K.AO	TG	คุณโอ๋						2026-06-21 16:00:20.1779	2026-06-21 16:00:20.1779
685	K.Bas	TG	K.Bas						2026-06-21 16:00:20.177982	2026-06-21 16:00:20.177982
686	K.Benchawan	TG	Benchawa						2026-06-21 16:00:20.178123	2026-06-21 16:00:20.178123
687	K.Chanachon	TG	K>Chanachon		ICT Department	chanachon.pr@patkol.com	0-2328-1035 # 1820	095-705-2658	2026-06-21 16:00:20.178223	2026-06-21 16:00:20.178223
688	K.Charinrat	TG	Charinrat		Accounting -AR	charinrat.bo@patkol.com			2026-06-21 16:00:20.178311	2026-06-21 16:00:20.178311
689	K.Jantrawan	TG	KJjantrawan			jantrawan.mo@patkol.com			2026-06-21 16:00:20.17846	2026-06-21 16:00:20.17846
690	K.Jeerachai	TG	Jeerachai						2026-06-21 16:00:20.178548	2026-06-21 16:00:20.178548
691	K.Jeeraporn	TG	Jeeraporn			jeeraporn.sa@patkol.com			2026-06-21 16:00:20.178633	2026-06-21 16:00:20.178633
692	K.JKun	TG	K.JKun						2026-06-21 16:00:20.178716	2026-06-21 16:00:20.178716
693	K.Jureerat	TG	JUREERAT		Programmer /IT	Jureerat.bo@patkol.com	02-328-1035-49  # 1816		2026-06-21 16:00:20.178806	2026-06-21 16:00:20.178806
694	K.Kanonraya	TG	K.KANONRAYA						2026-06-21 16:00:20.178893	2026-06-21 16:00:20.178893
695	K.Kanungnij	TG	kanungnij		Accounting AP-AR	kanungnij@patkol.com			2026-06-21 16:00:20.179145	2026-06-21 16:00:20.179145
696	K.Kanya	TG	K.Kanya						2026-06-21 16:00:20.17924	2026-06-21 16:00:20.17924
697	K.kanyaphak	TG	K.kanyaphak		Finance				2026-06-21 16:00:20.179331	2026-06-21 16:00:20.179331
698	K.kitchawan	TG	K.kitchawan			kitchawan.sa@patkol.com		02 328 1035	2026-06-21 16:00:20.179416	2026-06-21 16:00:20.179416
699	K.Lalita	TG	K.Lalita			lalita.we@patkol.com			2026-06-21 16:00:20.179498	2026-06-21 16:00:20.179498
700	K.Mewadee	TG	Mewadee		ICT Department	mewadee.th@patkol.com	0-2328-1035 # 1808		2026-06-21 16:00:20.179581	2026-06-21 16:00:20.179581
701	K.Nakorn	TG	K.Nakorn						2026-06-21 16:00:20.179662	2026-06-21 16:00:20.179662
702	K.Nan	TG	K.Nan		Finance		0-2328-1035 # 1808		2026-06-21 16:00:20.179754	2026-06-21 16:00:20.179754
703	K.Nannaphat	TG	Nannaphat			nannaphat.tr@patkol.com			2026-06-21 16:00:20.179835	2026-06-21 16:00:20.179835
704	K.Nanthiya	TG	Nanthiya			nanthiya.ka@patkol.com			2026-06-21 16:00:20.179924	2026-06-21 16:00:20.179924
705	K.Napaphat	TG	Naphphat			Napaphat.ru@patkol.com			2026-06-21 16:00:20.180014	2026-06-21 16:00:20.180014
706	K.Nattakit	TG	Nattakit			nattakit.ch@patkol.com			2026-06-21 16:00:20.180096	2026-06-21 16:00:20.180096
707	K.Nid	TG	PK-Nittaya		Accounting AP				2026-06-21 16:00:20.180184	2026-06-21 16:00:20.180184
708	K.Nipa	TG	K.Nipa		Fianace				2026-06-21 16:00:20.180265	2026-06-21 16:00:20.180265
709	K.Nittaya	TG	PK-Nittaya		Accounting AP				2026-06-21 16:00:20.180349	2026-06-21 16:00:20.180349
710	K.Orayanee	TG	Orayanee						2026-06-21 16:00:20.180437	2026-06-21 16:00:20.180437
711	K.Pattariya	TG	K.Pattariya						2026-06-21 16:00:20.180516	2026-06-21 16:00:20.180516
712	K.Pornpimol	TG	Pornpimol		Accounting AP	pornpimol.ko@patkol.com			2026-06-21 16:00:20.180601	2026-06-21 16:00:20.180601
713	K.Praputsorn	TG	Praputsorn						2026-06-21 16:00:20.180683	2026-06-21 16:00:20.180683
714	K.Prasert	TG	Prasert						2026-06-21 16:00:20.180764	2026-06-21 16:00:20.180764
715	K.Prissana	TG	Prissana		ICT Department	prissana.to@patkol.com	0-2328-1035 # 1805		2026-06-21 16:00:20.180844	2026-06-21 16:00:20.180844
716	K.Rachpapha	TG	Rachpapha		Accounting -AP	rachpapha.ch@patkol.com			2026-06-21 16:00:20.180925	2026-06-21 16:00:20.180925
717	K.Ratmanee	TG	Ratmanee		Accounting AP	ratmanee.bo@patkol.com			2026-06-21 16:00:20.181006	2026-06-21 16:00:20.181006
718	K.Rattikan	TG	Rattikan						2026-06-21 16:00:20.181086	2026-06-21 16:00:20.181086
719	K.Saifon	TG	Saifon		Accounting				2026-06-21 16:00:20.181166	2026-06-21 16:00:20.181166
720	K.Sirinat	TG	Sirinat		ICT	sirinnat.ch@patkol.com	094-2245388	0-2328-1035 # 1810	2026-06-21 16:00:20.181247	2026-06-21 16:00:20.181247
721	K.sirirak	TG	sirirak		Accounting -FA				2026-06-21 16:00:20.181329	2026-06-21 16:00:20.181329
722	K.Somsri	TG	Somsri		Accounting AP	somsri.sa@patkol.com			2026-06-21 16:00:20.181409	2026-06-21 16:00:20.181409
723	K.Supaporn	TG	K.Supaporn			supaporn.lu@patkol.com		0-2328-1035 # 1803	2026-06-21 16:00:20.181523	2026-06-21 16:00:20.181523
724	K.Suprapa	TG	K.Suprapa			suprapa.ch@patkol.com			2026-06-21 16:00:20.181626	2026-06-21 16:00:20.181626
725	K.Tosapon	TG	Tosapon			tosapon@patkol.com			2026-06-21 16:00:20.181733	2026-06-21 16:00:20.181733
726	K.Wanlapa	TG	Wanlapa			wanlapa@patkol.com	089-524-0083	0-2328-1035 # 1815	2026-06-21 16:00:20.181865	2026-06-21 16:00:20.181865
727	K.Warunee	TG	Warunee		Fianace				2026-06-21 16:00:20.181981	2026-06-21 16:00:20.181981
728	K.Watcharee	TG	Watcharee			watcharee@patkol.com			2026-06-21 16:00:20.182083	2026-06-21 16:00:20.182083
729	K.Wiphawee	TG	Wiphawee			wiphawee.su@patkol.com			2026-06-21 16:00:20.182178	2026-06-21 16:00:20.182178
730	PK.Panchai	TG	Panchai			panchai.th@patkol.com			2026-06-21 16:00:20.182302	2026-06-21 16:00:20.182302
731	PK-Anyarat	TG	Anyarat						2026-06-21 16:00:20.182407	2026-06-21 16:00:20.182407
732	PK-Chaiwat	TG	Chaiwat						2026-06-21 16:00:20.182511	2026-06-21 16:00:20.182511
733	PK-chaiwat.wo	TG	Chaiwat						2026-06-21 16:00:20.182611	2026-06-21 16:00:20.182611
734	PK-Costing	TG	PK-Costing		PK-Costing				2026-06-21 16:00:20.182737	2026-06-21 16:00:20.182737
735	PK-Jaruwan	TG	Jaruwan						2026-06-21 16:00:20.182837	2026-06-21 16:00:20.182837
736	PK-Jittiporn.pa	TG	Jittiporn						2026-06-21 16:00:20.182939	2026-06-21 16:00:20.182939
737	PK-Jongjit.pe	TG	Jongjit						2026-06-21 16:00:20.183064	2026-06-21 16:00:20.183064
738	PK-kanonraya	TG	kanonraya						2026-06-21 16:00:20.1832	2026-06-21 16:00:20.1832
739	PK-Ladawan	TG	Ladawan						2026-06-21 16:00:20.183303	2026-06-21 16:00:20.183303
740	PKM- Yaowapa	TG	Yaowapa		Accounting	PKM- Yaowapa			2026-06-21 16:00:20.183399	2026-06-21 16:00:20.183399
741	PK-Mewadee.th	TG	Mewadee						2026-06-21 16:00:20.183497	2026-06-21 16:00:20.183497
742	PKM-Pattariya	TG	Pattariya		Accounting	PKM-Pattariya			2026-06-21 16:00:20.183598	2026-06-21 16:00:20.183598
743	pkm-pattariya.su	TG	Pattariya						2026-06-21 16:00:20.183707	2026-06-21 16:00:20.183707
744	PKM-Puangpen	TG	Puangpen						2026-06-21 16:00:20.183854	2026-06-21 16:00:20.183854
745	PKM-Sunee	TG	K.Sunee						2026-06-21 16:00:20.184006	2026-06-21 16:00:20.184006
746	PK-Naiyana.jo	TG	Naiyana			naiyana.jo@patkol.com			2026-06-21 16:00:20.184174	2026-06-21 16:00:20.184174
747	PK-natphaknaphat.ph	TG	Natphaknaphat						2026-06-21 16:00:20.184364	2026-06-21 16:00:20.184364
748	PK-Panrawe	TG	PK-Panrawe						2026-06-21 16:00:20.184489	2026-06-21 16:00:20.184489
749	PK-Patcharakorn.we	TG	Patcharakorn			patcharakorn.we@patkol.com			2026-06-21 16:00:20.184633	2026-06-21 16:00:20.184633
750	PK-Patcharapol.ru	TG	Patcharapol						2026-06-21 16:00:20.18479	2026-06-21 16:00:20.18479
751	PK-Pisit	TG	PK-Pisit.wi						2026-06-21 16:00:20.184905	2026-06-21 16:00:20.184905
752	PK-Pratana.yu	TG	PK-Pratana						2026-06-21 16:00:20.185031	2026-06-21 16:00:20.185031
753	PK-prissana.to	TG	Prissana						2026-06-21 16:00:20.185142	2026-06-21 16:00:20.185142
754	PK-Sittidate	TG	Sittidate						2026-06-21 16:00:20.185256	2026-06-21 16:00:20.185256
755	PK-Suksiri	TG	Suksiri		Section Head-Account	suksiri@patkol.com			2026-06-21 16:00:20.18539	2026-06-21 16:00:20.18539
756	PK-Sunisa.la	TG	Sunisa.la						2026-06-21 16:00:20.185507	2026-06-21 16:00:20.185507
757	PK-Supaporn.th	TG	Supaporn			supaporn.th@patkol.com			2026-06-21 16:00:20.185618	2026-06-21 16:00:20.185618
758	PK-Supattra.pu	TG	Supattra						2026-06-21 16:00:20.18573	2026-06-21 16:00:20.18573
759	PK-Tunyarat.nu	TG	Tunyara						2026-06-21 16:00:20.185843	2026-06-21 16:00:20.185843
760	PK-warout.si	TG	Warout						2026-06-21 16:00:20.185983	2026-06-21 16:00:20.185983
761	PK-Wilaiporn.pa	TG	Wilaiporn						2026-06-21 16:00:20.18612	2026-06-21 16:00:20.18612
762	PK-Wiroje	TG	K.Wiroje						2026-06-21 16:00:20.186268	2026-06-21 16:00:20.186268
763	P'PED (PKM)	TG	Sunee			sunee@patkol.com			2026-06-21 16:00:20.1864	2026-06-21 16:00:20.1864
764	Praputsorn	TG	Praputsorn						2026-06-21 16:00:20.186534	2026-06-21 16:00:20.186534
765	Thawat Jansaithong	Thawat	Jansaithong		BISW	ธวัช			2026-06-21 16:00:20.186662	2026-06-21 16:00:20.186662
766	K.Lek	TSPK	Ampapan			ampapan.pon@tspkk.co.th			2026-06-21 16:00:20.186807	2026-06-21 16:00:20.186807
767	K.Lek	TSPKKBP	Ampapan			ampapan.pon@tspkk.co.th			2026-06-21 16:00:20.187081	2026-06-21 16:00:20.187081
768	K.Ramida	TSPKKBP	Ramida			ramida.kan@tspkk.co.th	816330652		2026-06-21 16:00:20.187196	2026-06-21 16:00:20.187196
769	K.Suebsak	TSPKKBP	Suebsak		IT	suebsak.sun@tspkk.co.th			2026-06-21 16:00:20.187311	2026-06-21 16:00:20.187311
770	K.Lek	TSPKKC	Ampapan			ampapan.pon@tspkk.co.th			2026-06-21 16:00:20.187414	2026-06-21 16:00:20.187414
771	K.Ramida	TSPKKC	K.แมว						2026-06-21 16:00:20.187521	2026-06-21 16:00:20.187521
772	K.Suebsak	TSPKKC	Suebsak		IT	suebsak.sun@tspkk.co.th			2026-06-21 16:00:20.187635	2026-06-21 16:00:20.187635
773	K.Ramida	TSPKKL	K.แมว						2026-06-21 16:00:20.187919	2026-06-21 16:00:20.187919
774	K.Suebsak	TSPKKL	Suebsak		IT	suebsak.sun@tspkk.co.th			2026-06-21 16:00:20.188309	2026-06-21 16:00:20.188309
775	Amporn	TTSC	Amporn			amporn.so@thaitakagi.com			2026-06-21 16:00:20.189358	2026-06-21 16:00:20.189358
776	ARNAT	TTSC	ARNAT		ENGINEER	arnat.ng@thaitakagi.com	089-996-1292		2026-06-21 16:00:20.189497	2026-06-21 16:00:20.189497
777	ATCHARAPAN	TTSC	ATCHARAPAN		GA & HR	atcharapan.ch@thaitakagi.com	090-0043115		2026-06-21 16:00:20.189654	2026-06-21 16:00:20.189654
778	BANGORN	TTSC	BANGORN		PRODUCTION	bangorn.kh@thaitakagi.com	081-375-7518, 083-213-2772		2026-06-21 16:00:20.189804	2026-06-21 16:00:20.189804
779	CHAIWAT	TTSC	CHAIWAT		ENGINEER	chaiwat.bo@thaitakagi.com	082-063-7337		2026-06-21 16:00:20.189953	2026-06-21 16:00:20.189953
780	fon	TTSC	Wacharaporn			Wacharaporn.po@thaitakagi.com			2026-06-21 16:00:20.190077	2026-06-21 16:00:20.190077
781	K.Kamolrat	TTSC	Kamolrat			kamolrat.sa@thaitakagi.com			2026-06-21 16:00:20.190214	2026-06-21 16:00:20.190214
782	K.Patcharin	TTSC	Patcharin			patcharin.te@thaitakagi.com			2026-06-21 16:00:20.190317	2026-06-21 16:00:20.190317
783	K.Pongpisut	TTSC	Pongpisut			pongpisut.th@thaitakagi.com			2026-06-21 16:00:20.190435	2026-06-21 16:00:20.190435
784	KANCHANA	TTSC	KANCHANA			kanchana.ta@thaitakagi.com			2026-06-21 16:00:20.190558	2026-06-21 16:00:20.190558
785	KANTANAT(ฮั้ว)	TTSC	กาญจน์ธนัชญ์		Accounting	Kantanat.ka@thaitakagi.com			2026-06-21 16:00:20.190667	2026-06-21 16:00:20.190667
786	KASSARIN	TTSC	KASSARIN		Account	kassarin.sr@thaitakagi.com	086-333-9915		2026-06-21 16:00:20.190771	2026-06-21 16:00:20.190771
787	Natsaranphorn	TTSC	Natsaranphorn			Natsaranphorn.Uk@Thaitakagi.com			2026-06-21 16:00:20.190888	2026-06-21 16:00:20.190888
788	NATTHA	TTSC	NATTHA		PRODUCTION	nattha.sr@thaitakagi.com	081-838-6959		2026-06-21 16:00:20.191	2026-06-21 16:00:20.191
789	NISANAT	TTSC	NISANAT		GA & HR	nisanat.wa@thaitakagi.com	081-565-4456		2026-06-21 16:00:20.191108	2026-06-21 16:00:20.191108
790	NUENGHATHAI	TTSC	NUENGHATHAI		Account	nuenghathai.th@thaitakagi.com	088-008-0211		2026-06-21 16:00:20.191234	2026-06-21 16:00:20.191234
791	Panyapon	TTSC	Panyapon						2026-06-21 16:00:20.191343	2026-06-21 16:00:20.191343
792	PENKHAE	TTSC	PENKHAE		ENGINEER	penkhae.kh@thaitakagi.com	083-541-8411		2026-06-21 16:00:20.191451	2026-06-21 16:00:20.191451
793	PHAIROTE	TTSC	Phairote			Phairote.ph@thaitakagi.com			2026-06-21 16:00:20.191556	2026-06-21 16:00:20.191556
794	PHOOMSIT	TTSC	Phoomsit			phoomsit.vu@thaitakagi.com			2026-06-21 16:00:20.191657	2026-06-21 16:00:20.191657
795	PIRANTANA	TTSC	PIRANTANA		SALES	pirantana.ut@thaitakagi.com	083-1948581		2026-06-21 16:00:20.191756	2026-06-21 16:00:20.191756
796	PIYACHAT	TTSC	PIYACHAT		SALES	piyachat.ch@thaitakagi.com	089-96999-01, 081-731-8934		2026-06-21 16:00:20.191869	2026-06-21 16:00:20.191869
797	SARANRACH	TTSC	SARANRACH						2026-06-21 16:00:20.192011	2026-06-21 16:00:20.192011
798	SARRAVUT	TTSC	SARRAVUT		ENGINEER	sarravut.su@thaitakagi.com	081-135-3443, 086-344-4841		2026-06-21 16:00:20.192152	2026-06-21 16:00:20.192152
799	SUBIN	TTSC	SUBIN		IT	subin.kw@thaitakagi.com	089-534-0336		2026-06-21 16:00:20.192307	2026-06-21 16:00:20.192307
800	SUKANDA	TTSC	SUKANDA		PRODUCTION	sukanda.kl@thaitakagi.com	085-224-6465		2026-06-21 16:00:20.192405	2026-06-21 16:00:20.192405
801	Supaporn	TTSC	Supaporn			supaporn.nu@thaitakagi.com			2026-06-21 16:00:20.192526	2026-06-21 16:00:20.192526
802	Supaporn Nuwong	TTSC	Supaporn			supaporn.nu@thaitakagi.com			2026-06-21 16:00:20.192627	2026-06-21 16:00:20.192627
803	SUPAWEE	TTSC	SUPAWEE		PRODUCTION	supawee.pa@thaitakagi.com	092-263-6393, 089-138-8692		2026-06-21 16:00:20.19273	2026-06-21 16:00:20.19273
804	THAEWITA	TTSC	Thaewita			Thaewita.Sa@thaitakagi.com			2026-06-21 16:00:20.192842	2026-06-21 16:00:20.192842
805	THAKSAPORN	TTSC	THAKSAPORN		ENGINEER	thaksaporn.ri@thaitakagi.com	086-325-9177		2026-06-21 16:00:20.192967	2026-06-21 16:00:20.192967
806	THANITA	TTSC	Thanita		Account	Thanita.ph@thaitakagi.com			2026-06-21 16:00:20.193107	2026-06-21 16:00:20.193107
807	WIKANDA	TTSC	WIKANDA		PRODUCTION	wikanda.mu@thaitakagi.com	089-454-9410		2026-06-21 16:00:20.193229	2026-06-21 16:00:20.193229
808	WILAILAK	TTSC	Wilailak		Accounting	wilailak.po@thaitakagi.com			2026-06-21 16:00:20.193341	2026-06-21 16:00:20.193341
809	Yasinee	TTSC	Yasinee			yasinee.ti@thaitakagi.com			2026-06-21 16:00:20.19345	2026-06-21 16:00:20.19345
810	Ubon Singthongkhum	BISW	Ubon	Singthongkhum					2026-06-21 16:00:20.19356	2026-06-21 16:00:20.19356
811	Unchana Soparp	BISW	Unchana	Soparp					2026-06-21 16:00:20.193697	2026-06-21 16:00:20.193697
812	K.Ann	VENZE	K.แอน						2026-06-21 16:00:20.193808	2026-06-21 16:00:20.193808
813	K.Kai	VENZE	K.ไก่			it2@tngroup.co.th			2026-06-21 16:00:20.193919	2026-06-21 16:00:20.193919
814	K.Ann	VENZI	K.แอน						2026-06-21 16:00:20.194034	2026-06-21 16:00:20.194034
815	K.Kai	VENZI	K.ไก่			it2@tngroup.co.th			2026-06-21 16:00:20.194152	2026-06-21 16:00:20.194152
816	K.Ann	VENZTM	K.แอน						2026-06-21 16:00:20.194276	2026-06-21 16:00:20.194276
817	K.Kai	VENZTM	K.ไก่			it2@tngroup.co.th			2026-06-21 16:00:20.194395	2026-06-21 16:00:20.194395
818	Wanna Harisombat	BISW	Wanna	Harisombat	ฮ้ว				2026-06-21 16:00:20.194504	2026-06-21 16:00:20.194504
819	Weera Rorboom	BISW	Weera	Rorboom	วีระ				2026-06-21 16:00:20.194633	2026-06-21 16:00:20.194633
820	Weerathep Chaleansamithchai	BISW	Weerathep	Chaleansamithchai	ท็อป				2026-06-21 16:00:20.194747	2026-06-21 16:00:20.194747
821	K.Kittimaporn	BISW	WSEA	Kittimaporn		kittimaporn.s@senior-thailand.			2026-06-21 16:00:20.194857	2026-06-21 16:00:20.194857
822	Wuttichai Suwanmareejit	BISW	Wuttichai	Suwanmareejit	ปิง				2026-06-21 16:00:20.194997	2026-06-21 16:00:20.194997
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.customers (id, cust_num, cust_name, contact_email, version, license, account_owner, infor_ma, ppcc_app_ma, ppcc_cust_ma, ppcc_tech_ma, prefix) FROM stdin;
70	PKF	PATKOL FOOD INDUSTRY PARTNER CO., LTD.	test.support@ppcc.co.th	SL90020	680NU	PPCC	NO	x	YES	YES	PKF
72	HA	HA	\N	\N	\N	\N	\N	\N	\N	\N	\N
73	HHT	HHT	\N	\N	\N	\N	\N	\N	\N	\N	\N
74	TG	TG	\N	\N	\N	\N	\N	\N	\N	\N	\N
5	ADI	ADVANCE DIE CASTING CO., LTD.	test.support@ppcc.co.th	SL90110			YES	YES			ADI
1	ART	ART-SERINA PISTON CO., LTD.	test.support@ppcc.co.th	SL70420		PPCC	x	YES	x	YES	ART
2	CNI	C.N.I ENGINEERING SUPPLY Co., Ltd.	test.support@ppcc.co.th	SL10 2022.03.1.8		PPCC	YES	YES	YES	YES	CNI
8	CCH	CHUE CHIN HUA CO., LTD.	test.support@ppcc.co.th	SL80311	80 CCL	PPCC	YES	YES	YES	YES	CCH
45	CIS	CIS	test.support@ppcc.co.th								CIS
14	PK-HA	HEATAWAY CO.,LTD.	test.support@ppcc.co.th	SL90020	680 NU	PPCC	YES	x	YES	YES	HA
44	IIT	IIT	test.support@ppcc.co.th								IIT
9	NST	NEW SOMTHAI MOTOR WORK CO., LTD.	test.support@ppcc.co.th	SL70420	50 CCL	PPCC	x	x	x	x	NST
3	NTH	NICHICON (THAILAND) CO.,LTD.	test.support@ppcc.co.th	SL10 2024.09.01.5	12 NU	HISYS	YES	YES	YES	x	NTH
11	OTC	OGIHARA (THAILAND) CO.,LTD.	test.support@ppcc.co.th	SL80010	40 CCL	Infor Direct	YES	YES	x	YES	OTC
15	ICE	PATKOL ICE SOLUTIONS CO.,LTD.	test.support@ppcc.co.th	SL90020	680 NU	PPCC	YES	x	YES	YES	ICE
12	PK	PATKOL PUBLIC CO., LTD.	test.support@ppcc.co.th	SL90020	680 NU	PPCC	YES	x	YES	YES	PK
16	RX	R.X. MANUFACTURING CO., LTD.	test.support@ppcc.co.th	SL70308	52 CCL	PPCC	NO	YES	x	x	RX
17	SNPR	SIAM NPR CO., LTD.	test.support@ppcc.co.th	SL80311	21 CCL	PPCC	YES	YES	YES	YES	SNPR
19	SST	SIAM SENATER CO., LTD.	test.support@ppcc.co.th	SL90030	10 CCL	PPCC	YES	x	x	x	SST
4	SRN	SRN SOUND PROOF CO.,LTD	test.support@ppcc.co.th	SL90110	15 CCL	PPCC	YES	x	x	x	SRN
43	SSMC	SSMC	test.support@ppcc.co.th						x	x	SSMC
21	TAK	T.A.K.PACKAGING CO., LTD.	test.support@ppcc.co.th	SL80311	69 NU	PPCC	YES	YES	YES	YES	TAK
20	TAIYO	TAIYO CABLETEC (THAILAND) CO.,LTD.	test.support@ppcc.co.th	SL80311		HISYS	YES	x	x	x	TAIYO
41	TBFST	TBFST	test.support@ppcc.co.th	SL10 2023.03.1.7		PPCC	YES				TBFS
22	TTSC	THAI TAKAGI SEIKO CO.,LTD.	test.support@ppcc.co.th	SL80311		HISYS	YES	YES	YES	x	TTSC
7	BISW	THE BANGKOK IRON AND STEEL WORKS CO., LTD.	test.support@ppcc.co.th	SL10.0.0.421	25CCL		x				BISW
13	PK-TG	TYGIENIC CO.,LTD.	test.support@ppcc.co.th	SL90020	680 NU	PPCC	YES	x	YES	YES	TG
\.


--
-- Data for Name: error_types; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.error_types (error_id, description, remark) FROM stdin;
D	Unidentified	
H	Human Error	
I	zNot Used-Issue Log	
K	Knowledge	
L	PPCC Localized	
O	zNot Used-Other	
OP	Opening Balance	
P	Customized Bug	
PC	Customized Bug By Customer	
R	zNot Used-Recommended working	
S	Standard Bug	
T	Technical	
U	zNot Used-User Edit Program	
V	Investigate	
C	Spec Changed	Spec Changed
\.


--
-- Data for Name: issue_types; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.issue_types (id, name) FROM stdin;
1	Technical
2	BugCustomization
3	BugStandard
4	Knowledge
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.messages (id, ticket_id, sender_id, message_text, created_at, is_internal) FROM stdin;
\.


--
-- Data for Name: module_program_group; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.module_program_group (id, module, program_group, note) FROM stdin;
1	AP	Petty Cash Payment	Petty Cash Payment
2	AP	Generate Bank File	Generate Bank File
3	AP	AP Voucher and Adjustments	AP Voucher and Adjustments
5	SC	Service Contract	\N
6	AP	AP Posted Transactions Detail	AP Posted Transactions Detail
7	AR	Customer Order Invoice	Customer Order Invoice
8	AR	Delivery Order Invoice	Delivery Order Invoice
9	AR	Project Invoice	Project Invoice
10	AR	Service Order Invoice	Service Order Invoice
11	AR	Service Tax Invoice	Service Tax Invoice
12	AR	Service Contract Invoice	Service Contract Invoice
13	AR	RMA Invoice	RMA Invoice
14	AR	Price Adjustment Invoice	Price Adjustment Invoice
15	AR	Customer Rating	Customer Rating
16	AR	AR Billing	AR Billing
17	AR	AR Invoice Voucher Report	AR Invoice Voucher Report
18	AR	AR Payment	AR Payment
19	AR	AR Posted Transactions	AR Posted Transactions
20	GL	Journal Entrie	Journal Entrie
21	GL	Journal Recurring	Journal Recurring
22	GL	Journal Posting	Journal Posting
23	GL	GL Posted Transactions	GL Posted Transactions
24	GL	General Ledger By Account Report	General Ledger By Account Report
25	CST	Project Inquiry	Project Inquiry
26	CST	Project Costing	Project Costing
27	CST	FS Costing	FS Costing
28	CST	Project Revenue	Project Revenue
29	CST	Production Costing	Production Costing
30	CST	CO Costing	CO Costing
31	Update UC1	Update UC1	\N
32	System	System Error	\N
33	FNS	Cash Flow	Cash Flow
34	PJC	Project Labor	Project Labor
35	PO	Purchase Orders	Purchase Orders
36	PJC	Project Revenue Milestones Genration	Project Revenue Milestones Genration
37	PO	Goods Receiving Notes	Goods Receiving Notes
38	APM	ICash	ICash ICash Distribution
39	APM	ICash Transfer	ICash Transfer
40	APM	Generate Bank File	Generate Bank File
41	ISH	Easy Voucher	Easy Voucher
42	AP	Input Vat	Input Vat Report
43	AR	Output Vat	Output Vat Report
44	Automation	Job Material Transaction	Job Material Transaction
45	Automation	Transfer Order Ship	Transfer Order Ship
46	Automation	Quantity Move	Quantity Move
47	AR	Pre Invoice	Pre Invoice
48	Automation	??????	??????
49	Milk Run	Milk Run	Milk Run
50	SFC	Job Order	\N
51	EDI	EDI Load Forecast	EDI Load Forecast
52	Cycle	Cycle Count Posting	Cycle Count Posting
53	FA	Fixed Asset Generate Card	Fixed Asset Generate Card
54	FA	Fixed Asset Depreciation	Fixed Asset Depreciation
55	FA	Fixed Asset Disposal	Fixed Asset Disposal
56	FA	Fixed Assest Transfer	Fixed Assest Transfer
57	SRO	Service Orders	\N
58	APM	Cutoff	Cutoff Cutoff Report
59	Automation	Print Tag	Print Tag
60	Automation	Unposted Job Transaction	Unposted Job Transaction
61	AR	AR Receipt	AR Receipt
62	SFC	Print Tag	Print Tag
63	SFC	Process Slip	Process Slip
64	RMA	RMA Credit Memos	RMA Credit Memos
65	SH	Order Shipping	\N
66	SFC	Job Material Transactions	\N
67	Cycle	Cycle Count Variance Report	Cycle Count Variance Report
68	DO	Order Pick List	Order Pick List
69	PR	Purchase Order Requisitions	Purchase Order Requisitions
70	Technical	Report	\N
71	AP	Budget Code	Budget Code
72	BG	Budget Control	Budget Control
73	RMA	RMA	RMA
74	RMA	RMA Return Transactions	RMA Return Transactions
75	PO	Purchase Order Report	Purchase Order Report
76	PO	Purchase Po Dist Report	Purchase Po Dist Report
77	IC	Spare Part Return Slip	Spare Part Return Slip
78	AR	Account Receivable Aging Report	Account Receivable Aging Report
79	IC	Miscellaneous Receipt	Miscellaneous Receipt
80	GL	Excel Add-In	Excel Add-In
81	BC	Barcode-PO	?????? SRN
82	BC	Barcode-CO	?????? SRN
83	BC	Barcode-JOB	?????? SRN
84	BC	Barcode-Master	?????? SRN
85	BC	Barcode-IC	?????? SRN
86	GL	Budget Control	Budget Control
87	MIA	MIA	MIA
88	SFC	Job Transactions	\N
89	Oth	PDS	PDS
90	IC	Weight Interface Incoming	BISW
91	SFC	Weight Interface Production	BISW
92	DO	Delivery Order Lines	Delivery Order Lines
93	SH	Picking List	\N
94	MB	Mobile	Mobile
95	CU	Customers	Customers
96	SFC	Unposted Job Transactions	Unposted Job Transactions
97	TO	Transfer Order Line	\N
98	PJC	Project Generate Order Pick List	Project Generate Order Pick List
99	CO	Invoicing Report	Invoicing Report
100	CUR	Customer Rating	Customer Rating
101	FA	Fixed Assets	Fixed Assets
102	PJC	Project Invoice Milestone	Project Invoice Milestone
103	CO	Progressive Billings	Progressive Billings
104	GL	Journal Voucher Report	Journal Voucher Report
105	CO	Price Adjustments Invoice Report	Price Adjustments Invoice Report
106	FA	Fixed Asset Depreciation Posted Report	Fixed Asset Depreciation Posted Report
107	AP	AP Payment Distributions	AP Payment Distributions
108	CO	Customer Orders	Customer Orders
109	CO	Order Shipping	Order Shipping
110	Automation	Scan Order PickList	\N
4	AP	AP Payment	AP Payment
111	RMA	RMA Lines Item	RMA Lines Item
112	TO	Transfer Order	\N
113	AM	Web Service	Web Service
114	MAS	Chart of Accounts	Chart of Accounts
115	Oth	Material Planner Workbench	Material Planner Workbench
116	AP	Voucher Adjustment Distribution	Voucher Adjustment Distribution
117	DO	Delivery Order Line Sequences	Delivery Order Line Sequences
118	PO	API Vendor Contract Price All	API Vendor Contract Price All
119	IC	Part Delivery Sheet Report	Part Delivery Sheet Report
120	PO	API Vendor	API Vendor
121	PO	API Create PO/PO Line	API Create PO/PO Line
122	IC	API PDS	API PDS
123	IC	API WC Matl Issue	API WC Matl Issue
124	IC	Web Service (JSON)	Web Service (JSON)
125	DO	Consolidated Invoicing	Consolidated Invoicing
126	AP	Petty Cash Payment Distribution	Petty Cash Payment Distribution
127	AP	AP Voucher Posting	AP Voucher Posting
128	AR	AR Payment Posting	AR Payment Posting
129	FA	Fixed Asset Costs	Fixed Asset Costs
130	FA	Fixed Asset Acquisition Report	Fixed Asset Acquisition Report
131	FA	Fixed Asset Monitoring GL Report	Fixed Asset Monitoring GL Report
132	PO	Generate AP Transactions	Generate AP Transactions
133	PO	Purchase Order Receiving	Purchase Order Receiving
134	PJC	Project Report	Project Report
135	SC	Service Contract To Be Invoiced Report	\N
136	DO	Consolidate Invoice Generations	\N
137	SFC	Job Material	\N
138	PJC	Print Post Project Reveune Milestone	\N
139	IC	Lots	Lots
140	PJC	Confirm Qty Pick History	\N
141	PJC	Project Inquiry	Project Inquiry
142	AP	Voucher Payable Report	Voucher Payable Report
143	PJC	Projects	\N
144	AR	Invoice Transaction Report	Invoice Transaction Report
145	PJC	Revenue Milestones	Revenue Milestones
146	AR	Progressive Invoice	\N
147	GL	Mass Journal Posting	Mass Journal Posting
148	GL	Ledger Posting for Journal	Ledger Posting for Journal
149	Oth	Yusen	Yusen
150	CU	Vendor Customer Contract Prices	Vendor Customer Contract Prices
151	MAS	Currency Rate	Currency Rate
152	AP	AP Payment Generation	AP Payment Generation
153	IC	Roll Current Cost to Standard Cost	Roll Current Cost to Standard Cost
154	IC	Work Centers	Work Centers
155	Automation	Order Shipping	Order Shipping
156	Automation	Generate GRN	Generate GRN
157	Automation	Transfer Order Receive	Transfer Order Receive
158	AP	Suspense Input Tax Clear	Suspense Input Tax Clear
159	AP	AP Billing	AP Billing
160	AP	Withholding Tax Statement Report	Withholding Tax Statement Report
161	Shipment	Shipment	Shipment
162	EDI	EDI Load Order	EDI Load Order
163	FC	Forecast	Forecast
164	PJC	Project Invoice Milestone Nomination	Project Invoice Milestone Nomination
165	IC	Miscellaneous Issue	Miscellaneous Issue
166	AP	Accounts Payable Aging Report	Accounts Payable Aging Report
167	Shipment	Pick Workbench	\N
168	Technical	Forms	\N
169	IC	Quantity Move	Quantity Move
170	GL	General Ledger	General Ledger
171	Cycle	Cycle Count Update	\N
172	PLN	APS Planning	APS Planning
173	CO	Barcode	Barcode
174	Oth	Tag	Tag
175	AR	Export Invoice	Export Invoice
176	DO	Delivery Order	Delivery Order
177	AR	AR Check Due Posting	AR Check Due Posting
178	SA	Reports	\N
179	Co-Product	Co-Product Mix Operations	Co-Product Mix Operations
180	Oth	PPCC Localized	PPCC Localized
181	AM	API	API
182	Oth	WMS	WMS
183	PJC	Project Invoice Milestone Lines	Project Invoice Milestone Lines
184	Co-Product	Co-Product Mix	Co-Product Mix
185	Vendors	Vendors	\N
186	PJC	Project Order Pickups	Project Order Pickups
187	IC	Copy Routing BOM	\N
188	AP	AP Invoice Voucher Report	AP Invoice Voucher Report
189	AR	Invoices Debit and Credit Memos	Invoices Debit and Credit Memos
190	AR	AR Payment Voucher Report	AR Payment Voucher Report
191	IC	FG Receiving Report	FG Receiving Report
192	FA	Fixed Asset Transfer Report	Fixed Asset Transfer Report
193	PO	Goods Receiving Note Lines	Goods Receiving Note Lines
194	CO	Order Invoicing/Credit Memos	Order Invoicing/Credit Memos
195	IC	Daily Inventory Checking Report	Daily Inventory Checking Report
196	IC	Item/Warehouse	Item/Warehouse
197	AR	Item Sale Invoice Report	Item Sale Invoice Report
198	IC	Material Transaction Report	Material Transaction Report
199	PLN	Planning Detail	Planning Detail
200	AP	Po Vch GL Comparison Report	Po Vch GL Comparison Report
201	GL	Journal Voucher Report List	Journal Voucher Report List
202	AR	Sale Invoice Report	Sale Invoice Report
203	IC	Production Lable	Production Lable
204	PO	Purchase Order Status Receive Report	Purchase Order Status Receive Report
205	IC	Spare Part Issue Slip	Spare Part Issue Slip
206	IC	Inventory Aging Report	Inventory Aging Report
207	IC	Inventory Balance Warehouse Report	Inventory Balance Warehouse Report
208	AR	AR Receipt Report	AR Receipt Report
209	PO	Generate PDS	Generate PDS
210	PO	PDS Report	PDS Report
211	CO	Price Adjustments	Price Adjustments
212	PO	Web PR&PO Approve	Web PR&PO Approve
213	PO	Purchase Order Lines	Purchase Order Lines
214	AR	Invoice Debit and Credit Memos G/L Distributions	Invoice Debit and Credit Memos G/L Distributions
215	IC	API Item	API Item
216	AP	Withholding Tax Certificate Report	Withholding Tax Certificate Report
217	AP	Withholding Tax Statement Export File	Withholding Tax Statement Export File
218	FA	Fixed Asset Disposal Report	Fixed Asset Disposal Report
219	PO	API Vendor Contract Price	API Vendor Contract Price
220	PO	API Item	API Item
221	IC	API Item Location	API Item Location
222	CO	Customer Order Lines	Customer Order Lines
223	PO	Generate Landed Cost Voucher	Generate Landed Cost Voucher
224	AP	AP Check Printing/Posting	AP Check Printing/Posting
225	AP	Suspense Input Tax Clear Posting	Suspense Input Tax Clear Posting
226	AR	AR Check Due Aging Report	AR Check Due Aging Report
227	AR	AR Payment Distributions	AR Payment Distributions
228	AR	Invoice Posting	Invoice Posting
229	FA	Fixed Asset Class Codes	Fixed Asset Class Codes
230	FA	Fixed Asset By Department Report	Fixed Asset By Department Report
231	PR	Purchase Order Requisition Lines	Purchase Order Requisition Lines
232	AP	AP Payment Voucher Report	AP Payment Voucher Report
233	AR	AR Invoice Debit and Credit Memos Report	AR Invoice Debit and Credit Memos Report
234	AP	Bank Transfer	Bank Transfer
235	DO	Daily Delivery Report	\N
236	IC	Finish Goods Receiving	Finish Goods Receiving
237	FA	Fixed Asset Register	Fixed Asset Register
238	FA	Fixed Assets Label	Fixed Assets Label
239	PO	Goods Receiving Note Report	Goods Receiving Note Report
240	IC	Inventory Balance Report By Warehoue	Inventory Balance Report By Warehoue
241	IC	Items	Items
242	IC	Item Lot Locations	Item Lot Locations
243	PO	Item Purchase History	Item Purchase History
244	PLN	Material Planner Workbench	Material Planner Workbench
245	CO	Order Status Report	Order Status Report
246	FA	Fixed Asset Transfer History	Fixed Asset Transfer History
247	IC	Work Center Material Transaction	Work Center Material Transaction
248	IC	Tag Barcode for Spare Part YTB	Tag Barcode for Spare Part YTB
249	PO	Vendor Contract Prices	Vendor Contract Prices
250	CO	Send Data	Send Data
251	FA	Fixed Asset Transfer History Report	Fixed Asset Transfer History Report
252	GL	Year End Closing Journal Entries	Year End Closing Journal Entries
253	SH	Order PickList	Order PickList
254	AP	AP Quick Payment Application	AP Quick Payment Application
255	IC	Item Stockroom Location Mass Creation	Item Stockroom Location Mass Creation
256	IC	Stock Card Report	\N
257	Oth	Create Request	ART
258	SFC	Pending Material Transactions	Pending Material Transactions
259	SFC	Current Operations	Current Operations
260	PAJ	Price Adjustments	\N
261	IC	Inventory Balance Report	\N
262	IC	Inventory Month End Freeze Process	\N
263	IC	Goods And Material Transaction Report	\N
264	SFC	Job Status Change/Delete Utility	\N
265	IC	Material Transactions	\N
266	DO	Consolidate Invoices Workbench	\N
267	IC	Inventory Consigned From Vendor Usage	Inventory Consigned From Vendor Usage
268	SFC	Pending Job Labor Transactions	Pending Job Labor Transactions
\.


--
-- Data for Name: modules; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.modules (id, name, description) FROM stdin;
27	ALL	ALL
28	AM	AutoMotion
29	AP	Accounts Payable
30	APM	Appointment
31	AR	Accounts Receivable
32	Automation	Web Automation
33	BC	Barcode
34	BG	Budgets
35	BOM	Bill of Materials
36	CO	Customer Order
37	Co-Product	Co-Product
38	CSF	CashFlow
39	CST	Costing
40	CU	Customer
41	CUR	Customer Rating
42	Cycle	Cycle Count
43	DO	Delivery Order
44	EDI	EDI
45	EVM	Event Management
46	FA	Fixed Assets
47	FC	Forecast
48	FNS	Financial Statements
49	FS	Field Service
50	FTM	FTM
51	GL	General Ledger
52	IC	Inventory Control
53	ISH	I-Cash
54	Item	Item
55	MAS	Master Data
56	MB	Mobile
57	MIA	Material Issue Approval
58	Milk Run	Milk Run
59	OLS	OLS
60	Oth	Other
61	PAJ	Price Adjustment
62	PJC	Projects
63	PLN	Planning
64	PO	Purchase Order
65	PR	Purchase Order Requisitions
66	PS	Production Schedule
67	QCS	Quality Control System
68	RMA	RMA
69	SA	System Administrator
70	SC	Service Contract
71	SCH	Scheduling
72	SFC	Shop Floor Control / Job Order
73	SH	Shipping
74	Shipment	Shipment
75	SRO	Service Orders
76	System	System
77	Technical	Technical
78	TO	Transfer Order
79	Update UC1	Update UC1
80	VCN	Vendor Connect
81	Vendors	Vendors
82	VMI	Vendor Management
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.notifications (id, user_id, title, message, is_read, type, ticket_id, created_at) FROM stdin;
\.


--
-- Data for Name: program_types; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.program_types (id, name, value) FROM stdin;
2	Customized	C
3	Localized	L
1	Standard	S
4	Technical	T
5	Application Support	A
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.roles (id, name, base_role) FROM stdin;
1	Customer	customer
2	Agent	agent
3	Admin	admin
\.


--
-- Data for Name: support_stats; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.support_stats (stat, description, remark, seq) FROM stdin;
C	999-Closed		999
D	030-Identify	assumption - Cust Bug - STD Bug / Under Design	30
F	120-Awaiting Infor		120
I	050-In-Process	Editing or Doing	50
M	Monitor		9999
N	Not Accept	Not Accept	9999
O	010-Open	1st Level Support log into system	10
Q	060-Intemal PPCC QC	Testing on PPCC Server	60
S	040-Solution Finding	Find solution, Method how to solve	40
T	080-Test on CRP/UAT-QC	Testing on Customer Server (CRP / UAT)	80
V	020-Investigate	When DEV/Supp pull that log to investigate	20
W	100-Awaiting Customer	Waiting to Customer	100
\.


--
-- Data for Name: ticket_attachments; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.ticket_attachments (id, ticket_id, file_url, file_name, created_at) FROM stdin;
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.tickets (id, title, description, priority, status, customer_id, agent_id, created_at, updated_at, module, resolved_at, solution, workaround, attachment_url, attachment_name, resolved_by, cust_num, ticket_number, assigned_at, form_name, additional_email, program_type, issue_type, contact_name, request_date, request_time, cause, remark, projected_date) FROM stdin;
974	ราคาไม่ขึ้นค่ะ	ราคาไม่ขึ้นค่ะ	medium	C	\N	14	2026-06-21 20:53:40.303932	2026-01-22 00:00:00	PO	2026-01-22 00:00:00	ลดขนาดช่องว่างระหว่างขอบ (Padding) ข้อความจาก 20 เหลือ 15 เพื่อไม่ให้ข้อความตกบรรทัด	\N	\N	\N	14	ADI	ADI2601002	\N	Purchase Order Report	\N	Customized	Customized Bug	Natty	2026-01-22	09:45:00	\N	\N	2026-01-27
975	EIV2601-0009 รบกวนช่วยแก้ ทศนิยม 8,553.60ให้หน่อยค่ะ	EIV2601-0009 รบกวนช่วยแก้ ทศนิยม 8,553.60ให้หน่อยค่ะ	medium	C	\N	14	2026-06-21 20:53:40.30585	2026-02-09 00:00:00	AR	2026-02-09 00:00:00	Update Database	\N	\N	\N	14	ADI	ADI2602001	\N	Invoices, Debit and Credit Memos	\N	Customized	Unidentified	K.Natthakan	2026-02-06	16:55:00	Diff ทศนิยม	\N	2026-02-11
1012	รบกวนช่วยตรวจสอบให้หน่อยค่ะ scan ขึ้น tag ไม่ถุกต้อง	รบกวนช่วยตรวจสอบให้หน่อยค่ะ scan ขึ้น tag ไม่ถุกต้อง	medium	C	\N	20	2026-06-21 20:53:40.375498	2026-01-07 00:00:00	CO	2026-01-07 00:00:00	แจ้ง User ให้แก้ไข Item For Tag ให้ตรงกับ Cust Doc. และแก้ไข Cust Item ที่ Tag	\N	\N	\N	14	CNI	CNI2601004	\N	Customer Contracts	\N	Customized	Human Error	K.Pimpa	2026-01-07	11:40:00	Item For Tag คีย์ข้อมูลไม่ตรงกับ Cust Item ที่ Cust Doc	\N	2026-01-12
1013	รบกวนดู Journal Entries เล่ม SL Dist ให้หน่อยค่ะ โน๊ตออกไม่ครบทุกหน้าค่ะ	รบกวนดู Journal Entries เล่ม SL Dist ให้หน่อยค่ะ โน๊ตออกไม่ครบทุกหน้าค่ะ	medium	C	\N	14	2026-06-21 20:53:40.376654	2026-01-08 00:00:00	GL	2026-01-08 00:00:00	แก้ไขโค้ดรายงาน ให้ดึง Note ตาม Ref	\N	\N	\N	14	CNI	CNI2601005	\N	PPCC_Journal Voucher Listing Report	\N	Localized	PPCC Localized	K.Monthakan	2026-01-08	10:15:00	Ref เดียวกัน แต่มี Control Number ลง 1 กับ 2	\N	2026-01-13
1017	ทางบัญชีแจ้งว่าโพสท์ไม่ไปครับมี error	Error : DialogResult can be set only after Window is created and shown as dialog	medium	C	\N	14	2026-06-21 20:53:40.382037	2026-01-14 00:00:00	GL	2026-01-14 00:00:00	เมื่อ Task รายงานรันจบ User สามารถใช้งานได้ปกติ	\N	\N	\N	14	CNI	CNI2601009	\N	Ledger Posting for Journal	\N	Tech	Technical	K.Witaya	2026-01-13	08:25:00	คาดว่ารายงานยังรันไม่จบ	\N	2026-01-16
1082	เพิ่มรายการใน Journal Entries #RV2603001 (Urgent)	รบกวนช่วยแก้ไขรายการใน Journal Entries เนื่องจากว่ารับเงินจาก MACO สกุลเงิน USD post AR payment มาที่ Journal Entries แต่ระบบไม่แสดงรายการที่เป็นยอด Loss on Exchange\n\nตามไฟล์แนบมาให้เนื่องจากว่ารายการตั้งต้นดังกล่าวเป็น Credit note\n\nช่วยเพิ่มบรรทัดและระบุ Account code + ยอดเงิน และฝั่งการลงบัญชีตามที่แจ้งไปด้วยค่ะ	medium	C	\N	14	2026-06-21 20:53:40.454244	2026-04-01 00:00:00	GL	2026-04-01 00:00:00	Insert ข้อมูลเข้าตาราง journal	\N	\N	\N	14	NTH	NTH2603007	\N	Journal Entries	\N	Localized	PPCC Localized	K.Dararat	2026-03-31	16:45:00	\N	\N	2026-04-03
1110	รบกวนตรวจสอบ APV37498	เนื่องจากทางเราได้มีการ Generate ตั้งหนี้ ใส่ข้อมูล และเลือก Budgets 613013/ Telephone-Domestic ตามปกติ ซึ่งยังไม่ได้ทำการ Post แต่ทำไม Budget ถึงไปอยู่ที่ Actual use คะ (โดยปกติน่าจะอยู่ที่ Allocated on Oder) รายละเอียดตามภาพด้านล่างค่ะ	medium	C	\N	14	2026-06-21 20:53:40.484375	2026-01-29 00:00:00	AP	2026-01-29 00:00:00	ลบข้อมูล Voucher 37498 ออกจาก PPCC_Budget Actual Used Detail	\N	\N	\N	14	SRN	SRN2601006	\N	PPCC_A/P Voucher and Adjustments	\N	Customized	Customized Bug	Songapson	2026-01-28	13:20:00	มีการ Post Voucher โดยไม่ใส่เงื่อนไขจึงทำให้ Voucher 37498 ถูก Task PPCC_UpdateBudgetControlAllSp ดึงไปทำรายการด้วย	\N	2026-02-02
1118	JOB UD2913 PD รายงานผลแล้ว แต Tag ถูกติ๊ก Unpost ยอดไม่โชว์ทำให้แผนก DL รับงานไม่ได้ค่ะ รบกวนช่วยตรวจสอบให้หน่อยนะค่ะ	JOB UD2913 PD รายงานผลแล้ว แต Tag ถูกติ๊ก Unpost ยอดไม่โชว์ทำให้แผนก DL รับงานไม่ได้ค่ะ รบกวนช่วยตรวจสอบให้หน่อยนะค่ะ	medium	C	\N	18	2026-06-21 20:53:40.497493	2026-02-18 00:00:00	Automation	2026-02-18 00:00:00	Post Job ที่ค้างอยู่ที่หน้าจอ Unposted Job Transactions	\N	\N	\N	14	SRN	SRN2602007	\N	๊Unposted Job Transactions	\N	Customized	Customized Bug	Thidaporn	2026-02-17	09:25:00	Job ค้างอยู่ที่หน้าจอ Unposted Job Transactions	\N	2026-02-20
1112	แจ้งตรวตสอบราคาใน GRN T2602000000007	แจ้งตรวตสอบราคาใน GRN T2602000000007 เนื่องตาก ราคา ใน PO และ Invoiice ตรงกัน แต่เมื่องทางฝ่ายวางแผนดึงรายการมาทำ GRN T2602000000007 ราคาเปลี่ยนไป รบกวนช่วยตรวจสอบให้ด้วยค่ะ	medium	C	\N	14	2026-06-21 20:53:40.485963	2026-02-04 00:00:00	PO	2026-02-04 00:00:00	\N	\N	\N	\N	14	SRN	SRN2602001	\N	PPCC_Goods Receiving Notes	\N	Standard	Knowledge	K.Wilawan	2026-02-03	09:40:00	PO TD25120016 Line 11 เปิด PO มาด้วย Cost 152.29 และไม่เคยมีการแก้ไข Cost	\N	2026-02-06
976	ช่อง Ship Site ไม่ขึ้น DEFAULT ค่ะ	ขอสอบถามค่ะ Item : SDC-IR-MOSF1402 ลง SO ช่อง Ship Site ไม่ขึ้นค่ะส่งผลให้ตอน Ordershipping ไม่โชว์แต่รหัสอื่นขึ้น DEFAULT ปกติ\n**แก้ไขเบื้องต้น สามารถทำได้ แต่ ถ้าครั้งหน้าลง SO แล้วจะขึ้น Auto พอจะทำได้มั้ยคะ	medium	C	\N	15	2026-06-21 20:53:40.308448	2026-02-10 00:00:00	CO	2026-02-10 00:00:00	\N	\N	\N	\N	14	ADI	ADI2602002	\N	Customer Order	\N	Standard	Unidentified	K.Natthakan	2026-02-07	10:50:00	\N	\N	2026-02-12
977	ขอวิธีเปลี่ยนสถานะ PR จาก Converted เป็น Requested ค่ะ	Status : Converted\nแต่ PO ไม่ขึ้น ถ้าต้องการเปลี่ยนจาก Converted เป็น Requested มีวิธีแก้มั้ยคะ\n*เคสนี้ต้องการแก้ไข Ordered จาก 5 PC เป็น 10 PC ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.309956	2026-03-20 00:00:00	PR	2026-03-20 00:00:00	แก้ไข Status เป็น Requested	\N	\N	\N	14	ADI	ADI2603001	\N	PPCC_Purchase Orders Requisition Lines	\N	Standard	Unidentified	K.Natthakan	2026-03-18	09:35:00	\N	\N	2026-03-23
978	ช่วยทำให้ D1-JVT-N1WB-E51700-A-PIA-04 On hand เป็น 0	ช่วยทำให้ D1-JVT-N1WB-E51700-A-PIA-04 On hand เป็น 0	medium	C	\N	14	2026-06-21 20:53:40.311229	2026-03-27 00:00:00	Item	2026-03-27 00:00:00	Rebalance Item Qty On Hand	\N	\N	\N	14	ADI	ADI2603002	\N	Item Lot Locations	\N	Standard	Knowledge	K.Natthakan	2026-03-26	16:00:00	Material Transaction พบว่า Lot MO26020240D0304 เหลือของอยู่ที่ Location E-DC-FG จำนวน 2 PC ถูกต้องแล้ว	\N	2026-03-31
979	ช่วยแก้ไข EIV2603-0005 หน่วยหลังทศนิยม ให้เป็น 39,081.60 ให้หน่อยนะคะ	ช่วยแก้ไข EIV2603-0005 หน่วยหลังทศนิยม ให้เป็น 39,081.60 ให้หน่อยนะคะ	medium	C	\N	14	2026-06-21 20:53:40.312651	2026-04-03 00:00:00	AR	2026-04-03 00:00:00	Update Database	\N	\N	\N	14	ADI	ADI2604001	\N	Invoices, Debit and Credit Memos	\N	Customized	Opening Balance	Natty	2026-04-03	08:25:00	Diff ทศนิยม	\N	2026-04-08
980	EIV2604-0003 ช่วยแก้ไขหลังจุดทศนิยม เป็น 4,421.40 ให้หน่อยนะคะ	EIV2604-0003 ช่วยแก้ไขหลังจุดทศนิยม เป็น 4,421.40 ให้หน่อยนะคะ	medium	C	\N	14	2026-06-21 20:53:40.313901	2026-05-05 00:00:00	AR	2026-05-05 00:00:00	Update Database	\N	\N	\N	14	ADI	ADI2605001	\N	Invoices, Debit and Credit Memos	\N	Customized	Customized Bug	Natty	2026-05-04	14:55:00	\N	\N	2026-05-08
981	EIV2604-0006 ช่วยแก้ไขหลังจุดทศนิยมเป็น 1,109.00 ให้หน่อยนะคะ	EIV2604-0006 ช่วยแก้ไขหลังจุดทศนิยมเป็น 1,109.00 ให้หน่อยนะคะ	medium	C	\N	14	2026-06-21 20:53:40.315297	2026-05-05 00:00:00	AR	2026-05-05 00:00:00	Update Database	\N	\N	\N	14	ADI	ADI2605002	\N	Invoices, Debit and Credit Memos	\N	Customized	Customized Bug	Natty	2026-05-05	09:35:00	\N	\N	2026-05-08
988	ช่วยตรวจสอบ DIV2606-0193 ฝ่ายขายแจ้งว่าไม่ได้ Gen	ช่วยตรวจสอบ DIV2606-0193 ฝ่ายขายแจ้งว่าไม่ได้ Gen	medium	O	\N	14	2026-06-21 20:53:40.336147	2026-06-21 20:53:40.336147	AR	\N	\N	\N	\N	\N	14	ADI	ADI2606003	\N	Invoices Debit and Credit Memos	\N	Standard	Technical	K.Natthakan	2026-06-16	14:45:00	Invoice DIV2606-0193 ตั้งหนี้มาจาก DO DO2300008993 ซึ่งใน DO DO2300008993 มี 2 Seq  โดย Seq #1 ถูกตั้งหนี้ไปด้วย DIV2412-0137 และหลังจาก Post DO Seq #1 ไปแล้วมีการมาสร้าง Seq #5 ด้วย CO SO67001250 Line #3 Release #6 ในภายหลัง รายการ Seq #5 จึงยังไม่ถูกนำไปตั้งหนี้ และวันนี้ เวลา 08:49 น. User มีการ Post DO แต่ใส่เงื่อนไขเฉพาะ DO Ending DO2500008248 ระบบจึงกวาด DO ที่ยังไม่ได้ตั้งหนี้มาตั้งหนี้	\N	2026-06-19
982	สอบถามค่ะ	จะเช็คว่า invoice ไหนยังไม่วางบิล ดูที่หน้าไหนได้คะ	medium	C	\N	15	2026-06-21 20:53:40.316779	2026-05-18 00:00:00	AR	2026-05-18 00:00:00	\N	\N	\N	\N	14	ADI	ADI2605003	\N	A/R Billing Status Report	\N	Localized	Knowledge	K.Tarn	2026-05-14	13:15:00	\N	\N	2026-05-19
983	ทำไมเรียก report มาแล้ว ของ CMW มี tobe billing  แต่พอจะกดวางบิล ถึงไม่มีขึ้นคะ	ทำไมเรียก report มาแล้ว ของ CMW มี tobe billing \nแต่พอจะกดวางบิล ถึงไม่มีขึ้นคะ	medium	C	\N	14	2026-06-21 20:53:40.317906	2026-05-18 00:00:00	AR	2026-05-18 00:00:00	แก้ไขรายงาน	\N	\N	\N	14	ADI	ADI2605004	\N	PPCC_ARBilling	\N	Localized	PPCC Localized	K.Tarn	2026-05-14	14:00:00	รายงานแสดงผิด\n\nDCN2012-0020 ถูกนำไปทำ Billing BR2012000029\nDCN2302-0068 ถูกนำไปทำ Billing BR2302000026	\N	2026-05-19
984	เวลาทำ Payment มันจะต้องมาขึ้น billing ตรงนี้มั้ยคะ	เวลาทำ Payment มันจะต้องมาขึ้น billing ตรงนี้มั้ยคะมันขึ้นเฉพาะแค่หน้าที่ต้องกด Quick หรอคะ	medium	C	\N	15	2026-06-21 20:53:40.319091	2026-05-18 00:00:00	AR	2026-05-18 00:00:00	เปลี่ยน Status เป็น Complete	\N	\N	\N	14	ADI	ADI2605005	\N	PPCC_A/R Payments	\N	Localized	Knowledge	K.Tarn	2026-05-15	07:05:00	Billing BR2412000041 มี Statu เป็น Open	\N	2026-05-20
985	ช่วยตรวจสอบการคำนวณ %A ใน ERP ให้หน่อยค่ะ	Could you please check %A Please find the attachment	medium	C	\N	14	2026-06-21 20:53:40.326296	2026-05-28 00:00:00	PS	2026-05-28 00:00:00	\N	\N	\N	\N	14	ADI	ADI2605006	\N	PPCC_DailyProductionData	\N	Customized	Knowledge	K.Natthakan	2026-05-27	14:10:00	จากการตรวจสอบสูตรคำนวณ %A มาจาก ((operating-(pnt+aut))/(operating-pnt))*100\r\noperating 8 ชั่วโมง\r\npnt 1.75 ชั่วโมง\r\naut 0.5 ชั่วโมง\r\n\r\n(((8*60)-((1.75*60)+(0.5*60)))/((8*60)-(1.75*60)))*100 = 92	\N	2026-06-01
987	ช่วยแก้ไข Location ให้เป็น B-CNC-FG ให้หน่อยนะคะ	ช่วยแก้ไข Location ให้เป็น B-CNC-FG ให้หน่อยนะคะ	medium	C	\N	17	2026-06-21 20:53:40.33405	2026-06-15 00:00:00	Item	2026-06-15 00:00:00	\N	\N	\N	\N	14	ADI	ADI2606002	\N	Item Lot Locations	\N	Standard	Human Error	Natty	2026-06-12	08:35:00	\N	\N	2026-06-17
1067	PR Approval Request -- System Error : Unit price is incorrect	PR line 2.17 But approve page show 2.00	medium	C	\N	22	2026-06-21 20:53:40.440897	2026-03-16 00:00:00	PR	2026-03-16 00:00:00	\N	\N	\N	\N	14	HHT	HHT2603003	\N	PPCC_Purchase Orders Requisition Approval	\N	Customized	Customized Bug	K.Tongty	2026-03-13	12:25:00	ไม่ได้เก็บค่าเศษทศนิยม	\N	2026-03-18
1113	รบกวนช่วยเช็คให้หน่อยค่ะ	รบกวนช่วยเช็คให้หน่อยค่ะ \n1.ต้องออกอินวอย Part no,Q'ty, CO ตามในรูปแรกของหน้า order line\n2.พอเข้าไป Pre_invoice มันขึ้นจำนวน line ซ้ำ รวมถึงเมื่อเช็คกับทาง DL ขึ้นยอดในการจัดส่งซ้ำเช่นกันเหมือนในหน้า Pre_ preinvoice \nต้องแก้ไขอย่างไรบ้างคะ	medium	C	\N	14	2026-06-21 20:53:40.48667	2026-02-04 00:00:00	AR	2026-02-04 00:00:00	ลบ CO Line 2,3,4 ออกจากระบบ	\N	\N	\N	14	SRN	SRN2602002	\N	PPCC_Pre Invoice	\N	Customized	Human Error	K.Chompupan	2026-02-03	10:45:00	Line 2,3,4 ข้อมูล Cust PO ที่ Tab Order Detail เป็นค่าว่าง จึงทำให้เมื่อกดปุ่ม Lines มาจาก PPCC_Customer Orders ข้อมูลจึงไม่แสดงเนื่องจากติดเงื่อนไขที่หน้าจอ	\N	2026-02-09
989	ช่วยแก้ให้ด้วยครับ	กดปุ่ม Generate แล้ว Error The root transaction wanted to commit, but transaction aborted	medium	C	\N	14	2026-06-21 20:53:40.338687	2026-04-03 00:00:00	PO	2026-04-03 00:00:00	รวบ PO DL26030053 Line #4 ให้เหลือ 1 GRN Line	\N	\N	\N	14	ART	ART2604001	\N	Generate A/P Transactions	\N	Standard	Standard Bug	K.Suwat	2026-04-02	08:15:00	เกิดจากสร้างรายการ PO DL26030053 Line #4 ใน GRN RL26030644 แยกเป็น 6 Line	\N	2026-04-08
990	Generate Voucher ไม่ได้	Generate Voucher ไม่ได้ Error \n\n[Generate] was not successful\ndifference is 84000.00000000	medium	C	\N	14	2026-06-21 20:53:40.34119	2026-04-03 00:00:00	PO	2026-04-03 00:00:00	User ต้องติ๊กรายการ PO IL26010006 Line 2 ออก 1 รายการ เนื่องจากข้อมูลในตารางนี้ไม่มียอด Qty -100 จึงทำให้ยอดเงินไม่ตรง	\N	\N	\N	14	ART	ART2604002	\N	Generate A/P Transactions	\N	Standard	Human Error	K.Suwat	2026-04-02	16:05:00	ยอด Material ไม่ตรงกับยอดเงินที่เลือกที่ Tab PO Selection	\N	2026-04-08
991	เนื่องจาก หน้ารายงาน Fixed Assef Generate Depreciatio Calculation ไม่พบรายการที่คี่ข้อมูล รายละเอียดปัญหาตามไฟล์แนบค่ะ	เนื่องจากจะทำการปิดงบเดือน มี.ค.  รบกวนตอบกลับด้วยนะคะ\n\nสอบถามข้อมูล การบันทึกบัญชีเกี่ยวกับทรัพย์สินค่ะ\n\nเนื่องจาก หน้ารายงาน  Fixed Assef Generate Depreciatio Calculation ไม่พบรายการที่คี่ข้อมูล  รายละเอียดปัญหาตามไฟล์แนบค่ะ	medium	C	\N	14	2026-06-21 20:53:40.342686	2026-04-08 00:00:00	FA	2026-04-08 00:00:00	ทำ Fixed Asset Generate Depreciation Calculation และให้ User สอบข้อมูล Curr Period Depr	\N	\N	\N	14	ART	ART2604003	\N	Fixed Assef Generate Depreciatio Calculation	\N	Standard	Human Error	ASP	2026-04-06	16:10:00	ข้อมูล Curr Period Depr ยังไม่ถูกคำนวณ	\N	2026-04-10
992	รายงานผลไม่ได้ครับ	รายงานผลไม่ได้ครับ	medium	C	\N	18	2026-06-21 20:53:40.344426	2026-04-08 00:00:00	PS	2026-04-08 00:00:00	แก้ไข  Total Run Hours (Lbr) ที่หน้า Work Center ให้เป็น 0	\N	\N	\N	14	ART	ART2604004	\N	ProductionScheduleCompleteTransactions_PK	\N	Customized	Knowledge	K.เอี้ยม	2026-04-06	09:15:00	\N	\N	2026-04-13
994	เรียก Biling ไม่ได้	Inv. AC2605003 Post แล้ว มีข้อมูลใน artran, jounal(AR Dist)แล้ว แต่เรียก  Biling ไม่ได้ครับ	medium	C	\N	15	2026-06-21 20:53:40.346909	2026-05-18 00:00:00	AR	2026-05-18 00:00:00	กด New > ลบเงื่อนไข Invoice Date ให้เป็นค่าว่าง > ใส่ CO00086 ที่เงื่อนไข Customer ข้อมูลจะแสดงขึ้นมาให้	\N	\N	\N	14	ART	ART2605001	\N	2P2C_ARBilling	\N	Customized	Knowledge	K.เอี้ยม	2026-05-13	08:45:00	\N	\N	2026-05-18
1007	สอบถามครับ Account period บน UAT มันไม่ให้สร้างใหม่ ใช่ไหมครับ	ผมสร้างแล้ว มัน บอก The transaction ended in the tigger. The batch has aborted.	medium	O	\N	14	2026-06-21 20:53:40.368184	2026-06-21 20:53:40.368184	MAS	\N	\N	\N	\N	\N	\N	CCH	CCH2606001	\N	Account period	\N	Standard	Technical	K.เปี๊ยก	2026-06-14	15:25:00	\N	\N	2026-06-18
1036	รบกวนตรวจสอบ GJ2601000058	รบกวนตรวจสอบ  GJ2601000058  เนื่องจาก Post แล้วไม่เข้าหน้า G/L ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.405524	2026-02-23 00:00:00	GL	2026-02-23 00:00:00	Insert ข้อมูลเข้า journal และลบข้อมูลออกจากตาราง tmp_mass_journal	\N	\N	\N	14	CNI	CNI2602013	\N	G/L Posted Transactions	\N	Standard	Standard Bug	Accounting	2026-02-20	13:35:00	\N	\N	2026-02-25
996	สามารถรู้ User ที่ทำได้จากหน้าไหนได้บ้างครับ	สามารถรู้ User ที่ทำได้จากหน้าไหนได้บ้างครับ	medium	C	\N	14	2026-06-21 20:53:40.350873	2026-01-14 00:00:00	IC	2026-01-14 00:00:00	\N	\N	\N	\N	14	CCH	CCH2601001	\N	PPCC_IssueRequisition	\N	Customized	Customized Bug	K. ธีรภัทร	2026-01-12	15:30:00	ปกติ User ที่สร้างรายการจะแสดงที่ Field Created By แต่จากที่ Query ดูผ่าน Database พบว่ารายการที่แจ้งปัญหามาลง CreatedBy เป็นค่า NULL	\N	2026-01-15
997	ตั้งหนี้ จาก C22 โพสไม่มาฝั่ง CCH ค่ะ	รบกวนดู AP ให้หน่อยนะคะ เราตั้งหนี้จาก C22 จะโพสมา CCH โพสแล้วไม่มาค่ะ หลายเจ้าเลยค่ะ หายไปเลยค่ะ	medium	C	\N	14	2026-06-21 20:53:40.352369	2026-01-28 00:00:00	AP	2026-01-28 00:00:00	Restart Service Infor Framework Inbound Bus Service, Infor Framework Replication Queue Listener, Infor Framework Replicator	\N	\N	\N	14	CCH	CCH2601002	\N	A/P Quick Payment Application	\N	Tech	Technical	K.Pornnipa	2026-01-27	09:40:00	\N	\N	2026-01-30
1114	ช่วยตรวจสอบให้ด้วยคะ เกิดจากสาเหตุอะไรคะ	ช่วยตรวจสอบให้ด้วยคะ เกิดจากสาเหตุอะไรคะและช่วยแก้ไขให้ด้วยคะ\n	medium	C	\N	14	2026-06-21 20:53:40.494237	2026-02-04 00:00:00	Oth	2026-02-04 00:00:00	ลบ Tag JOB260000001 ออกและแก้ไข Qty = 10 ที่ Tag JOB260443611	\N	\N	\N	14	SRN	SRN2602003	\N	PPCC_Print Production Tag	\N	Customized	Human Error	K.Phatphonrung	2026-02-03	14:25:00	คาดว่าเกิดจากกด Print เบิ้ล เนื่องจากข้อมูล Tag Transaction ของ JOB IF00006378 ลงเบิ้ล	\N	2026-02-09
1115	รบกวนช่วยตรวจสอบ INV No. E260203/0002 ใบนี้ให้หน่อยค่ะ	รบกวนช่วยตรวจสอบ INV No. E260203/0002 ใบนี้ให้หน่อยค่ะ \n \nเนื่องจากในระบบ ถูกตัด Stock ไปแล้ว แต่ในระบบ Create Shipping List No. ไม่พบข้อมูล  หมายเลข Pick List P260203052 คะ \n	medium	C	\N	23	2026-06-21 20:53:40.495258	2026-02-04 00:00:00	Automation	2026-02-04 00:00:00	Insert Ship Lable และ Update Status Tag	\N	\N	\N	14	SRN	SRN2602004	\N	Create Shipping List No	\N	Customized	Customized Bug	K.Jintana	2026-02-03	09:05:00	\N	\N	2026-02-09
1117	JOB DB00010617  POST  ไม่ได้  40  Pcs.   ค่ะ รบกวนตรวจสอบให้หน่อยค่ะ	JOB DB00010617  POST  ไม่ได้  40  Pcs.   ค่ะ รบกวนตรวจสอบให้หน่อยค่ะ	medium	C	\N	23	2026-06-21 20:53:40.496758	2026-02-18 00:00:00	Automation	2026-02-18 00:00:00	User Print Tag เพิ่มอีก 2 ใบ ใบละ 20	\N	\N	\N	14	SRN	SRN2602006	\N	Unposted Job Transactions	\N	Customized	Knowledge	Thidaporn	2026-02-17	08:55:00	Tag ของ Job DB00010617 มี 6 ใบ ใบละ 20 ทั้งหมดจึงเป็น 120 แต่ Qty Released ของ Job เป็น 160 จึงทำให้ Tag ของ Job DB00010617 ขาดไปอีก 2 ใบ	\N	2026-02-20
1121	รบกวนลบเลขที่อินวอย D260223/0005	เนื่องจากมีการยกเลิกการจัดส่งงาน แต่ทางเราออกอินวอยไปแล้ว และไม่อยากยกเลิก\nทางเราจึงอยากรบกวนให้ทาง PPCC ช่วยลบเลขที่ตามด้านล่างให้ได้หรือไม่ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.534598	2026-02-26 00:00:00	AR	2026-02-26 00:00:00	ลบข้อมูลออกจากตาราง do_hdr และแก้ไข Last Invoice Number ที่หน้าจอ Invoice Debit and Creditt Memo Sequences	\N	\N	\N	14	SRN	SRN2602011	\N	PPCC_Pre Invoice	\N	Customized	Human Error	K.Panarath	2026-02-23	16:35:00	\N	\N	2026-02-26
1122	รบกวนลบข้อมูลหน้า PPCC_PreInvoice Date 02/03/2026	ตามที่ฝ่ายบัญชีได้พูดคุยไว้เบื้องต้น รบกวนลบ Invoice ของลูกค้า Honda (Prachinburi) วันที่ 02/03/2026 ให้หน่อยค่ะ\nInvoice No : D260302/0003 - D260302/0016	medium	C	\N	14	2026-06-21 20:53:40.535334	2026-02-26 00:00:00	AR	2026-02-26 00:00:00	ลบข้อมูล Pre Invoice D260302/0003- D260302/0016 ที่ตาราง do_hdr และ Update Last Invoice ที่ Invoice Sequence เป็น D260302/0002	\N	\N	\N	14	SRN	SRN2602012	\N	PPCC_Pre Invoice	\N	Customized	Human Error	K.Siriwan	2026-02-26	16:00:00	\N	\N	2026-03-03
999	CO Line จำนวน บรรทัด ไม่สัมพันธ์ กับ Invoice	User Key ไป 7 รายการ แต่ DO ออก เป็น 8 โดยแตก รายการ ที่ วงไว้ ในรูป เป็น 2 รายการ ไม่ทราบสาเหตุ ว่าแตกทำไม รบกวน ช่วยเช็ค ให้ที ครับ	medium	C	\N	14	2026-06-21 20:53:40.355446	2026-02-09 00:00:00	DO	2026-02-09 00:00:00	\N	\N	\N	\N	14	CCH	CCH2602002	\N	PPCC_Delivery Orders	\N	Standard	Knowledge	K.Paisan	2026-02-04	11:50:00	CO CN69020012 Line #5 Qty Ordered = 2 CRTและมีการแบ่งตัด Stock ครั้งละ 1 CRT จึงทำให้เกิด Transaction 2 รายการ ซึ่ง DO จะดึงข้อมูลตาม Transaction ที่ตัด Stock	\N	2026-02-09
1027	INV690209017 รบกวน ลบ INV นี้ ให้หน่อยค่ะ	เปิดค่าแม่พิมพ์ ต้องการนำไปใช้ เปิดขายงานปกติ ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.396193	2026-02-09 00:00:00	AR	2026-02-09 00:00:00	ลบ Invoice INV690209017 และแก้ไข Pre Invoice No, INV690209019 ให้เป็น INV690209017	\N	\N	\N	14	CNI	CNI2602004	\N	Invoices, Debit and Credit Memos	\N	Customized	Human Error	K.Kung	2026-02-09	08:35:00	\N	\N	2026-02-12
1125	รบกวนตรวจสอบ APV 38058	เนื่องจากทางเราได้มีการ Generate ตั้งหนี้ ใส่ข้อมูล และเลือก Budgets 613022/ Transportation/Express way ตามปกติ ซึ่งยังไม่ได้ทำการ Post แต่ทำไม Budget ถึงไปอยู่ที่ Actual use คะ (โดยปกติน่าจะอยู่ที่ Allocated on Oder) รายละเอียดตามภาพด้านล่างค่ะ	medium	C	\N	14	2026-06-21 20:53:40.540305	2026-03-04 00:00:00	BG	2026-03-04 00:00:00	ลบข้อมูลที่ตาราง ppcc_budget_actdetail	\N	\N	\N	14	SRN	SRN2603001	\N	PPCC_Budget Actual Used Detail	\N	Customized	Customized Bug	Songapson	2026-03-04	16:00:00	เกิดจากมีการ Post Voucher โดยไม่ใส่เงื่อนไขจึงทำให้ Voucher 38058 ถูก Task PPCC_UpdateBudgetControlAllSp ดึงไปทำรายการด้วย	\N	2026-03-09
1126	Reconfirm เรื่องการเปลี่ยนแปลงราคา เนื่องจากลูกค้ามีการเปลี่ยนราคา หลังจากที่ Load order	รบกวน Reconfirm เรื่องการเปลี่ยนแปลงราคา เนื่องจากลูกค้ามีการเปลี่ยนราคา หลังจากที่ Load order แล้ว โดย MK เพิ่มราคาใหม่ในระบบและใส่เงื่อนไข Use Invoice Date แต่ราคาใน Inv ยังเป็นราคาเดิมค่ะ\n\nกรณีนี้ทาง SRN ต้องแก้ไขอย่างไรค่ะ Reprice ราคาได้หรือไม่ค่ะ ช่วงนี้ลูกค้าเลื่อนออเดอร์ค่ะ	medium	C	\N	15	2026-06-21 20:53:40.542196	2026-03-09 00:00:00	CU	2026-03-09 00:00:00	หากมีการ Load Customer Order เข้าระบบแล้ว หากมาการแก้ไขราคาใหม่ สิ่งที่ต้องทำก่อนออก Invoice คือ  1. แก้ไขราคาที่หน้าจอ PPCC_Customer Contract price  2. ทำการอัพเดตราคาใหม่ มาที่ PPCC_Customer Order Line โดยใช้หน้าจอ PPCC_Customer Order Reprice  3. ดึงข้อมูล PPCC_Customer Order Line ไปสร้างเอกสาร Invoice     * Use Invoice Date , Use Order Date ใช้เพื่อกำหนดว่าจะให้ระบบดึงราคาขายที่มีการกำหนด Effective Date ไว้นั้น ตามวันที่ส่งสินค้า (Due Date) หรือวันที่คีย์ Order (วันที่ CO)	\N	\N	\N	14	SRN	SRN2603002	\N	PPCC_Customer Order Reprice	\N	Customized	Knowledge	K.Jutathip	2026-03-06	14:15:00	\N	\N	2026-03-12
1129	แจ้งปัญหา ข้อมูลไม่ขึ้น ใน Ship Label  ค่ะ	แจ้งปัญหา ข้อมูลไม่ขึ้น ใน Ship Label  ค่ะ	medium	C	\N	23	2026-06-21 20:53:40.546014	2026-03-16 00:00:00	Automation	2026-03-16 00:00:00	แจ้ง User ให้ Reprint ด้วย Ship Label SB260316043	\N	\N	\N	14	SRN	SRN2603005	\N	Shipping List Detail	\N	Customized	Customized Bug	K.Jintana	2026-03-16	13:30:00	Tag JOB260447379 ในระบบเก็บ Ship Label เป็น SB260316043	\N	2026-03-19
1130	แจ้งเจอปัญหา  หน้า รวบ Pick List  เจอ Pick List หาย ค่ะ ข้อมูล ไม่ขึ้นในรวบ ค่ะ  รงบรวนกวน ตรวจสอบให้หน่อยค่ะ	แจ้งเจอปัญหา  หน้า รวบ Pick List  เจอ Pick List หาย ค่ะ ข้อมูล ไม่ขึ้นในรวบ ค่ะ  รงบรวนกวน ตรวจสอบให้หน่อยค่ะ	medium	C	\N	23	2026-06-21 20:53:40.546728	2026-03-17 00:00:00	Automation	2026-03-17 00:00:00	Insert ข้อมูล Pick List P260317042 Tag JOB260451059 จะเป็น ship label  SB260317077 และ Tag JOB260451058 จะเป็น ship label  SB260317076, Pick List P260318016 Tag JOB260448920 จะเป็น ship label SB260317079 และ Tag JOB260448083 จะเป็น ship label SB260317078	\N	\N	\N	14	SRN	SRN2603006	\N	Scan Order PickList	\N	Customized	Human Error	K.Jintana	2026-03-17	14:05:00	หากทำการกดปุ่ม process แล้วรบกวนให้รอจนกว่าจะมีข้อความขึ้นแจ้งว่าทำรายการสำเร็จนะคะ หากกด back กลับออกระหว่างระบบทำรายการ ระบบจะลบข้อมูล tag และ shiplabel ที่แสกนไว้ทั้งหมดทิ้งไป	\N	2026-03-20
1001	INV COSOLIDATED INVOICE GENERATION ไม่ได้	กบกวนดู inv. ให้ด้วยนะคะ ทางเรา Consolidated Invoice Generation (C22)  ไม่ได้ค่ะ\n\nJ6901201  1,632.00  114.24  1,746.24  VAT7%	medium	C	\N	14	2026-06-21 20:53:40.359229	2026-03-16 00:00:00	DO	2026-03-16 00:00:00	คีย์ค่า DO Invoice กับ Invoice Freq. ตามที่กำหนดไว้ที่หน้าจอ Customers	\N	\N	\N	14	CCH	CCH2603002	\N	Consolidate Invoice Generations	\N	Customized	Customized Bug	K.Pornnipa	2026-03-12	11:05:00	Do Invoice กับ Invoice Freq. เป็นค่าว่าง	\N	2026-03-17
1038	รบกวนตรวจสอบรายการ GJ2602000039	รบกวนตรวจสอบรายการ GJ2602000039   เนื่องจากใน General Ledger By Account Report ไม่โชว์รายงาน\nในขณะที่ post ปกติค่ะ	medium	C	\N	14	2026-06-21 20:53:40.407326	2026-03-16 00:00:00	GL	2026-03-16 00:00:00	\N	\N	\N	\N	14	CNI	CNI2603001	\N	General Ledger By Account Report	\N	Localized	PPCC Localized	Narin	2026-03-13	11:40:00	\N	\N	2026-03-18
1131	รบกวนช่วยตรวจสอบให้หน่อยค่ะ  ข้อมูล INV. ไม่ขึ้น ค่ะ ใบ ที่ 30	รบกวนช่วยตรวจสอบให้หน่อยค่ะ  ข้อมูล INV. ไม่ขึ้น ค่ะ ใบ ที่ 30 ข้อมูลดังกล่าว เคยถูกทำ Pick List แล้ว 1 รอบ แล้วทำการ Cancel แล้ว  ข้อมูลใหม่ก็นขึึ้นแทน ข้อมูลเก่า แล้วค่ะ แต่ พอกลับมาทำอีกรอบ ข้อมูลไม่ขึ้น หาสาเหตุไม่เจอ	medium	C	\N	23	2026-06-21 20:53:40.547394	2026-03-17 00:00:00	DO	2026-03-17 00:00:00	แก้ไข Status ของ  Pick List P260216068 เป็น Cancel	\N	\N	\N	14	SRN	SRN2603007	\N	PPCC_Order Pick List	\N	Customized	Knowledge	K.Jintana	2026-03-17	16:00:00	Pre Invoice ถูกนำไปใช้อีก Pick List P260216068 และ Status ของ Pick List เป็น Completed จึงทำให้ไม่สามารถเรียกข้อมูล Pre Invoice ที่ Pick List P260319045 ได้	\N	2026-03-20
1132	รบกวนแก้ไขเลขที่เอกสาร ใบแจ้งหนี้	เนื่องจากมีการตั้งหนี้หน้าตรง และมีการลบข้อมูลก่อนหน้าทำให้เลขที่รันเลขที่ใบแจ้งหนี้ข้าม รบกวน PPCC แก้เลขที่ใบแจ้งหนี้ให้หน่อยนะคะ Customer : OEPE001 :  EPE PACKAGING (THAILAND) CO., LTD.\n\nแก้ไขจากเลขที่  N2603/000002  เป็น  N2603/000001 ค่ะ รายละเอียดตามรูปข้างล่างค่ะ	medium	C	\N	14	2026-06-21 20:53:40.548062	2026-03-20 00:00:00	AR	2026-03-20 00:00:00	Update Database	\N	\N	\N	14	SRN	SRN2603008	\N	PPCC_InvoicesDebitandCreditMemos	\N	Customized	Human Error	K.Panita	2026-03-18	11:55:00	\N	\N	2026-03-23
1145	รบกวนตรวจสอบรายการตั้งหนี้	เนื่องจากทางเราได้มีการ Generate ตั้งหนี้ ใส่ข้อมูล และเลือก Budgets 613022/ Transportation/Express way ตามปกติ ซึ่งยังไม่ได้ทำการ Post แต่ทำไม Budget ถึงไปอยู่ที่ Actual use คะ (โดยปกติน่าจะอยู่ที่ Allocated on Oder) รายละเอียดตามภาพด้านล่างค่ะ	medium	C	\N	14	2026-06-21 20:53:40.583799	2026-05-05 00:00:00	BG	2026-05-05 00:00:00	ลบข้อมูลที่ตาราง ppcc_budget_actdetail	\N	\N	\N	14	SRN	SRN2604005	\N	PPCC_Budget Actual Used Detail	\N	Customized	Customized Bug	Songapson	2026-04-30	14:25:00	เกิดจากมีการ Post Voucher โดยไม่ใส่เงื่อนไขจึงทำให้ Voucher 38058 ถูก Task PPCC_UpdateBudgetControlAllSp ดึงไปทำรายการด้วย	\N	2026-05-05
1136	รบกวนเปลี่ยน U/M จาก MTR เป็น PCS	รบกวนเปลี่ยน U/M จาก MTR เป็น PCS ให้หน่อยได้ไหมค่ะ\nเนื่องจากมีการใส่หน่วยผิดค่ะ RMNEED00011 ,RMNEED00012 \nRMNEED00011 จากการตรวจสอบการใช้งานยังไม่มีเปิด JOB,PO และผูก BOM ค่ะ แต่ไม่สามารถแก้ไขได้ \nRMNEED00012 จากการตรวจสอบการมีเปิด JOB ไปแล้ว 3 JOB ตั้งแต่ปี 2025 (ซึ่งอยู่ในช่วงทดลองใส่หน่วยผิดตั้งแต่ตอนนั้นค่ะ)\nช่วงนี้กำลังจะ Mass production จึงรบกวนให้ช่วยแก้ไขให้หน่อยค่ะ	medium	C	\N	18	2026-06-21 20:53:40.575536	2026-03-27 00:00:00	IC	2026-03-27 00:00:00	ทำการ Roll Cost ใหม่ Item RMNEED00011, RMNEED00012 ที่ระดับ Standard Material จะหายไปจากนั้นค่อยทำการเปลี่ยนแปลง U/M	\N	\N	\N	14	SRN	SRN2603013	\N	PPCC_Items	\N	Standard	Knowledge	K.Jutathip	2026-03-24	13:25:00	RMNEED00011, RMNEED00012 มีการกำหนดไว้ที่ระดับ Standard Material	\N	2026-03-30
1002	User NIPAPORN เปิดบิลไม่ได้	User : nioaporn เปิด บิล ไม่ไดเ้ เป็น อยู๋คนเดียว รบกวน ช่วย แก้ไขด้วยครับ	medium	C	\N	14	2026-06-21 20:53:40.360714	2026-03-16 00:00:00	DO	2026-03-16 00:00:00	เบื้องต้นลบ Form User nipaporn ออก	\N	\N	\N	14	CCH	CCH2603003	\N	PPCC_Delivery Order Line Sequences	\N	Customized	Knowledge	K.Paisan	2026-03-16	10:35:00	ข้อมูล Field Customer ไม่มีข้อมูล จึงทำให้ User เจอแจ้งเตือนว่า Order is not a valid เนื่องจากข้อมูล Field Order ถูกดึงมาด้วยเงื่อนไข Customer	\N	2026-03-19
1003	แก้ไขปัญหา	ต้องการลบขั้นตอนที่ 21 ออกไม่ทราบว่ามันติดอะไรถึงไม่ยอมให้ลบ	medium	C	\N	18	2026-06-21 20:53:40.362475	2026-03-27 00:00:00	SFC	2026-03-27 00:00:00	ถอยของจำนวนชั่วโมง 0.003 เพื่อให้ครบ 0.333	\N	\N	\N	14	CCH	CCH2603004	\N	Job Operations	\N	Standard	Knowledge	K. ธีรภัทร	2026-03-24	15:15:00	มีการรายงานผลของชั่วโมงอยู่ที่ 0.333 แต่ว่ามีการรายงานถอยของจำนวนชั่วโมงอยู่ที่ -0.330	\N	2026-03-30
1006	หน้า  PPCC_DeliveryOrders เข้าไม่ได้	ช่วยดู หน้า PPCC_DeliveryOrders ให้ทีครับ เปิด ไม่ได้  เมื่อวาน ผมมีเพิ่ม UET ไป 5 Fields วันนี้มาเปิดไม่ได้ รบกวนด้วยครับ พอดี user จะเปิด บิล	medium	C	\N	14	2026-06-21 20:53:40.367415	2026-06-02 00:00:00	DO	2026-06-02 00:00:00	ลบ UET Uf_dohdr_ReciAmnt ออกและสร้างใหม่ด้วยชื่อเดิม เปลี่ยน Data Type เป็น Decimal(23,8)	\N	\N	\N	14	CCH	CCH2605002	\N	PPCC_Delivery Orders	\N	Customized	Customized Bug By Customer	K.Paisan	2026-05-29	08:40:00	UET Uf_dohdr_ReciAmnt ใช้ Data Type money	\N	2026-06-03
1137	Reconfirm เรื่องการเปลี่ยนแปลงราคา เนื่องจากลูกค้ามีการเปลี่ยนราคา หลังจากที่ Load order	ตามที่เคยแจ้งไว้ว่าลูกค้า Honda มีเปลี่ยนแปลงราคา E-Date 1 Mar’2026 : และมีเลื่อน Order เดือน Feb’2026 มาจัดส่งในเดือน Mar’2026\n\nส่งผลให้ Invoice วันที่ 11-21 Mar’2026 มีราคาที่ไม่ตรงกับของลูกค้าเพิ่มค่ะ เพราะว่าเป็น Order date เดือน Feb’2026 รายการตามไฟล์แนบ\n\nซึ่ง SRN จะต้องแก้ไขราคาใน Invoice ของที่ออกไปแล้ว ซึ่งเป็น Status Filled เพื่อ Reprint ให้ลูกค้า ที่ต้องรบกวนขอความช่วยเหลืออีกครั้งค่ะ\n\n→ รบกวนขอให้ PPCC ช่วย Support การแก้ไขราคาใน Excel file sheet : Invoice Price errors (Reprint) ให้หน่อย ซึ่งเราได้ List INV. มาให้แล้วค่ะ	medium	C	\N	14	2026-06-21 20:53:40.576276	2026-03-27 00:00:00	AR	2026-03-27 00:00:00	Update Price ที่ Customer Order Lines, Order Shipments, Pre Invoice	\N	\N	\N	14	SRN	SRN2603014	\N	PPCC_Pre Invoice	\N	Customized	Unidentified	K.Duangporn	2026-03-25	10:40:00	\N	\N	2026-03-30
1152	ทำไมเลข Order No หน้า Report ไม่แสดงข้อมูลเลข Order No	สอบถามหน่อยค่ะ ทำไมเลข Order No หน้า Report ไม่แสดงข้อมูลเลข Order No ค่ะ แต่ข้อมูล Tag แสดง ค่ะ  ใช้หน้านี้เป็นหน้าดึงข้อมูล รบกวนช่วยตรวจสอบให้หน่อยนะคะ	medium	C	\N	23	2026-06-21 20:53:40.588984	2026-05-28 00:00:00	DO	2026-05-28 00:00:00	แก้ไขข้อมูล Plan Ref No, ของ Ship To 1 เป็น Customer PO	\N	\N	\N	14	SRN	SRN2605007	\N	PPCC_PrintDailyDeliveryReport_BK20190807	\N	Customized	Customized Bug	K.Jintana	2026-05-28	08:55:00	ข้อมูล Plan Ref No, ของ Ship To 1 เป็นค่าว่าง	\N	2026-06-02
1139	รบกวน ช่วยตรวจสอบ Shipping List Data  SL26032605,SL26032606  Ship Label ในระบบ เบิ้ล ค่ะ  ทำให้ไม่สามารถ ยิงขาออกได้ค่ะ	SL26032605  งานจริง C18  มี 9 Pallet ในระบบ มี10  ......   SL26032606 งานจริง C17  มี 7 Pallet ในระบบ มี 8	medium	C	\N	23	2026-06-21 20:53:40.577769	2026-04-01 00:00:00	Automation	2026-04-01 00:00:00	\N	\N	\N	\N	14	SRN	SRN2603016	\N	PPCC_Shipping List Data	\N	Customized	Customized Bug	K.Jintana	2026-03-30	15:25:00	pick list ตอนรวบเบิ้ล ทำให้ข้อมูล 1 ใน pick list ที่ทำการรวบข้อมูลเลยเบิ้ล	\N	2026-04-02
1063	e-PPCC_Journal Entries มันจำกัดสิทธิ์ได้มั้ยจ้ะ	เช่น ต้อง แค่ โพสได้ แต่ new and save ไม่ได้\r\nพี่นก new and save ได้ แต่โพสไม่ได้	medium	O	\N	15	2026-06-21 20:53:40.436438	2026-06-21 20:53:40.436438	GL	\N	จำกัดสิทธิ์หน้าจอได้ ปกติ post กับสร้างมันใช้คนละหน้าจออยู่แล้วค่ะ	\N	\N	\N	\N	HHT	HHT2602001	\N	e-PPCC_Journal Entries	\N	Customized	Knowledge	K.Tongty	2026-02-04	11:01:00	\N	\N	2026-02-04
1008	PO Approve Check1 ไม่ไป	หน้า PPCC_ApprovePO user kridsada2 จะ Approve Check1->Check2  กด Process แล้ว ไม่มี ข้อมูล มาแสดง PO เลขที่ 6906000163 รบกวนช่วย ตรวจสอบ ให้ด้วยครับ	medium	C	\N	14	2026-06-21 20:53:40.36966	2026-06-16 00:00:00	PO	2026-06-16 00:00:00	Approve จาก Planned เป็น Check 1	\N	\N	\N	14	CCH	CCH2606002	\N	PPCC_ApprovePO	\N	Customized	Knowledge	K.Paisan	2026-06-15	10:00:00	PO 6906000163 ยังเป็น Status Approve = Planned อยู่	\N	2026-06-18
1065	ไม่เคยลบอะไรเลย ใน Currency  rates history หายไปเกลี้ยง	ไม่เคยลบอะไรเลย ใน Currency  rates history หายไปเกลี้ยง	medium	O	\N	15	2026-06-21 20:53:40.438319	2026-06-21 20:53:40.438319	AP	\N	\N	\N	\N	\N	\N	HHT	HHT2603001	\N	Currency  Rates	\N	Standard	Technical	K.Tongty	2026-03-04	10:20:00	ปกติหน้าจอนี้ไม่ได้ทำงานซับซ้อนอะไร เพิ่ม ลบ เก็บข้อมูลเพื่อนำไปใช้ต่อ	\N	2026-03-06
1009	รบกวนช่วยดูชุดนี้ให้หน่อยค่ะเนื่องจากโพสแล้วไม่โชว์ AR ค่ะ	รบกวนช่วยดูชุดนี้ให้หน่อยค่ะเนื่องจากโพสแล้วไม่โชว์ AR ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.370896	2026-01-06 00:00:00	AR	2026-01-06 00:00:00	ให้ User ทำการลบ Invoice INV681222025 แล้วทำใหม่	\N	\N	\N	14	CNI	CNI2601001	\N	PPCC_Pre-InvoicePostComfirm	\N	Customized	Knowledge	K.ทราย	2026-01-05	14:25:00	DO6811001503 ถูก Post ไปด้วย Invoice INV681223013 แล้ว	\N	2026-01-08
1010	รบกวนช่วยตรวจสอบให้ด้วยค่ะ part no, part name  หายไปค่ะ	รบกวนช่วยตรวจสอบให้ด้วยค่ะ part no, part name  หายไปค่ะ	medium	C	\N	15	2026-06-21 20:53:40.372116	2026-01-07 00:00:00	PO	2026-01-07 00:00:00	แก้ไข part no, part name	\N	\N	\N	14	CNI	CNI2601002	\N	Purchase Orders Lines	\N	Customized	Customized Bug By Customer	K.Ple	2026-01-07	09:20:00	\N	\N	2026-01-12
1016	รบกวนตรวจสอบให้ทีค่ะ	Scan Picklist เจอ Error string of binary data would be truncated	medium	C	\N	14	2026-06-21 20:53:40.380865	2026-01-09 00:00:00	Automation	2026-01-09 00:00:00	เพิ่มขนาดตัวอักษรของ Column cust_po  ในตาราง ppcc_ex_ordership_sum และ ppcc_ex_ordership_sum_process จาก 25 เป็น 50	\N	\N	\N	14	CNI	CNI2601008	\N	Order Shipping	\N	Customized	Customized Bug	K.Pimpa	2026-01-09	10:00:00	Cust PO มา 28 ตัวอักษร ตารางเราเก็บแค่ 25 ตัวอักษร	\N	2026-01-14
1018	ช่วยตรวจสอบให้หน่อยค่ะ ถอย ทศนิยม ค้ายอดค้างอยู่   0.0001ค่ะ ช่วยเอาออกให้ที	ช่วยตรวจสอบให้หน่อยค่ะ ถอย ทศนิยม ค้ายอดค้างอยู่ 0.0001ค่ะ ช่วยเอาออกให้ที	medium	C	\N	14	2026-06-21 20:53:40.383258	2026-01-14 00:00:00	PO	2026-01-14 00:00:00	เนื่องจากระบบบันทึก Adjustment ออกไป 0.00001275 ยอดใน Material Transaction จึงกลบกันเหลือ 0	\N	\N	\N	14	CNI	CNI2601010	\N	PPCC_Purchase Orders Lines	\N	Customized	Human Error	K.Pimpa	2026-01-13	14:40:00	User ถอยไม่ครบเนื่องจากตอนทำถอย User ถอยด้วยหน่วย UM ไม่ตรงกับตอนทำรับ	\N	2026-01-16
1020	อร ไป ship ก่อน ทำให้เปิด inv ไม่ได้รบกวนคืนค่า ให้หน่อยค่ะ	เป็นของ แม่พิมพ์ อร เปิด 50% แรกไปแล้ว ครั้งนี้ 50% หลัง แต่ อร กด ship ก่อน ก่อนที่จะเปิด inv ทำให้ เปิด inv ไม่ได้แล้วค่ะ	medium	C	\N	14	2026-06-21 20:53:40.385665	2026-01-19 00:00:00	CO	2026-01-19 00:00:00	ใช้ User WH ทำถอย	\N	\N	\N	14	CNI	CNI2601012	\N	Order Shipping	\N	Customized	Knowledge	K.Kung	2026-01-19	13:50:00	เนื่องจาก Lot 260119000000001 มีจำนวน 1 และถูกตัด Stock ไปครบแล้ว จึงทำให้ไม่มีข้อมูล Lot นี้ที่หน้าจอ Item Lot Locations เมื่อ User จะถอยเข้า Lot 260119000000001 ระบบจึงต้องสร้างรายการที่ Item Lot Locations แต่ User ที่ทำรายการในตอนแรกไม่มีสิทธิ์ดังกล่าวจึงทำให้ทำรายการไม่ได้	\N	2026-01-22
1021	PPCC_Print WIP Tag	Q'ty ไม่ออกค่ะปริ้น wip tag	medium	C	\N	14	2026-06-21 20:53:40.386838	2026-02-02 00:00:00	Oth	2026-02-02 00:00:00	Item ไม่ได้ติ๊ก Print WIP Tag และหน้า PPCC_Print WIP Tag ไม่ได้ใส่ Qty Per Tag	\N	\N	\N	14	CNI	CNI2601013	\N	Q'ty ไม่ออกค่ะปริ้น wip tag	\N	Customized	Human Error	K.Pimpa	2026-01-28	14:00:00	Item ไม่ได้ติ๊ก Print WIP Tag และหน้า PPCC_Print WIP Tag ไม่ได้ใส่ Qty Per Tag	\N	2026-02-03
1022	Purchase order  6901000665 ต้องการเปลี่ยน vendor จาก D095001  เป็น D096001 แต่ติดปัญหา เปลี่ยนไม่ได้ค่ะ	Purchase order  6901000665 ต้องการเปลี่ยน vendor จาก D095001  เป็น D096001 แต่ติดปัญหา เปลี่ยนไม่ได้ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.388077	2026-02-02 00:00:00	PO	2026-02-02 00:00:00	Update Database	\N	\N	\N	14	CNI	CNI2601014	\N	Purchase Orders	\N	Customized	Human Error	K.Ple	2026-01-29	11:15:00	PO เปิดด้วยสกุลเงิน THB ไปแล้ว ระบบจึงไม่ยอมให้เปลี่ยนไปใช้ Vendor ที่ไม่ใช่สกุลเงิน THB	\N	2026-02-03
1023	ตอนนี้ทุกวันอาทิตย์พบว่าหน้าเว็บ Post job ไม่ไปนะครับ เป็นมา 3 อาทิตย์ล่ะครับ ตอนนี้ ต้องมากดโพสท์มือในระบบ รบกวนเช็คให้หน่อยครับ	ตอนนี้ทุกวันอาทิตย์พบว่าหน้าเว็บ Post job ไม่ไปนะครับ เป็นมา 3 อาทิตย์ล่ะครับ ตอนนี้ ต้องมากดโพสท์มือในระบบ รบกวนเช็คให้หน่อยครับ	medium	C	\N	\N	2026-06-21 20:53:40.390399	2026-02-09 00:00:00	Technical	2026-02-09 00:00:00	\N	\N	\N	\N	14	CNI	CNI2601015	\N	Unposted Job Transaction	\N	Tech	Technical	K.Witaya	2026-01-25	08:54:00	\N	\N	2026-01-28
1026	ตรวจสอบหน้า A/P Check Printing/Posting	รบกวนตรวจสอบหน้า A/P Check Printing/Posting  เนื่องจากตอน Post ระบบหมุนและมีชื่อค้างไม่สามารถ Post รายการได้ค่ะ	medium	C	\N	15	2026-06-21 20:53:40.394748	2026-02-04 00:00:00	AP	2026-02-04 00:00:00	ให้ User แจ้งกับทาง IT หรือ Managers ที่มีสิทธิ์ให้ทำการปลดในส่วนของ CHECK PROCESSING ให้	\N	\N	\N	14	CNI	CNI2602003	\N	A/P Check Printing/Posting	\N	Standard	Knowledge	Accounting	2026-02-03	15:40:00	\N	\N	2026-02-06
1028	ขอช่วยตรวจสอบหน่อยค่ะ tag wip ไม่ออก	ขอช่วยตรวจสอบหน่อยค่ะ tag wip ไม่ออก	medium	C	\N	14	2026-06-21 20:53:40.396899	2026-02-09 00:00:00	Oth	2026-02-09 00:00:00	แก้ไข Ref Type ของ Job Matrial Oper 20 เป็น Purchase Order	\N	\N	\N	14	CNI	CNI2602005	\N	PPCC_Print WIP Tag	\N	Customized	Human Error	K.Pimpa	2026-02-09	13:00:00	Ref Type ของ Job Matrial Oper 20 เป็น Inventory	\N	2026-02-12
1029	ระบบไม่ POST JOB ให้ค่ะ ตรวจสอบให้หน่อยค่ะ	ระบบไม่ POST JOB ให้ค่ะ ตรวจสอบให้หน่อยค่ะ	medium	C	\N	\N	2026-06-21 20:53:40.397769	2026-02-09 00:00:00	Technical	2026-02-09 00:00:00	\N	\N	\N	\N	14	CNI	CNI2602006	\N	Unposted Job Transaction	\N	Tech	Technical	K.Witaya	2026-02-08	10:15:00	\N	\N	2026-02-11
1140	ขอด่วนครับ	เจอปัญหา ที่หน้าต่าง อนุมัติของ MD ไม่ขึ้นรายการอนุมัติแล้ว \nแต่ยังมี PO ที่ยังไม่อนุมัติค้างอยู่ 4 รายการ	medium	C	\N	14	2026-06-21 20:53:40.578411	2026-04-01 00:00:00	PO	2026-04-01 00:00:00	Update Status จาก Ordered กลับเป็น Planned	\N	\N	\N	14	SRN	SRN2603017	\N	PPCC_Purchase Order Approval	\N	Customized	Technical	Narongsak	2026-03-30	15:50:00	เนื่องจาก GN26030072 status ที่ line 1-3 ถูกเปลี่ยนเป็น ordered ไปแล้วทำให้ status ที่ header เปลี่ยนเป็น ordered ด้วยทำให้ preview ไม่ขึ้น	\N	2026-04-02
1142	รบกวนช่วยตรวจสอบให้หน่อย	แจ้งปัญหา เลข Shipping No.  SL26040713    Pick List N0. P26040825  เลข Shipping List  หาย 1 ใบ หมายเลข SB260407077  รบกวนช่วยตรวจสอบให้หน่อย ค่ะ	medium	C	\N	23	2026-06-21 20:53:40.580083	2026-04-08 00:00:00	Automation	2026-04-08 00:00:00	Insert ข้อมูลเข้าตาราง ppcc_shipping_list_detail Repint เป็นเบอร์ SB260407088	\N	\N	\N	14	SRN	SRN2604002	\N	PPCC_Shipping List Data	\N	Customized	Customized Bug	K.Jintana	2026-04-07	13:55:00	ไม่มีข้อมูล Ship Label ของ Tag JOB260455495 ค่ะ และ ship label SB260407077 เป็นของแท็ก JOB260456289 ที่ pick list P260407046	\N	2026-04-10
1143	สอบถามค่ะ เปลี่ยนเวลารับงานในระะบบแล้วโหลดรายงาน ไม่ขึ้นเวลาที่เปลี่ยนค่ะ JK2 ลูกค้า AAT	สอบถามค่ะ เปลี่ยนเวลารับงานในระะบบแล้วโหลดรายงาน ไม่ขึ้นเวลาที่เปลี่ยนค่ะ JK2 ลูกค้า AAT	medium	C	\N	23	2026-06-21 20:53:40.581111	2026-04-29 00:00:00	DO	2026-04-29 00:00:00	User แก้ข้อมูล Milk Run Date	\N	\N	\N	14	SRN	SRN2604003	\N	PPCC_PrintDailyDeliveryReport_BK20190807	\N	Customized	Customized Bug	Nuttapron Charoenchang	2026-04-29	13:40:00	ข้อมูลฟิลด์ Milk Run Date ที่ Customer Order Lines เป็นค่าว่าง	\N	2026-05-04
1030	กรณี ที่ INV ถูกโพสไปแล้ว แต่ทางลูกค้ามีการแจ้งมาว่า part No ผิดจึง มีการแก้ไข โดยการเอา - A ออกพอจะเข้ามาดึงใหม่ ที่ใน DO สรุป แก้ไขไม่ได้	กรณี ที่ INV ถูกโพสไปแล้ว แต่ทางลูกค้ามีการแจ้งมาว่า part No ผิดจึง มีการแก้ไข โดยการเอา - A ออกพอจะเข้ามาดึงใหม่ ที่ใน DO สรุป แก้ไขไม่ได้ และ จะกลับทำให้เป็น approved ก็ทำไม่ได้ แบบนี้ จะแก้ไข อย่างไร ได้บ้างคะ	medium	C	\N	14	2026-06-21 20:53:40.398588	2026-02-10 00:00:00	DO	2026-02-10 00:00:00	Update Cust Item = 53274-02140, Item Description = 53274-02140 BRK'T,FR BUMPER ARM MOUN,LH	\N	\N	\N	14	CNI	CNI2602007	\N	Delivery Orders	\N	Customized	Human Error	K.Kung	2026-02-10	08:10:00	\N	\N	2026-02-13
1031	ปริ้น production tag ไม่ออกค่ะ จำนวน 48 Pcs มีงานรอขาย 10.30 โมง	ปริ้น production tag ไม่ออกค่ะ จำนวน 48 Pcs มีงานรอขาย 10.30 โมง	medium	C	\N	14	2026-06-21 20:53:40.399746	2026-02-10 00:00:00	Oth	2026-02-10 00:00:00	แก้ไข Rank = 1	\N	\N	\N	14	CNI	CNI2602008	\N	PPCC_Print Production Tag and Delivery Tag	\N	Customized	Human Error	K.Pimpa	2026-02-10	09:45:00	Item FG102800027, Customer C002801 Rank = 2	\N	2026-02-13
1144	แจ้งข้อมูล เรื่อง Download Mapping Invoice Toyota ในระบบ ERP ไม่ได้	แจ้งข้อมูลเรื่อง Download Mapping Invoice Toyota ในระบบ ERP ไม่ได้ค่ะ จากภาพได้ทำการ Browse Text file เข้าระบบ ERP และทำการ Map Invoice Information\n\nระบบแสดง Message ตามภาพด้านล่างค่ะ รบกวน PPCC ตรวจสอบให้ด่วนหน่อยค่ะว่าเกิดจากอะไร และแนะนำแนวทางแก้ไข้ให้หน่อยค่ะ	medium	C	\N	15	2026-06-21 20:53:40.582972	2026-04-29 00:00:00	DO	2026-04-29 00:00:00	เปลี่ยนเงื่อนไขจากเอา Cust Item ในไฟล์ไปหา Item ที่ Customer Contract มาเป็นนำ Cust Item ในไฟล์ไป Where หาที่ Customer Order Lines แทน	\N	\N	\N	14	SRN	SRN2604004	\N	PPCC_Download Mapping Invoice Toyota	\N	Customized	Customized Bug	K.Siriwan	2026-04-29	10:35:00	เกิดจากข้อมูล Cust Item มีมากกว่า 1 Item ทำให้โปรแกรมดึงข้อมูลมาผิด	\N	2026-05-04
1147	รบกวนสอบถามหน่อยค่ะ	รบกวนสอบถามหน่อยค่ะ พอดี ดึง Report หน้า Inventory Balance By Location Report  ปกติ Part ที่ไม่มีการเคลื่อนไหว ระบบจะไม่ แสดงข้อมูล ใน Report ได้มีการปรับ เปลี่ยนเงื่อนไง อะไร ไหมค่ะ เพราะว่าดึง Report ออกมาเจอ ทุก Product Code ค่ะ  รบกวนช่วยตรวจสอบให้หน่อยค่ะ	medium	C	\N	14	2026-06-21 20:53:40.585332	2026-05-05 00:00:00	IC	2026-05-05 00:00:00	หากต้องการดูเฉพาะ Item ที่มีการเคลื่อนไหวไม่ต้องติ๊ก All Item	\N	\N	\N	14	SRN	SRN2605002	\N	PPCC_Inventory Balance By Location Report	\N	Customized	Knowledge	K.Jintana	2026-05-04	11:40:00	มีการติ๊กเงื่อนไข All Item จึงทำให้รายงานแสดง Item ที่ไม่มีการเคลื่อนไหว	\N	2026-05-08
1148	รบกวนแก้ไขข้อมูลตั้งหนี้หน้าตรง	เนื่องจากมีการตั้งหนี้หน้าตรง Inv.No.O2605/000001 = SNC และได้ทำการโยนข้อมูลไปที่ EZTax แล้ว ตามรูปที่ 1  และเผลอไปกด Generate Distribution อีกครั้งทำให้ข้อมูลที่บันทึกบัญชีก่อนหน้านี้หายไป จึงทำการใส่ข้อมูลหน้า  Distribution อีกครั้ง ตามรูปที่ 2 แต่พอดึงข้อมูลการบันทึกบัญชีมาดู  ข้อมูลที่ถูกบันทึกบัญชีมีข้อมูลที่ซ้ำกันค่ะ ตามรูปที่ 3\n\nรบกวนแก้ไขข้อมูลการบันทึกบัญชีตามรูปที่ 4 ให้หน่อยนะคะ	medium	C	\N	14	2026-06-21 20:53:40.585973	2026-05-11 00:00:00	AR	2026-05-11 00:00:00	ลบข้อมูลที่ค้างออกจากตาราง ppcc_arinvd_mst	\N	\N	\N	14	SRN	SRN2605003	\N	PPCC_InvoicesDebitandCreditMemos	\N	Localized	PPCC Localized	K.Panita	2026-05-11	15:35:00	ข้อมูลค้างอยู่ที่ตาราง ppcc_arinvd_mst	\N	2026-05-14
1093	Request support to download a list of all parts registered in SL.	Could we ask you a favor?\nWe’ve received a request from HQ to send a list of all parts registered in SL.\nBasically, we’re downloading data from the “PPCC_Vendor Customer Contract Prices” function.\nHowever, the data is very large.\nCould you please support to download it for us? kindly check and confirm.	medium	O	\N	14	2026-06-21 20:53:40.464791	2026-06-21 20:53:40.464791	CU	\N	\N	\N	\N	\N	14	NTH	NTH2606004	\N	PPCC_Vendor Customer Contract Prices	\N	Standard	Technical	K.Praweena	2026-06-12	09:35:00	\N	\N	2026-06-18
1032	INV690211011 เกินมา .01 ช่วยทำให้เหลือ 2000 ได้มั้่ยคะ	INV690211011 เกินมา .01 ช่วยทำให้เหลือ 2000 ได้มั้่ยคะ	medium	C	\N	14	2026-06-21 20:53:40.40073	2026-02-10 00:00:00	AR	2026-02-10 00:00:00	แก้ไขรายงาน หลังจากที่ User เรียกรายงานเสร็จทาง PPCC แก้ไขโค้ดกลับเป็นเหมือนเดิม	\N	\N	\N	14	CNI	CNI2602009	\N	PPCC_Pre Invoice	\N	Customized	Customized Bug	K.Kung	2026-02-10	16:45:00	Unit Price ที CO บันทึก 666.6667 แต่เมื่อนำมาทำ Pre Invoice โปรแกรมปัดทศนิยมเหลือ 2 ตำแหน่งได้ 66.67 เมื่อนำมาคูณกับ Qty 3 จึงได้ 2000.01	\N	2026-02-13
1033	รบกวนตรวจสอบ PV2601000238	รบกวนตรวจสอบ  PV2601000238  เนื่องจาก Post แล้วไม่เข้าหน้า G/L ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.40186	2026-02-16 00:00:00	GL	2026-02-16 00:00:00	Insert ข้อมูลเข้า journal และลบข้อมูลออกจากตาราง tmp_mass_journal	\N	\N	\N	14	CNI	CNI2602010	\N	G/L Posted Transactions	\N	Standard	Customized Bug	Accounting	2026-02-13	08:05:00	\N	\N	2026-02-18
1034	FG201500022 พบปัญหา 2-3 รอบแล้วที่ tag ถุงไม่ออกค่ะ	11:03 ตุ๊กตุ๊ก..🐷🐷 FG201500022 พบปัญหา\n11:03 ตุ๊กตุ๊ก..🐷🐷 2-3 รอบแล้วที่ tag ถุงไม่ออกค่ะ	medium	C	\N	21	2026-06-21 20:53:40.403416	2026-02-16 00:00:00	Oth	2026-02-16 00:00:00	แก้ไข Cust Item ที่ PO Line ให้ตรงกับ Customer Contracts	\N	\N	\N	14	CNI	CNI2602011	\N	Vebdor Print Tag	\N	Customized	Human Error	K.Tuk	2026-02-13	11:00:00	Cust Item ที่ PO Line ไม่ตรงกับ Customer Contracts	\N	2026-02-19
1035	ขอปรึกษาเรื่องแม่พิมพ์ หน่อยค่า	คือ ลูกค้า ต้องการให้เปิด INV 1 ใบแต่ตอนสร้าง CO สร้างผิดมา แค่ 1 ต้องการถอยยอดออก	medium	C	\N	19	2026-06-21 20:53:40.404498	2026-02-18 00:00:00	CO	2026-02-18 00:00:00	ให้ User ทำ RMA แล้วสร้าง Invoice ใหม่	\N	\N	\N	14	CNI	CNI2602012	\N	Customer Order Lines	\N	Customized	Knowledge	K.Kung	2026-02-17	08:25:00	\N	\N	2026-02-20
1149	สอบถามการแก้ไขรายละเอียดหน้า Tax Invoice ขายต่างประเทศ	เนื่องจาก ธนาคารกรุงศรีฯ สาขากรุงเทพต้นสน ย้ายกิจการไปควบรวมกับ ธนาคารกรุงศรีฯ สาขาเพลินจิต  ทำให้ธุรกรรมทางการเงินที่ได้รับอนุมัติใน วันที่ 20 มิถุนายน 2569 เป็นต้นไป  ซึ่งมีผลกระทบในเรื่องของ Tax Invoice ต่างประเทศ ตรงข้อมูล สาขากรุงเทพ และ ที่อยู่ธนาคาร มุมล่างซ้ายของเอกสารขายต่างประเทศ\n\nเนื่องจาก Tax Invoice ขายต่างประเทศมีข้อมูลของธนาคารโชว์ที่หน้าเอกสาร(รายละเอียดตามเอกสารแนบ)  รบกวนสอบถาม PPCC หากต้องการเปลี่ยนแปลงข้อมูลของธนาคารที่โชว์หน้า Tax Invoice ต่างประเทศ สามารถแก้ไขเองได้ไหมคะ ถ้าหากแก้ไขเองได้ต้องเข้าไปที่หน้าไหนคะ	medium	C	\N	15	2026-06-21 20:53:40.586621	2026-05-13 00:00:00	AR	2026-05-13 00:00:00	ชื่อสาขาสามารถแก้ไขได้ที่หน้าจอ Bank Reconciliations,ส่วนของที่อยู่ธนาคารสามารถแก้ไขได้ที่หน้าจอ Bank Addresses	\N	\N	\N	14	SRN	SRN2605004	\N	PPCC_Export Invoice Report	\N	Customized	Knowledge	K.Panita	2026-05-12	10:10:00	\N	\N	2026-05-15
1150	ข้อมูล Pre-Invoice ของลูกค้า Honda ข้อมูลในส่วนของ Plan code , Loc to ไม่พบข้อมูลแสดงค่ะ	แจ้งข้อมูลเรื่อง : ข้อมูล Pre-Invoice ของลูกค้า Honda ข้อมูลในส่วนของ Plan code , Loc to ไม่พบข้อมูลแสดงค่ะ\nตัวอย่างข้อมูลที่ต้องแสดงค่ะ → FROM:45453 TO:R3F26 PLAN CODE:MPAF03 LOC TO:MF43 ตามภาพขวามือ = ปกติ\nรบกวนแก้ไขให้ด่วน ภายในเวลา 16.30 ค่ะ เนื่องจากต้องใช้ Invoice สำหรับจัดส่งค่ะ	medium	C	\N	14	2026-06-21 20:53:40.587514	2026-05-25 00:00:00	AR	2026-05-25 00:00:00	แก้ไข Invoice Customer’s A/C เป็น From, To, Plan Code, Loc To	\N	\N	\N	14	SRN	SRN2605005	\N	PPCC_Tax Invoice	\N	Customized	Knowledge	K.Siriwan	2026-05-20	15:45:00	Customer DHATC01 Ship To 0 เลือก Invoice Customer’s A/C เป็น None	\N	2026-05-25
1040	ตรวจสอบ CC2602000002	รบกวนแก้ไขยอด ภาษีมูลค่าเพิ่ม CC2602000002 จากเดิม 128.29 บาท แก้ไขเป็นยอด 128.28 บาท จำนวนเงินรวม 1,961 บาท รายการถูก post ไปแล้วค่ะ	medium	C	\N	14	2026-06-21 20:53:40.409027	2026-03-20 00:00:00	AP	2026-03-20 00:00:00	Update Database	\N	\N	\N	14	CNI	CNI2603003	\N	PPCC_Input Vat Report	\N	Localized	Human Error	Accounting	2026-03-19	10:55:00	\N	\N	2026-03-25
1041	รบกวนตรวจสอบ GJ2602000047	รบกวนตรวจสอบ  GJ2602000047  เนื่องจาก Post แล้วไม่เข้าหน้า G/L ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.40991	2026-03-20 00:00:00	GL	2026-03-20 00:00:00	Insert ข้อมูลเข้า journal และลบข้อมูลออกจากตาราง tmp_mass_journal	\N	\N	\N	14	CNI	CNI2603004	\N	G/L Posted Transactions	\N	Standard	Standard Bug	Accounting	2026-03-19	15:25:00	\N	\N	2026-03-25
1042	ไฟล์นี้ โหลดเข้าระบบไม่ได้ค่ะ	ไฟล์นี้ โหลดเข้าระบบไม่ได้ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.410746	2026-03-20 00:00:00	EDI	2026-03-20 00:00:00	แก้ไขข้อมูล Column CONT 2 รายการแรกโดยลบการขึ้นบรรทัดใหม่หรือ Tab ออก	\N	\N	\N	14	CNI	CNI2603005	\N	PPCC_EDI Order Load	\N	Customized	Human Error	K.Kung	2026-03-19	14:55:00	ข้อมูล Column CONT 2 รายการแรกมีการขึ้นบรรทัดใหม่หรือ Tab ทำให้ข้อมูล Txt ไม่ถูกต้อง	\N	2026-03-25
1106	รบกวนตรวจสอบให้หน่อยคะ  Print production tag ไม่ขึ้นคะ	รบกวนตรวจสอบให้หน่อยคะ \nPrint production tag ไม่ขึ้นคะ	medium	C	\N	23	2026-06-21 20:53:40.481706	2026-01-07 00:00:00	Automation	2026-01-07 00:00:00	กำหนด Barcode Control ที่หน้า PPCC_Items	\N	\N	\N	14	SRN	SRN2601002	\N	PPCC_Print Production Tag	\N	Customized	Human Error	K.Kornrada	2026-01-07	11:55:00	Item ไม่ได้กำหนด Barcode Control ที่หน้า PPCC_Items	\N	2026-01-12
1151	แจ้งปัญหาการ Forecast AAT ( Loading in ERP on 22 Apr'26 )	รบกวนตรวจสอบ Forecast AAT vat.0 ของเดือน Jun’26 ( Loading in ERP on 22 My'26 ) ให้หน่อยค่ะ เนิ่องจาก Forecast ช่วงวันที่ 11-12 May’26 หายไป ทั้งที่ในไฟล์ Data base ที่ใช้โหลดมีข้อมูล แต่เมื่อเราดึงข้อมูลจาก Forecast detail ออกมาไม่มีข้อมูลค่ะ	medium	C	\N	14	2026-06-21 20:53:40.588161	2026-05-25 00:00:00	EDI	2026-05-25 00:00:00	\N	\N	\N	\N	14	SRN	SRN2605006	\N	PPCC_EDI Load Forecast	\N	Customized	Customized Bug	K.Panarath	2026-05-22	15:05:00	Template Weekly สร้างไม่ครบ	\N	2026-05-27
1154	แจ้งปัญหา ShipLabel เกิน ค่ะ  SB260606020 งานจริง C1 มีแค่ 4 Rack ค่ะ รบกวนช่วย ตรวจสอบให้หน่อยค่ะ	แจ้งปัญหา ShipLabel เกิน ค่ะ  SB260606020 งานจริง C1 มีแค่ 4 Rack ค่ะ รบกวนช่วย ตรวจสอบให้หน่อยค่ะ	medium	C	\N	23	2026-06-21 20:53:40.591863	2026-06-08 00:00:00	Automation	2026-06-08 00:00:00	ลบรายการที่เกินออกจากระบบ	\N	\N	\N	14	SRN	SRN2606001	\N	Shipping List Detail	\N	Customized	Customized Bug	K.Jintana	2026-06-08	09:15:00	\N	\N	2026-06-11
1156	รบกวนช่วยตรวจสอบ Job J000000192 เจอปัญหาหมายเลข Tag ซ้ำกันค่ะ	รบกวนช่วยตรวจสอบ Job J000000192\nเจอปัญหาหมายเลข Tag ซ้ำกันค่ะ	medium	C	\N	23	2026-06-21 20:53:40.594064	2026-06-10 00:00:00	SFC	2026-06-10 00:00:00	แจ้ง User ให้แก้ไข Rank ให้เหลือ Rank 1 แค่รายการเดียว	\N	\N	\N	14	SRN	SRN2606003	\N	PPCC_Print Production Tag	\N	Customized	Knowledge	K.Wipa	2026-06-10	15:05:00	ข้อมูลของ tag จะดึงตาม rank 1 item นี้มี rank 1 อยู่ 2 รายการข้อมูลเลยออกซ้ำ	\N	2026-06-15
1157	แก้ไขเลขที่ Run Number	เนื่องจากทางทีมบัญชีได้ทำการ Run Number ใบลดหนี้เลขที่ RMA6812060  เลขที่ SR68120118\nแต่เนื่องจากเลขที่ Run ดังกล่าวไม่สอดคล้องกับเลขที่ใบลดหนี้ รบกวนแก้ไขจาก “ SR68120118 เป็น SR68120060”	medium	C	\N	14	2026-06-21 20:53:40.594704	2026-01-06 00:00:00	RMA	2026-01-06 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2601001	\N	PPCC_RMAs	\N	Customized	Customized Bug	K.Jittima	2026-01-05	08:50:00	\N	\N	2026-01-08
1043	รบกวนตรวจสอบ GJ2602000043	รบกวนแก้ไขยอด ภาษีมูลค่าเพิ่ม GJ2602000043 จากเดิม 20.20 บาท แก้ไขเป็นยอด 20.22 บาท และลบรายการส่วนขาดส่วนเกิน 0.02 ออก รายการถูก post ไปแล้วค่ะ	medium	C	\N	14	2026-06-21 20:53:40.411664	2026-03-20 00:00:00	GL	2026-03-20 00:00:00	Update Database ส่วนขาบัญชีส่วนขาดส่วนเกินจะไม่ลบออกแต่จะแก้ไขยอดเงินเป็น 0	\N	\N	\N	14	CNI	CNI2603006	\N	G/L Posted Transactions	\N	Localized	Human Error	Accounting	2026-03-20	08:35:00	\N	\N	2026-03-25
1044	รบกวนตรวจสอบรายการหน้า Journal Voucher Listing Report	รบกวนตรวจสอบรายการหน้า Journal Voucher Listing Report  คำอธิบายตรง Description  ไม่โชว์ยกตัวอย่าง	medium	C	\N	14	2026-06-21 20:53:40.412479	2026-03-27 00:00:00	GL	2026-03-27 00:00:00	เขียนเงื่อนไขเพิ่ม	\N	\N	\N	14	CNI	CNI2603007	\N	Journal Voucher Listing Report	\N	Localized	PPCC Localized	Narin	2026-03-26	11:30:00	เงื่อนไขการแสดง Description จะดึงเฉพาะ Note ที่ข้อมูลยังอยู่ Journal Entries ซึ่ง Ref JV2512000046 ข้อมูลถูก Post ไป G/L Posted Transactions จึงไม่สามารถดึง Note มาแสดงได้	\N	2026-03-31
1045	รบกวนสอบถามค่ะ	ลูกค้า ให้เปลี่ยนชื่อ บริษัทจาก บริษัท  สยามคอมเพรสเซอร์อุตสาหกรรม  จำกัด เป็น บริษัท มิตซูบิชิ อิเล็คทริค สยามคอมเพรสเซอร์อุตสาหกรรม จำกัดที่อยู่ เหมือนเดิมอยากได้ code cus C001201 เหมือนเดิท ได้ไหมค่ะ	medium	C	\N	19	2026-06-21 20:53:40.413267	2026-04-01 00:00:00	CU	2026-04-01 00:00:00	แก้ไขที่อยู่ใหม่	\N	\N	\N	14	CNI	CNI2603008	\N	Customers	\N	Customized	Knowledge	Accounting	2026-03-31	14:25:00	\N	\N	2026-04-03
1046	vender ที่ยกเลิกใช้แล้วพี่อยากรุ้ว่า ถ้าพี่ดึงมาเปิด po อยากให้ระบบไม่ยอม หรือเตือนว่ายกเลิกได้ไหม	vender ที่ยกเลิกใช้แล้วพี่อยากรุ้ว่า ถ้าพี่ดึงมาเปิด po อยากให้ระบบไม่ยอม หรือเตือนว่ายกเลิกได้ไหม	medium	C	\N	15	2026-06-21 20:53:40.414159	2026-04-20 00:00:00	Vendors	2026-04-20 00:00:00	เปลี่ยน Status เป็น N ที่หน้าจอ Vendors	\N	\N	\N	14	CNI	CNI2604001	\N	Vendors	\N	Customized	Knowledge	K.Tuk	2026-04-17	10:05:00	ในกรณีนี้รหัส Vendor นี้มีหนี้ค้างอยู่ต้องทำการเคลียร์หนี้ก่อนถึงจะมาเปลี่ยน Status ได้	\N	2026-04-22
1158	แก้ไขเลขที่ Run Number	เนื่องจากทีมบัญชีได้ทำการทำเพิ่มหนี้ PriceAdj  ล้างใบลดหนี้ SR68120058\nแต่ไม่สามารถทำได้  รบกวนตรวจสอบรายการนี้ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.595335	2026-01-06 00:00:00	AR	2026-01-06 00:00:00	\N	\N	\N	\N	14	TAK	TAK2601002	\N	PPCC_PriceAdjustmentInvoice	\N	Customized	Knowledge	K.Jittima	2026-01-05	09:00:00	โปรแกรม PPCC_PriceAdjustmentInvoice ไม่รองรับการคีย์ Apply To Invoice ด้วยใบลดหนี้	\N	2026-01-08
1047	รบกวนตรวจสอบรายการ GJ2512000057	รบกวนตรวจสอบรายการ GJ2512000057   เนื่องจากใน General Ledger By Account Report ไม่โชว์รายงาน ในขณะที่ post ปกติค่ะ\n	medium	C	\N	14	2026-06-21 20:53:40.415193	2026-04-20 00:00:00	GL	2026-04-20 00:00:00	Insert ข้อมูลเข้า journal และลบข้อมูลออกจากตาราง tmp_mass_journal	\N	\N	\N	14	CNI	CNI2604002	\N	General Ledger By Account Report	\N	Localized	PPCC Localized	Narin	2026-04-18	21:35:00	ข้อมู Post เข้า tmp_mass_journal	\N	2026-04-23
1049	รบกวนตรวจสอบรายการ GJ2512000056	รบกวนตรวจสอบรายการ GJ2512000056  เนื่องจากใน General Ledger By Account Report ไม่โชว์รายงานในขณะที่ post ปกติค่ะ	medium	C	\N	14	2026-06-21 20:53:40.419509	2026-04-27 00:00:00	GL	2026-04-27 00:00:00	Insert ข้อมูลเข้า journal และลบข้อมูลออกจากตาราง tmp_mass_journal	\N	\N	\N	14	CNI	CNI2604004	\N	General Ledger By Account Report	\N	Localized	PPCC Localized	Narin	2026-04-20	11:00:00	\N	\N	2026-04-23
1050	รบกวนเช็คให้หน่อยค่ะโพสแล้วไม่โชว์หน้าAR ค่ะ	รบกวนเช็คให้หน่อยค่ะโพสแล้วไม่โชว์หน้าAR ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.420735	2026-05-05 00:00:00	AR	2026-05-05 00:00:00	เปลี่ยน Status DO เป็น Approved	\N	\N	\N	14	CNI	CNI2604005	\N	PPCC_Pre-Invoice	\N	Customized	Human Error	K.ทราย	2026-04-30	10:45:00	ยังไม่ได้เปลี่ยน Status DO เป็น Approved	\N	2026-05-05
1051	รบกวนตรวจสอบ ข้อมูลที่อยู่ใบลดหนี้ค่ะ	รบกวนตรวจสอบ ข้อมูลที่อยู่ใบลดหนี้ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.421699	2026-05-19 00:00:00	AR	2026-05-19 00:00:00	ย่อขนาดตัวอักษรให้เล็กลง	\N	\N	\N	14	CNI	CNI2605001	\N	RMAs	\N	Customized	Customized Bug	K.Kae	2026-05-18	11:35:00	ที่อยู่ตกบรรทัด	\N	2026-05-21
1052	ไม่โชว์ในรายงาน GL	ไม่โชว์ในรายงาน GL	medium	C	\N	14	2026-06-21 20:53:40.422981	2026-05-19 00:00:00	GL	2026-05-19 00:00:00	Insert ข้อมูลเข้า journal และลบข้อมูลออกจากตาราง tmp_mass_journal	\N	\N	\N	14	CNI	CNI2605002	\N	General Ledger By Account Report	\N	Standard	Standard Bug	Accounting	2026-05-18	12:00:00	ข้อมูลค้างที่ตาราง tmp_mass_journal	\N	2026-05-21
1160	แกไข รายการหัก ณ ที่จ่าย	เรื่อง แก้ไขใบหัก ณ ที่จ่าย และรายงาร ภาษีหัก ณ ที่จ่าย ตามข้อมูลด้านล่างขอบคุณคะ\nแก้ไข ใบหัก ณ ที่จ่าย จาก ภ.ง.ด 53 เป็น ภ.ง.ด 3	medium	C	\N	14	2026-06-21 20:53:40.596768	2026-01-07 00:00:00	AP	2026-01-07 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2601004	\N	PPCC_Withholding Tax Certificate	\N	Localized	Human Error	K.Nattakan	2026-01-07	15:10:00	\N	\N	2026-01-12
1161	แก้ไข รายงานภาษีซื้อ ตามไฟล์แนบ	รบกวนแก้ไข รายงาน ภาษีซื้อ ตามไฟล์แนบคะ	medium	C	\N	14	2026-06-21 20:53:40.597399	2026-01-09 00:00:00	AR	2026-01-09 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2601005	\N	PPCC_Input Vat Report	\N	Localized	PPCC Localized	K.Nattakan	2026-01-08	15:25:00	\N	\N	2026-01-13
1165	ตั้งหนี้	เรียนทีม PPCC เนื่อง จากมีการตั้งหนี้ (ใบสีเหลือง) โดยเลข APV 85266 แล้วถอยออก โดยอ้างอิง APV 85266  แต่จะตั้งใหม่โดยอ้างอิง ใบรับเดิม คือ RR68120116\n\nแต่เปลี่ยนจำนวนเงิน ตามใบ กำกับ สีฟ้า แต่ไม่สามารถ ตั้งได้ รบกวนตรวจสอบให้ทีคะ	medium	C	\N	14	2026-06-21 20:53:40.601477	2026-01-22 00:00:00	PO	2026-01-22 00:00:00	\N	\N	\N	\N	14	TAK	TAK2601009	\N	Generate A/P Transactions	\N	Customized	Knowledge	K.Nattakan	2026-01-19	18:05:00	ยอด Vouchered ไม่ได้ถูกถอยที่ PO PO68120035 และ GRN RR68120116 จึงทำให้ไม่สามารถนำไปตั้งหนี้ได้ เกิดจากทำถอยไม่ครบขั้นตอน ซึ่งปกติควรทำถอย PO (DR Return) > Voucher Adjustment	\N	2026-01-23
1053	รบกวนตรวจสอบรายการ GJ2602000061	รบกวนตรวจสอบรายการ GJ2602000061   เนื่องจากใน General Ledger By Account Report ไม่โชว์รายงาน\nในขณะที่ post ปกติค่ะ	medium	C	\N	14	2026-06-21 20:53:40.424014	2026-05-19 00:00:00	GL	2026-05-19 00:00:00	Insert ข้อมูลเข้า journal และลบข้อมูลออกจากตาราง tmp_mass_journal	\N	\N	\N	14	CNI	CNI2605003	\N	General Ledger By Account Report	\N	Standard	Standard Bug	Narin	2026-05-18	16:25:00	ข้อมูล GJ2602000061#2292 ยังคงอยู่ที่หน้าจอ A/P Payments	\N	2026-05-21
1054	รบกวนตรวจสอบรายการ GJ2604000057	รบกวนตรวจสอบรายการ GJ2604000057   เนื่องจากใน General Ledger By Account Report ไม่โชว์รายงาน ในขณะที่ post ปกติค่ะ\n	medium	C	\N	14	2026-06-21 20:53:40.425045	2026-05-19 00:00:00	GL	2026-05-19 00:00:00	Insert ข้อมูลเข้า journal และลบข้อมูลออกจากตาราง tmp_mass_journal	\N	\N	\N	14	CNI	CNI2605004	\N	General Ledger By Account Report	\N	Standard	Standard Bug	Narin	2026-05-19	13:45:00	ข้อมูลค้างที่ตาราง tmp_mass_journal	\N	2026-05-22
1055	ตรวจสอบ GJ2604000033 เนื่องจากถูกโพสไปแล้วไม่เข้า หน้า GL ค่ะ	รบกวนตรวจสอบ GJ2604000033 เนื่องจากได้ทำการโพสไปแล้วแต่ไม่เข้าหน้า GL ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.426014	2026-05-25 00:00:00	GL	2026-05-25 00:00:00	Insert ข้อมูลเข้า journal และลบข้อมูลออกจากตาราง tmp_mass_journal	\N	\N	\N	14	CNI	CNI2605005	\N	G/L Posted Transactions	\N	Standard	Standard Bug	Accounting	2026-05-25	08:25:00	ข้อมูลค้างที่ตาราง tmp_mass_journal	\N	2026-05-28
1173	ยอด Scrap ไม่ขึ้นค่ะ	รบกวนช่วยดูเคสนี้ให้หน่อยค่ะ ยอด Scrap ไม่แสดงที่หน้า Job ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.608057	2026-02-19 00:00:00	SFC	2026-02-19 00:00:00	Insert ข้อมูลเข้า jobtran และ Update Qty Scrapped	\N	\N	\N	14	TAK	TAK2602005	\N	TAK_Job Orders	\N	Customized	Customized Bug	K.Naruedee	2026-02-19	10:30:00	\N	\N	2026-02-24
1166	ถอยรับไม่ได้ค่ะ	รบกวนช่วยแก้ไขเคสนี้ให้หน่อยค่ะ ถอยรับ GRN ไม่ได้ค่ะ	medium	C	\N	15	2026-06-21 20:53:40.602397	2026-01-26 00:00:00	PO	2026-01-26 00:00:00	\N	\N	\N	\N	14	TAK	TAK2601010	\N	PPCC_Purchase Order Receiving	\N	Customized	Knowledge	K.Naruedee	2026-01-23	08:40:00	Item RM1-FLM-LLD-TPB01-C4W-030-1030 มีการรับเข้ามาโดยใช้ Lot 260100000000001, 260100000000002 และ 260100000000003  ค่ะ โดยการถอยต้องทำถอยโดยใช้ Lot เดียวกับที่ทำรับเข้ามาจึงต้องใช้ Lot 260100000000001, 260100000000002 และ 260100000000003 ในการถอย	\N	2026-01-28
1167	แก้ไขเลขใบกำภาษี	รบกวนแก้ไขใบกำกับภาษีใน APV 86235 จากเลข IV0009299 เป็นเลข IV0009296	medium	C	\N	14	2026-06-21 20:53:40.603201	2026-01-24 00:00:00	AP	2026-01-24 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2601011	\N	PPCC_APVoucherandAdjustments	\N	Localized	PPCC Localized	K.Nattakan	2026-01-23	11:50:00	\N	\N	2026-01-28
1168	รบกวนตรวจสอบใบเพิ่มหนี้ DR69010002	รบกวนตรวจสอบใบเพิ่มหนี้  DR69010002  เนื่องจากราคาในแบบฟอร์มไม่ออกค่ะ\nและรบกวนแก้ไขเลขที่เพิ่มหนี้ จากเดิมเป็นDR69010001 เนื่องจาก Runnumber ไม่ถูกต้อง	medium	C	\N	14	2026-06-21 20:53:40.604266	2026-02-02 00:00:00	AR	2026-02-02 00:00:00	แก้ไขเงื่อนไขการคำนวณ	\N	\N	\N	14	TAK	TAK2601012	\N	PPCC_PriceAdjustmentInvoice	\N	Customized	Knowledge	K.Jittima	2026-01-28	17:30:00	ยอดเงินหน่วยละคำนวณโดยนำ New Price – Unit Price\nNew Price = 5700\nUnit Price = 5700\nยอดเงินหน่วยละในรายงานจึงคำนวณได้ 0\n\nเมื่อตรวจสอบ CO. CO68090230 เคยถูกนำมาทำใบเพิ่มหนี้ DR68120003 ไปแล้ว ยอดเงิน Unit Price ที่ Customer Order Lines จึงถูกแก้ไขจาก 2850 เป็น 5700	\N	2026-02-03
1057	ลบรายงานของวอทเชอร์ 98421 ที่เป็น Adjustment ที่ผิดให้หน่อยค่ะ	เนื่องจากได้ทำการลดหนี้อินวอย์ที่เป็นเลขที่วอทเชอร์ 98421 มีรายงานที่ผิดเพิ่มเข้ามา 1 ใบ รบกวนลบออกให้เหลือแค่ 2 ใบที่ถูกได้ไหมค่ะ	medium	C	\N	14	2026-06-21 20:53:40.427869	2026-06-02 00:00:00	AP	2026-06-02 00:00:00	ลบข้อมูล Voucher 98421 ที่สร้างจากการตั้งตรงผ่านหน้าจอ AP Voucher and Adjustments ออกจากตาราง ppcc_aptrx_mst	\N	\N	\N	14	CNI	CNI2606001	\N	PPCC_AP Invoice Voucher Report	\N	Localized	PPCC Localized	Accounting	2026-06-01	11:45:00	มีข้อมูล Voucher 98421 ที่สร้างจากการตั้งตรงผ่านหน้าจอ AP Voucher and Adjustments ค้างอยู่ที่ตาราง ppcc_aptrx_mst	\N	2026-06-05
1059	รบกวนตรวจสอบ GJ2605000038 เนื่องจากถูกโพสไปแล้วแต่ไม่เข้าหน้า GL ค่ะ	รบกวนตรวจสอบ GJ2605000038 เนื่องจากถูกโพสไปแล้วแต่ไม่เข้าหน้า GL ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.431189	2026-06-16 00:00:00	GL	2026-06-16 00:00:00	Insert ข้อมูลเข้า journal และลบข้อมูลออกจากตาราง tmp_mass_journal	\N	\N	\N	14	CNI	CNI2606003	\N	G/L Posted Transactions	\N	Standard	Standard Bug	Accounting	2026-06-16	14:25:00	ข้อมูลค้างอยู่ที่ตาราง tmp_mass_journal	\N	2026-06-19
1061	รบกวนตรวจสอบ HDO260000024 Preview ข้อมูล Invoice แล้วมันแสดง ยอด Vat ไม่ถูกต้องค่ะ / ยอดที่ถูกต้องจะเท่ากับ 68,046.30 ค่ะ K2 ID : 3433249	รบกวนตรวจสอบปัญหาด้านล่าง เรื่องการคำนวณ Vat ไม่ถูกต้องค่ะ \nที่ถูกต้องจะเป็นยอด  68,046.30 \nDO :  HDO260000024   , CO : HCOR250105 (CO Line 5-8)\n	medium	C	\N	14	2026-06-21 20:53:40.43444	2026-02-19 00:00:00	AR	2026-02-19 00:00:00	เพิ่มเงื่อนไขคำนวณยอดเงินภาษีให้มองตาม CO Line ด้วย	\N	\N	\N	14	HA	HA26020001	\N	PPCC_Consolidate Invocing	\N	Customized	Customized Bug	K.Mewadee	2026-02-19	10:15:00	เงื่อนไขคำนวณยอดเงินภาษีมีการนำยอด Progressive (Line 1-4) มาคำนวณด้วย	\N	2026-02-24
1064	วิธี unlock credit hold ใน order credit hold change	วิธี unlock credit hold ใน order credit hold change	medium	C	\N	15	2026-06-21 20:53:40.437406	2026-02-12 00:00:00	AP	2026-02-12 00:00:00	เพิ่ม Group : Credit Field Update	\N	\N	\N	14	HHT	HHT2602002	\N	order credit hold change	\N	Tech	Knowledge	K.Tongty	2026-02-11	14:27:00	\N	\N	2026-02-11
1169	ดึงยอดหนี้ APV 86686 กลับมาทำจ่าย และลบใน Journal Entries	รบกวนลบการทำจ่ายของ PV6901221 ให้ด้วยค่ะ เนื่องจาก ยังทำรายการไม่สมบูรณ์แต่ยอดหนี้ของ APV 86686 มีการถูกตัดเข้าไปหน้า APPostedTransactionsDetail แล้ว ทำให้ทำการจ่ายไม่ได้ ช่วยดึงหนี้ของ APV นี้กลับมาให้ทำจ่ายอีกครั้งค่ะ\nและช่วยลบหน้า Journal Entries ให้ด้วยนะคะ เนื่องจากมี Transaction เข้ามาแล้วค่ะ\n	medium	C	\N	14	2026-06-21 20:53:40.605079	2026-02-09 00:00:00	AP	2026-02-09 00:00:00	ลบข้อมูลที่หน้าจอ AP Posted Transaction Details และ G/L Posted Transactions และทำการ Rebalance Ledger Period Total	\N	\N	\N	14	TAK	TAK2602001	\N	A/P Quick Payment Application	\N	Localized	Human Error	K.Sukanya	2026-02-04	17:05:00	Reference APPR เกิดจาก Payment Reapplication	\N	2026-02-10
1069	RP Ice Solutions : แจ้งปัญญา Background Task PPCC_ICashBGInsert Error	รบกวนตรวจสอบรายการใน Table PPCC_tmp_Appointment ตามรูปภาพด้านล่างด้วยนะค่ะ\nเนื่องจากตรวจสอบพบว่ารายการชุดนี้ไม่ insert เข้า Table PPCC_Appointment และไม่เข้า iCash ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.443287	2026-01-24 00:00:00	APM	2026-01-24 00:00:00	Dev PK ต้องแก้ไขโปรแกรมโดยข้อมูล Step 3 และ 8 Insert ลง PPCC_tmp_Appointment ด้วย RowPointer เดียวกัน	\N	\N	\N	14	ICE	ICE2601002	\N	PPCC_i-Cash	\N	Customized	Customized Bug By Customer	K.Sirinat	2026-01-23	14:10:00	มีการแก้ไข Job PKDV_Salesforce_Sync_i-Cash_Service_ACT ดังนี้\r\nStep 3 เรียก SP_SFTiemSheet_ADV_Prepare_Step2_Fri (มีการแก้ไข Comment Code จังหวะเรียก BG Task ออกไป) ทำให้ปัจจุบัน Job Sync Auto จะมีการเรียก BG Task แค่ 1 รอบถูกต้องตามที่ทาง PPCC เคยแจ้งสาเหตุของปัญหาในเคสก่อนหน้า แต่ยังมีจุดที่ทำให้การทำงานไม่ถูก ดังนี้\r\n1. Step 3 เรียก SP_SFTiemSheet_ADV_Prepare_Step2_Fri มีการเขียน SET @rowpointer = NEWID() ทำให้ข้อมูลชุดแรกที่ได้ RowPointer 32B92860-84C0-4DB2-8D3E-6DA91072B6D6\r\n2. step 8 เรียก SP_SFTiemSheet_ACT_Prepare_Step2 มีการเขียน SET @rowpointer = NEWID() ทำให้ข้อมูลชุดสองที่ได้ RowPointer E698E599-EDCF-4A7C-8DAC-49289224F8C5\r\n\r\nBG Task จะถูกเรียกตอน Step 8 โดยส่ง RowPointer E698E599-EDCF-4A7C-8DAC-49289224F8C5  เข้าไป Insert ข้อมูล PPCC_Appointment และสร้าง i-Cash ตาม Step แต่ข้อมูลชุด 32B92860-84C0-4DB2-8D3E-6DA91072B6D6 จะไม่ถูกทำงาน	\N	2026-01-28
1070	รบกวนเช็คให้ด่วนนะค่ะ RMA CREDIT MEMO	RMA CREDIT MEMO --> PROCESS --> REPORT PDF  ไม่ออกค่ะ ไม่ทราบว่าเพราะอะไรค่ะ รบกวนเช็คให้ด้วยค่ะ ขอบคุณค่ะ	medium	C	\N	15	2026-06-21 20:53:40.444206	2026-01-06 00:00:00	RMA	2026-01-06 00:00:00	ให้ User ทำการสร้าง Sequence ของปี 2026 ที่หน้าจอ Invoice Debit and Credit Memo Sequence	\N	\N	\N	14	NTH	NTH2601001	\N	PPCC_RMA Credit Memo	\N	Customized	Knowledge	K.Nisakarn	2026-01-05	19:05:00	ไม่ได้มีการสร้าง Sequence ของปี 2026 จึงทำให้ไม่สามารถ Post RMA CREDIT MEMO ได้	\N	2026-01-08
1071	รบกวนเช็ค Shipment 102688 ออก Consolidated Invoice ไม่ได้	รบกวนเช็คให้ด้วยค่ะ shipment 102688 ออก Invoice ไม่ได้ อันนี้ต้องออกเป็น INV.OI260-002 เพราะ INV.OI260-001 ทำ RMA ไปแล้วค่ะ ขอบคุณค่ะ	medium	C	\N	15	2026-06-21 20:53:40.444921	2026-01-12 00:00:00	DO	2026-01-12 00:00:00	Update Last Number ที่ PPCC_InvoicesRunning ของ Customer 7323 Ship To 1 เป็น OI2601-001 เพื่อให้ระบบ Running เป็น OI2601-002	\N	\N	\N	14	NTH	NTH2601002	\N	PPCC_Consolidate Invoicing	\N	Customized	Human Error	K.Nisakarn	2026-01-07	10:50:00	\N	\N	2026-01-12
1175	ตรวจสอบให้หน่อยครับยอดหายเด็กเก็บงานขึ้นเมื่อคืนแต่ยอดที่ WMS หายครัย	ตรวจสอบให้หน่อยครับยอดหายเด็กเก็บงานขึ้นเมื่อคืนแต่ยอดที่ WMS หายครัย	medium	C	\N	18	2026-06-21 20:53:40.611637	2026-03-25 00:00:00	IC	2026-03-25 00:00:00	ทำการ update item : RM1-FLM-LLD-TPB01-C8N-075-0800 ที่ location : WMS ของ Lot : 260200000000001 กับ Lot : 260200000000002 จำนวนอย่างละ 2500 MR	\N	\N	\N	18	TAK	TAK2602007	\N	Item Lot Location	\N	Standard	Technical	K.Ya Pa	2026-02-25	\N	\N	\N	2026-02-25
1072	รบกวนเช็คให้หน่อยค่ะ upload shipment ถึงขั้นตอนสุดท้ายแล้ว แต่มี item เดียวที่ไม่ผ่าน อยากทราบว่าติดปัญหาอะไรคะ	ทั้งที่เรา create item ,ใน sl ครบถ้วน และพาร์ทนี้ก็มีในระบบ yusen ด้วย	medium	C	\N	21	2026-06-21 20:53:40.445688	2026-01-14 00:00:00	IC	2026-01-14 00:00:00	ให้ User ผูก item LGU2W121MELA ด้วย Location YUSEN ที่หน้าจอ Item Stockroom Location	\N	\N	\N	14	NTH	NTH2601003	\N	PPCC_QuantityMove	\N	Customized	Human Error	K.Giffy	2026-01-13	15:45:00	item LGU2W121MELA ไม่ได้ผูกกับ Location YUSEN	\N	2026-01-16
1102	PPCC รบกวนแก้ไข Tag PL260302-05-005 จาก Tag 25/ใบ เป็น1000/ใบ	PPCC รบกวนแก้ไข Tag PL260302-05-005 จาก Tag 25/ใบ\nเป็น1000/ใบ	medium	C	\N	14	2026-06-21 20:53:40.477565	2026-03-04 00:00:00	Oth	2026-03-04 00:00:00	Update Qty Tag	\N	\N	\N	14	SNPR	SNPR260301	\N	PPCC_PrintRMTag	\N	Customized	Human Error	wannisa kik👑	2026-03-04	11:30:00	\N	\N	2026-03-09
1162	แก้ไข Currency	รบกวนช่วยแก้ไข Currency จากTHB เป็น USD ให้หน่อยได้ไหมค่ะ เนื่องจากพึ่งตั้งVendor ใหม่แต่เลือกCurrency ผิดค่ะ	medium	C	\N	14	2026-06-21 20:53:40.598081	2026-01-09 00:00:00	Vendors	2026-01-09 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2601006	\N	PPCC_Vendors	\N	Customized	Human Error	K.Budsaya	2026-01-09	11:15:00	\N	\N	2026-01-14
1177	สอบถามเนื่องจาก Post เพิ่มหนี้ไม่ได้	เนื่องจากยอดใน SR69020027   ได้เบิ้ลไป รบกวนตรวจสอบในหน้า GL เนื่องจากยอดได้เปลี่ยนค่ะ\nรบกวนทางทีม PPCC ตรวจสอบการแก้ไข Transection ดังกล่าวค่ะ\n	medium	C	\N	14	2026-06-21 20:53:40.614132	2026-03-04 00:00:00	RMA	2026-03-04 00:00:00	1. ทำการปรับปรุงเพิ่มหนี้จากหน้าจอ Invoices, Debit and Credit Momos เพื่อให้ระบบบันทึกล้างยอดที่ทำ RMA เกิน\r\n2. Misc. Issue เอาของที่รับคืนเกินออก	\N	\N	\N	14	TAK	TAK2603002	\N	G/L Posted Transactions	\N	Customized	Human Error	K.Jittima	2026-03-02	17:15:00	RMA No. RMA6902022 มีการลดหนี้ 2 รายการ ซึ่งยอดเงินตรงกับที่ถูก Post ไป G/L แล้ว โดยปัญหานี้คาดว่าเกิดจาก User มีการแก้ไข Apply To Invoice โดยไม่ได้ลบข้อมูลที่ RMA Line Items ก่อน จึงทำให้เมื่อกดปุ่ม Link ไปหน้าจอ RMA Line หลังจากแก้ไข Apply To Invoice แล้วจึงไม่เห็นรายการที่สร้างไว้ก่อนลบ	\N	2026-03-09
1178	แก้ไขรายการ ในชุด เอ็กสารคั้งหนี้	แก้ไขรายการ ในชุด APV 87595 และ APV 87598\nขอบคุณคะ\nAPV 87595\n1.ใส่เลขที่ INV เป็น  INSI26020216\n2.ใส่วันที่เป็น 13/02/2026\n\nAPV87598\n1.แก้ไข Sale Tax เป็น 248.25 บาท	medium	C	\N	14	2026-06-21 20:53:40.614823	2026-03-04 00:00:00	AP	2026-03-04 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2603003	\N	PPCC APVoucherandAdjustments	\N	Localized	Human Error	K.Nattakan	2026-03-04	09:35:00	\N	\N	2026-03-09
1179	รบกวนแก้ไขเลขที่ Run Nember ลดหนี้	รบกวนแก้ไขเลขที่ Runnumber  SR69030002  รบกวนแก้ไขจากเดิม เป็น SR69030001 ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.61552	2026-03-06 00:00:00	RMA	2026-03-06 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2603004	\N	PPCC_RMAs	\N	Customized	Customized Bug	K.Jittima	2026-03-05	10:15:00	\N	\N	2026-03-10
1180	ยอดรายงานไม่ครบค่ะ	รบกวนช่วยดูเคสนี้ให้หน่อยค่ะ ยอดรายงานผลิต แสดงไม่ครบในหน้า job order	medium	C	\N	14	2026-06-21 20:53:40.61628	2026-03-06 00:00:00	SFC	2026-03-06 00:00:00	Insert ข้อมูล Lot T26020082720005 ที่ตาราง preassigned_lot	\N	\N	\N	14	TAK	TAK2603005	\N	TAK_Job Orders	\N	Customized	Unidentified	K.Naruedee	2026-03-05	10:35:00	ข้อมูล Lot T26020082720005 ไม่สร้างที่ตาราง preassigned_lot	\N	2026-03-10
1189	แก้ไขจำนวนเงิน Purch Amt และ Invoice Amt	รบกวนแก้ไข จำนวนเงินใน APV 88542 ก่อน Vat จาก  2,559.96  บาท  เป็น  2,560 บาท\n\nและ Invoice Amt จาก 2,739.16  บาท เป็น  2,739.20 บาท ตามเอกสารด้านล่างคะ	medium	C	\N	14	2026-06-21 20:53:40.623578	2026-04-03 00:00:00	AP	2026-04-03 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2604003	\N	PPCC_APVoucherandAdjustments	\N	Localized	Opening Balance	K.Nattakan	2026-04-03	09:10:00	\N	\N	2026-04-08
1075	รบกวนแก้ไขวันที่ INV. FA2602-023 (FROM 20/02/2025 to 18/02/2025)	รบกวนแก้ไขวันที่ และเลขที่  INV. ให้ด้วยนะค่ะ ขอบคุณมากค่ะ\nแก้ไขวันที่ จาก  20/02/2025  เป็น 18/02/2025.\n\nCUST. 7675\nSHIP.  103473\nINV.FA2602-023	medium	C	\N	14	2026-06-21 20:53:40.448034	2026-02-16 00:00:00	AR	2026-02-16 00:00:00	\N	\N	\N	\N	14	NTH	NTH2602003	\N	Invoices, Debit and Credit Memos	\N	Customized	Human Error	K.Nisakarn	2026-02-13	16:20:00	\N	\N	2026-02-18
1076	แก้ไข Exchange rate. ของ Canon Hi-Tech (6396) ให้หน่อยคะ	รบกวนแก้ไข Exchange rate ของ Canon Hi-Tech 6396 ให้หน่อยคะ\nฝากเช็คของทาง บัญชี และฝั่ง sale report VAT ให้ยอดตรงกับใน INVIOCE ด้วยนะคะ\n\nNY2603-002  เรท จาก 31.18 > เป็น 31.28\n\nPICK    106596\nSHIP    103790	medium	C	\N	14	2026-06-21 20:53:40.448787	2026-03-06 00:00:00	AR	2026-03-06 00:00:00	Update Database	\N	\N	\N	14	NTH	NTH2603001	\N	PPCC_Invoices Debit and Credit Memos	\N	Customized	Human Error	K.Chanisa	2026-03-05	09:20:00	\N	\N	2026-03-10
1077	รบกวนช่วยเช็คให้หน่อยค่ะ ว่าทำไมทำ consolidate invoice 17 co line แต่ consolidate invoicing ออกแค่ 5 co line.	รบกวนช่วยเช็คให้หน่อยค่ะ ว่าทำไมทำ consolidate invoice ไป 17 co line \nแต่ consolidate invoicing ออกแค่ 5 co line.\nPick # 106677\nShip # 103878\nTax Inv. # MT2603-026	medium	C	\N	14	2026-06-21 20:53:40.449465	2026-03-12 00:00:00	DO	2026-03-12 00:00:00	Insert ข้อมูลที่ไม่ถูก Post เข้า Invoice MT2603-026	\N	\N	\N	14	NTH	NTH2603002	\N	PPCC_Consolidate Invoicing	\N	Customized	Unidentified	K.Suladda	2026-03-10	13:55:00	\N	\N	2026-03-13
1079	NTH : แก้ไขวันที่  ของ THAI ARROW PRODUCTS (9929)	รบกวนแก้ไข INVOICE วันที่  20/03/2026  -  23/03/2026  \n\nINVOICE  TA2603-063\nPICK : 106940\nSHIP : 104134\nCUSTOMER : THAI ARROW PRODUCTS (9929)	medium	C	\N	14	2026-06-21 20:53:40.451076	2026-03-23 00:00:00	AR	2026-03-23 00:00:00	Update Database	\N	\N	\N	14	NTH	NTH2603004	\N	PPCC_Invoices Debit and Credit Memos	\N	Customized	Human Error	K.Chanisa	2026-03-20	23:25:00	\N	\N	2026-03-26
1080	รบกวนแก้ไขวันที่ INV. VJ2603-007 (FROM 26/03/2026 to 25/03/2026)	รบกวนแก้ไขวันที่ และเลขที่  INV. ให้ด้วยนะค่ะ ขอบคุณมากค่ะ\nแก้ไขวันที่ จาก  26/03/2026  เป็น  25/03/2026.\n\nCUST. 7327\nSHIP.  104144\nINV.VJ2603-007	medium	C	\N	14	2026-06-21 20:53:40.451902	2026-03-27 00:00:00	AR	2026-03-27 00:00:00	Update Database	\N	\N	\N	14	NTH	NTH2603005	\N	Invoices, Debit and Credit Memos	\N	Customized	Human Error	K.Nisakarn	2026-03-26	11:15:00	\N	\N	2026-03-31
1083	แก้ไขวันที่  ของ ELECTRONICS SOURCE (6311)	รบกวนแก้ไข INVOICE วันที่  05/05/2026  -  06/05/2026  \n\nINVOICE  ES2605-001\nPICK : 107448\nSHIP : 104636\nCUSTOMER : ELECTRONICS SOURCE (6311)	medium	C	\N	14	2026-06-21 20:53:40.455027	2026-04-28 00:00:00	AR	2026-04-28 00:00:00	Update Database	\N	\N	\N	14	NTH	NTH2604001	\N	Invoices, Debit and Credit Memos	\N	Customized	Human Error	K.Chanisa	2026-04-28	09:35:00	\N	\N	2026-05-01
1084	รบกวนช่วยแก้ไขวันที่ ใน Tax Inv. # MT2605-020 จาก 11/05/2026 เป็น 12/05/2026 ให้หน่อยค่ะ	รบกวนช่วยแก้ไขวันที่ ใน Tax Invoice # MT2605-020 จาก 11/05/2026 เป็น 12/05/2026 ให้หน่อยค่ะ	medium	C	\N	14	2026-06-21 20:53:40.455811	2026-05-13 00:00:00	AR	2026-05-13 00:00:00	Update Database	\N	\N	\N	14	NTH	NTH2605001	\N	Invoices, Debit and Credit Memos	\N	Customized	Human Error	K.Suladda	2026-05-11	15:50:00	\N	\N	2026-05-14
1086	รบกวนแก้ไขวันที่  INV. VJ2605-005 , VJ2605-006  (FROM  25/05/2026 to 26/05/2026)	รบกวนแก้ไขวันที่ และเลขที่  INV. ให้ด้วยนะค่ะ ขอบคุณมากค่ะ \nแก้ไขวันที่ จาก  25/05/2026  เป็น  26/05/2026.\n\nCUST. 7327\nSHIP.  105080\nINV.VJ2605-005\n\nCUST. 7327\nSHIP.  105087\nINV.VJ2605-006\n	medium	C	\N	14	2026-06-21 20:53:40.457879	2026-05-20 00:00:00	AR	2026-05-20 00:00:00	Update Database	\N	\N	\N	14	NTH	NTH2605003	\N	Invoices, Debit and Credit Memos	\N	Customized	Human Error	K.Nisakarn	2026-05-20	14:20:00	\N	\N	2026-05-25
1087	รบกวนแก้ไขวันที่  INV. VD2605-011 , VD2605-012  (FROM  25/05/2026 to 26/05/2026)	รบกวนแก้ไขวันที่ และเลขที่  INV. ให้ด้วยนะค่ะ ขอบคุณมากค่ะ \nแก้ไขวันที่ จาก  25/05/2026  เป็น  26/05/2026.\n\nCUST. 6388\nSHIP.  105078\nINV.VD2605-011\n\nCUST. 6388\nSHIP.  105088\nINV.VD2605-012	medium	C	\N	14	2026-06-21 20:53:40.459013	2026-05-20 00:00:00	AR	2026-05-20 00:00:00	Update Database	\N	\N	\N	14	NTH	NTH2605004	\N	Invoices, Debit and Credit Memos	\N	Customized	Human Error	K.Nisakarn	2026-05-20	14:25:00	\N	\N	2026-05-25
1109	cancel shipping list แล้วมารวบใหม่ ship label หายไป 31 ใบ รบกวนช่วยตรวจสอบให้หน่อยครับ	cancel shipping list แล้วมารวบใหม่ ship label หายไป 31 ใบ รบกวนช่วยตรวจสอบให้หน่อยครับ	medium	C	\N	23	2026-06-21 20:53:40.483695	2026-01-14 00:00:00	Automation	2026-01-14 00:00:00	Insert ข้อมูลเข้าตาราง ppcc_shipping_list_detail	\N	\N	\N	14	SRN	SRN2601005	\N	PPCC_Shipping List Data	\N	Customized	Customized Bug	K.Jintana	2026-01-14	09:45:00	\N	\N	2026-01-14
1184	ช่วงนี้มีปัญหาเรื่อง cal cost ถี่ค่ะ ระบบแคลแล้ว คอสไม่ขึ้นบ้างอะไรบ้าง	ช่วงนี้มีปัญหาเรื่อง cal cost ถี่ค่ะ ระบบแคลแล้ว คอสไม่ขึ้นบ้างอะไรบ้าง ครั้งก่อนก็เป็นมาครั้งนึง แต่เราก็เข้าใจว่าอาจจะเป็นเพราะเราพลาดเอง ตอนนี้มีเคสใหม่ค่ะ งาน ชุดนี้เงื่อนไขเท่ากันหมดแม้กระทั่ง qty อะไร เป็นสาเหตุให้ระบบ cal ออกมาแล้ว cost ไม่เท่ากันคะ\r\n\r\nแล้วการที่บางครั้ง ระบบ cal cost แล้ว ราคาไปไม่ถึง level 0\r\nเกิดจากอะไรได้บ้างคะ	medium	C	\N	18	2026-06-21 20:53:40.619519	2026-03-02 00:00:00	IC	2026-03-02 00:00:00	โดยที่เมื่อทำการแก้ไข Lot size แล้วรบกวนลองทำการลบ setup ที่หน้า current operation ออกแล้วใส่ใหม่อีกครั้ง จากนั้นค่อยทำการตรวจสอบ cost ใหม่ครับ\r\n\r\nสามารถเกิดจาก\r\n1. roll cost ไม่ผ่าน\r\n2. เกิดจาก low level ของ item ไม่ถูกต้องครับ โดยที่สามารถเรียกรายงาน Indent Current BOM Report เพื่อนำมาดูในส่วนของ low level ของ item ว่าถูกต้องหรือไม่ครับ\r\n3. อาจจะเกิดจากข้อมูลไม่ถูกต้องเหมือนครั้งก่อนครับก็คือรบกวนลองทำการแก้ไขข้อมูลเหมือนกับเคสครั้งก่อนหน้าครับ\r\n4. อาจจะเกิดจากการที่มีการผูก material ที่หน้า current material ก่อนแต่ item นี้ไม่ได้มีการกำหนด cost ครับ แล้วมาทำการกำหนด cost ภายหลังครับ\r\nกรณีนี้รบกวน ก่อนทำการโหลดข้อมูลรบกวนช่วยรีวิวในส่วนของ cost ก่อนทำการโหลดครับ	\N	\N	\N	18	TAK	TAK2603009	\N	Item Warehouse Cost	\N	Standard	Technical	May	2026-03-02	\N	ในส่วนของเคสนี้ก็คือเจอว่ามีการกำหนด Lot size ไม่เท่ากันครับเลยทำให้ cost ไม่เท่ากันครับ ซึ่งถ้าหากให้ WIP-PRN-APC03-ROL-PET-PT061R00 กับ WIP-PRN-APC03-ROL-PET-PT061R01 และ WIP-PRN-APC03-ROL-PET-PT061R02 เท่ากันต้องไปกำหนด Lot size ให้เท่ากันครับ	\N	2026-03-02
1089	LOAD CO เข้าไปแล้ว แต่ไม่โชว์ในหน้า PPCC_PickWorkBench	เรา LOAD CO ไปแล้วตามไฟล์แนบ ตอน LOAD เข้า ไม่มี error message ใดๆ แจ้งเตือนเลย\nแต่ไม่โชว์ในหน้า PPCC_PickWorkBench และเข้าไปเช็คใน หน้า CO LINE แล้วไม่เจอเลข CO\nรบกวนเช็คสาเหตุของปัญหาและวิธีแก้ปัญหาให้หน่อยนะคะ\n	medium	C	\N	14	2026-06-21 20:53:40.460838	2026-05-27 00:00:00	CO	2026-05-27 00:00:00	สร้าง Warehouse 7668 แล้ว Load CO ใหม่อีกครั้ง	\N	\N	\N	14	NTH	NTH2605006	\N	PPCC_Load Order	\N	Customized	Knowledge	K.Supata	2026-05-27	10:55:00	Item EM451400DXHK521E ไม่มี Warehouse 7668	\N	2026-06-01
1090	รบกวนแก้ไขวันที่  INV. FA2606-005 , FA2606-006 (FROM  10/06/2026 to 11/06/2026)	รบกวนแก้ไขวันที่ และเลขที่  INV. ให้ด้วยนะค่ะ ขอบคุณมากค่ะ \nแก้ไขวันที่ จาก  10/06/2026  เป็น  11/06/2026.\n\nCUST. 7675\nSHIP.  105400\nINV.FA2606-005\n\nCUST. 7675\nSHIP.  105433\nINV.FA2606-006	medium	C	\N	14	2026-06-21 20:53:40.462159	2026-06-10 00:00:00	AR	2026-06-10 00:00:00	Update Database	\N	\N	\N	14	NTH	NTH2606001	\N	Invoices, Debit and Credit Memos	\N	Customized	Human Error	K.Nisakarn	2026-06-08	17:00:00	\N	\N	2026-06-12
1185	รบกวนแก้ไขเลขที่ ใบเพิ่มหนี้	รบกวนตรวจสอบใบเพิ่มหนี้  DR69030003  แก้ไขเลขที่ Run Number  จากเดิม 69030003  เป็น DR69030001\nและตรวจสอบจำวนเงินในฟอร์มใบเพิ่มหนี้ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.62012	2026-03-25 00:00:00	AR	2026-03-25 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2603010	\N	PPCC_PriceAdjustmentInvoice	\N	Customized	Customized Bug	K.Jittima	2026-03-24	16:10:00	ในส่วนของรายงานยอดเงินหน่วยละคำนวณจาก Old Price – New Price ซึ่งเงื่อนไขการดึงข้อมูล Old Price จะดึง Unit Price จาก Customer Order Line มาคำนวณ แต่เนื่องจากปัจจุบัน CO CO69020343 Line #1 มีการแก้ไข Unit Price เป็น 0.72 ไปแล้ว ทำให้ยอดเงิน Old Price เท่ากับ New Price รายงานจึงแสดง 0	\N	2026-03-27
1186	รบกวนตรวจสอบใบเพิ่มหนี้  DR69030002  ตรวจสอบจำวนเงินในฟอร์มใบเพิ่มหนี้ค่ะ	รบกวนตรวจสอบใบเพิ่มหนี้  DR69030002  ตรวจสอบจำวนเงินในฟอร์มใบเพิ่มหนี้ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.621539	2026-03-27 00:00:00	AR	2026-03-27 00:00:00	แก้ไขเงื่อนไขการดึงข้อมูล Price และดึงรายงานส่งให้ User	\N	\N	\N	14	TAK	TAK2603011	\N	PPCC_PriceAdjustmentInvoice	\N	Customized	Customized Bug	K.Jittima	2026-03-25	11:35:00	ยอดเงินหน่วยละในรายงานคำนวณจาก Old Price – New Price ซึ่งเงื่อนไขการดึงข้อมูล Old Price จะดึง Unit Price จาก Customer Order Line มาคำนวณ แต่เนื่องจากปัจจุบัน CO. CO69020237 Line #1 มีการแก้ไข Unit Price เป็น 1.51 ไปแล้ว ทำให้ยอดเงิน Old Price เท่ากับ New Price รายงานจึงแสดง 0	\N	2026-03-30
1188	รบกวนแก้ไขเลขที่ Run number	เนื่องจากทางทีมบัญชีออกเพิ่มหนี้เพื่อ Ofset ใบลดหนี้ SR69030028\nแต่เลขที่ Run number ไม่ถูกต้อง รบกวนแก้ไขเลขที่ Runnumber เป็น DR69030003	medium	C	\N	14	2026-06-21 20:53:40.622965	2026-04-03 00:00:00	AR	2026-04-03 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2604002	\N	PPCC_PriceAdjustmentInvoice	\N	Customized	Customized Bug	K.Jittima	2026-04-03	08:55:00	\N	\N	2026-04-08
1216	PPCC APVouchersandAdjustments	Voucher 161059 Exch Rate ไม่ขึ้น รบกวนแก้ไขให้ได้ไหมคะ วันที่ 22/05/2026	medium	C	\N	14	2026-06-21 20:53:40.663068	2026-05-28 00:00:00	AP	2026-05-28 00:00:00	Update Database	\N	\N	\N	14	TTSC	TTSC260501	\N	PPCC APVouchersandAdjustments	\N	Localized	Human Error	KASSARIN	2026-05-27	14:20:00	User ตั้ง Currency Rate เป็น 1	\N	2026-05-27
1191	รบกวนแก้ไขเลขที่ Run number	รบกวนลบเลขที่ใบลดหนี้ SR69040001-5  เนื่องจากเกิดขึ้นในระบบเอง  ไม่ได้ใช้ในการลดหนี้ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.625164	2026-04-03 00:00:00	AR	2026-04-03 00:00:00	ลบใบลดหนี้ SR69040001- SR69040006	\N	\N	\N	14	TAK	TAK2604005	\N	PPCC_InvoicePosting	\N	Customized	Human Error	K.Jittima	2026-04-03	11:40:00	\N	\N	2026-04-08
1192	กรอก ประเภทของการหัก ณ ที่จ่าย	รบกวรกรอกประเภท ของการหัก ณ ที่จ่าย เป็น ค่าขนส่ง ในกรอบสีแดง	medium	C	\N	14	2026-06-21 20:53:40.62578	2026-04-08 00:00:00	AP	2026-04-08 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2604006	\N	PPCC_Withholding Tax Certificate	\N	Standard	PPCC Localized	K.Nattakan	2026-04-06	09:10:00	\N	\N	2026-04-10
1193	แก้ไขรายงาน ภาษีซื้อ	รบกวนแก้ไข รายงานภาษีซื้อ ตามไฟล์แนบคะ	medium	C	\N	14	2026-06-21 20:53:40.626392	2026-04-08 00:00:00	AR	2026-04-08 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2604007	\N	PPCC_Input Vat Report	\N	Localized	Opening Balance	K.Nattakan	2026-04-06	08:15:00	\N	\N	2026-04-10
1091	รบกวนแก้ไขวันที่  INV. PI2606-007 (FROM  09/06/2026 to 10/06/2026)	รบกวนแก้ไขวันที่ และเลขที่  INV. ให้ด้วยนะค่ะ ขอบคุณมากค่ะ \nแก้ไขวันที่ จาก  09/06/2026  เป็น  10/06/2026.\n\nCUST. 6317\nSHIP.  105432\nINV.PI2606-007\n	medium	C	\N	14	2026-06-21 20:53:40.463174	2026-06-10 00:00:00	AR	2026-06-10 00:00:00	Update Database	\N	\N	\N	14	NTH	NTH2606002	\N	Invoices, Debit and Credit Memos	\N	Customized	Human Error	K.Nisakarn	2026-06-08	17:05:00	\N	\N	2026-06-12
1092	ช่วยแก้ไข stock  VMI ของ p/n UUD1C471MNLZMLGS ให้หน่อยค่ะ ในช่อง Asigned to be pick ควรจะเป็น 0 แต่มันมียอดโชว์ 500 ทำให้ไม่สามารถเลือกจำนวนนี้ในหน้า pick workbench ได้	ช่วยแก้ไข stock  VMI ของ p/n UUD1C471MNLZMLGS ให้หน่อยค่ะ ในช่อง Asigned to be pick ควรจะเป็น 0 แต่มันมียอดโชว์ 500 ทำให้ไม่สามารถเลือกจำนวนนี้ในหน้า pick workbench ได้	medium	C	\N	14	2026-06-21 20:53:40.464152	2026-06-10 00:00:00	Shipment	2026-06-10 00:00:00	Update Asigned To Be Pick ของ Location VMI เป็น 0	\N	\N	\N	14	NTH	NTH2606003	\N	PPCC_Pick Workbench	\N	Customized	Human Error	K.Dararat	2026-06-09	09:25:00	\N	\N	2026-06-11
1182	แก้ไขรายงาน ภาษีซื้อ	แก้ไขรายงานภาษีซื้อ ตามไฟล์แนบ	medium	C	\N	14	2026-06-21 20:53:40.61798	2026-03-12 00:00:00	AR	2026-03-12 00:00:00	\N	\N	\N	\N	14	TAK	TAK2603007	\N	PPCC_Input Vat Report	\N	Localized	PPCC Localized	K.Nattakan	2026-03-11	09:45:00	\N	\N	2026-03-16
1195	ย้าย รายงาน จาก ภ.ง.ด 53 เป็น ภ.ง.ด 3	รบกวน ย้ายรายการ ในรายงาน บรรทัด  ที่ 10 ไป อยู่ในรายงาน ภ.ง.ด 3 และ รบกวนแก้ไข ใบหัก ณ ที่จ่าย เป็น ภ.ง.ด 3 ทีคะ	medium	C	\N	14	2026-06-21 20:53:40.627906	2026-04-08 00:00:00	AP	2026-04-08 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2604009	\N	PPCC_Withholding Tax Certificate	\N	Localized	PPCC Localized	K.Nattakan	2026-04-06	09:35:00	\N	\N	2026-04-10
1196	ตรวจสอบให้ที่ครับยอดหายครับ	ตรวจสอบให้ที่ครับยอดหายครับน้องหน้างานบอกว่าเบิกของลงมาแล้วหายอดในระบบไม่มีครับมีเลข 260400000000001/ 260400000000002 / 260400000000003 / 260400000000004 / 2604000000000006  ร้วม 5 ม้วนครับ	medium	C	\N	14	2026-06-21 20:53:40.628578	2026-04-20 00:00:00	IC	2026-04-20 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2604010	\N	Item Lot Locations	\N	Customized	Customized Bug	K.Ya Pa	2026-04-17	08:35:00	\N	\N	2026-04-22
1198	ยอด diff ทั้งด้าน dr 2,016.42 และ cr  2,016.41	รบกวนตรวจสอบเคสนี้ให้ด้วยครับ ทาง TG มีการขายเศษวัสดุ ราคา 2,016.40 บาท RUN invoice ผ่าน job co F260000001 ได้ INV NO. FDIN02600004 วันที่ 7-1-26  เมื่อมา post gl หน้า invoice credit note debit note พบว่า\nยอด diff ทั้งด้าน dr 2,016.42 และ cr  2,016.41  ซึ่งยอดใน INVOICE ถูกต้องแล้ว voucher ควรจะเป็นเหมือน INVOICE  ยอดก่อน vat  1,884.49 ยอด vat 131.91 ยอดรวม vat  2,016.40\n	medium	C	\N	14	2026-06-21 20:53:40.633154	2026-01-08 00:00:00	AR	2026-01-08 00:00:00	Update Database	\N	\N	\N	14	TG	TG26010002	\N	PPCC_AR Invoice Voucher Report	\N	Application Support	PPCC Localized	K.Nattakit	2026-01-07	17:15:00	ระบบคำนวณโดยปัดทศนิยม Price	\N	2026-01-13
1217	PO Dist	รบกวนช่วยแก้ไขวันที่ ให้หน่อยได้ไหมคะ เนื่องจากใส่เดือนผิด รายละเอียดตามไฟล์แนบ	medium	C	\N	14	2026-06-21 20:53:40.664832	2026-06-04 00:00:00	GL	2026-06-04 00:00:00	Update Database	\N	\N	\N	14	TTSC	TTSC260502	\N	Journal Entries	\N	Standard	Human Error	KASSARIN	2026-05-30	08:30:00	\N	\N	2026-06-04
1201	เรียกรายงานเป็น Excel เมนูPPCC Vendor	เมนู PPCC Vendor เรียกรายงาน เป็น Excel  แล้ว แต่ ช่อง TAX ID ตัวเลขมาไม่ครบ มีวิธีดึงรายงานออกมาให้ตัวเลขครบไหมคะ \n \nTax ID\n1.1555E+11\n1.07537E+11\n1.05555E+11\n	medium	C	\N	19	2026-06-21 20:53:40.636682	2026-01-12 00:00:00	Vendors	2026-01-12 00:00:00	แปลง Format ของ Column เป็น Text หรือใช้สูตร =TEXT(Column,"0000000000000")	\N	\N	\N	14	TTSC	TTSC260101	\N	PPCC_Vendors	\N	Application Support	Knowledge	KASSARIN	2026-01-09	14:55:00	เป็นปัญหาของ Excel	\N	2026-01-14
1203	TTSC รบกวนกู้คืน INV260100606	TTSC รบกวนกู้คืน INV260100606 กลับมาให้หน่อยค่ะ	medium	C	\N	14	2026-06-21 20:53:40.638247	2026-01-19 00:00:00	DO	2026-01-19 00:00:00	ทาง User ต้องสร้าง DO ใหม่และทาง PPCC ทำการแก้ไขเลขที่ DO เป็น INV260100606	\N	\N	\N	14	TTSC	TTSC260103	\N	PPCC Delivery Orders	\N	Customized	Human Error	Yasinee	2026-01-16	14:00:00	เนื่องจาก INV260100606 ถูกลบออกจากระบบไปแล้วทำให้ไม่สามารถกู้คืนได้	\N	2026-01-21
1197	ERP TG : Error Mass Journal Posting	รบกวนตรวจสอบและแก้ไข Error ตามรูปภาพด้านล่างให้ด้วยค่ะ เนื่องจากจังหวะการ Post GL ที่ ERP TG เจอ Error เกี่ยวกับ Next Key ตามรูปภาพด้านล่างค่ะ\nError Programmer Error: Transaction must be in effect to call InsertNewKeySp	medium	O	\N	14	2026-06-21 20:53:40.629668	2026-06-21 20:53:40.629668	GL	2026-01-12 00:00:00	เบื้องต้นให้ User ใช้หน้าจอ PPCC LedgerPostingForJournal แทนไปก่อนเพื่อให้ปิดบัญชีได้	\N	\N	\N	14	TG	TG26010001	\N	PPCC_Mass Journal Posting	\N	Customized	Customized Bug	K.Sirinat	2026-01-05	09:00:00	ข้อมูลถูกติ๊ก Reverting จึงไม่สามารถ Post ผ่านหน้าจอ PPCC_Mass Journal Posting ได้	\N	2026-01-06
1094	ตรวจสอบ CN แล้วมี Popup แจ้ง	รบกวนตรวจสอบเคสนี้ให้ด้วยครับ เนื่องจาก Post ที่หน้า PPCC_Confirm Print Invoice_A4 แล้วแจ้ง Popup นี้ ที่ site PK ครับ	medium	C	\N	14	2026-06-21 20:53:40.466795	2026-01-23 00:00:00	AR	2026-01-23 00:00:00	แก้ไขโดยจังหวะ Insert ข้อมูลที่หน้าจอ Invoices Debit and Credit Memos ให้ลงตาม Type ที่ทำรายการ และเมื่อ Insert สำเร็จแล้วกรณีที่ทำรายการลดหนี้ (Credit Note) จะทำการ Update Type กลับเป็น Invoice	\N	\N	\N	14	PK	PK26010001	\N	PPCC_Confirm Print Invoice_A4	\N	Customized	Customized Bug	K.Nattakit	2026-01-22	13:50:00	จังหวะ Insert ข้อมูลที่หน้าจอ Invoices Debit and Credit Memos ด้วย Type Invoice แต่ Last Invoice Number ของ Type Invoice เป็นค่า NULL ระบบจึงไม่ยอมให้ทำรายการ	\N	2026-01-27
1096	ปรึกษาเคส Patkol Food : ปัญหารายการ Reverse เล่ม CA , ADJ ( Type :User)  ไม่แปะ GL Note ค่ะ	ปรึกษาเคส Patkol Food : ปัญหารายการ Reverse เล่ม CA , ADJ ( Type :User)  ไม่แปะ GL Note ค่ะ  ไล่เช็คข้อมูลเบื้องต้น เกิดประมาณช่วง 11/2018  ส่วน site อื่นลองทดสอบแปะข้อมูลปกติ ทาง PPCC พอจะตรวจสอบให้ได้มั้ยคะ	medium	C	\N	14	2026-06-21 20:53:40.46907	2026-03-10 00:00:00	GL	2026-03-10 00:00:00	แก้ไขโปรแกรม+Test	\N	\N	\N	14	PKF	PKF2602001	\N	PPCC_Mass Journal Posting	\N	Customized	Customized Bug	K.Mewadee	2026-02-17	13:35:00	จังหวะสร้างข้อมูล Reverse ไม่ได้นำข้อมูล UET Field ไปบันทึกด้วย	Coding = 1\r\nTest = 0.5	2026-03-13
1123	สร้าง Item ใหม่แต่ Email อนุมัติไม่ส่ง	สร้าง Item ใหม่แต่ Email อนุมัติไม่ส่ง	medium	C	\N	\N	2026-06-21 20:53:40.536077	2026-03-09 00:00:00	EVM	2026-03-09 00:00:00	\N	\N	\N	\N	14	SRN	SRN2602013	\N	PPCC_Items	\N	Customized	Technical	K.Jutathip	2026-02-23	13:35:00	\N	วันที่ 09/03/2026 SA ลองทดสอบสร้าง Item ใหม่ User แจ้งว่าได้รับ Email ให้อนุมัติ	2026-03-12
1204	ADD BOM	รบกวนของข้อมูล Manual Add Bom ในระบบครับ	medium	C	\N	18	2026-06-21 20:53:40.639096	2026-01-15 00:00:00	BOM	2026-01-15 00:00:00	เอกสารของการ Manual Add Bom ครับ	\N	\N	\N	18	TTSC	TTSC260104	\N	Item	\N	Standard	Knowledge	Panyapon	2026-01-15	\N	\N	\N	2026-01-15
1202	Purchase Price Variance	ต้องการทราบสาเหตุ ที่เกิดบัญชี 9100-5 Purchase Price Variance เนื่องจากรับ Item 35023-0532 เข้าระบบ วิ่งเข้า GL Code 9100-5 ทั้งก้อน ไม่วิ่งเข้า Finished Goods ราคารับเข้า 61.81 บาท	medium	O	\N	15	2026-06-21 20:53:40.637417	2026-06-21 20:53:40.637417	Item	2026-01-20 00:00:00	\N	\N	\N	\N	14	TTSC	TTSC260102	\N	items	\N	Standard	Knowledge	KASSARIN	2026-01-15	11:40:00	เกิดจากรหัส Item 35023-0532 ถูกกำหนด Cost Type = Standard , Cost Method = Standard และเมื่อมีการตรวจสอบที่หน้าจอ Item cost พบว่า Standard cost = 0 บาท ระบบจึงบันทึกบัญชี Finished Good = 0 แล้วผลต่างระหว่าง Standard cost กับยอดตั้งหนี้  จึงลงบัญชี Purchase Price Variance	\N	2026-01-20
1097	รบกวนตรวจสอบ Preview invoice หน้า ServiceTax	รบกวนตรวจสอบ Preview invoice หน้า ServiceTax  พบว่าราคาก่อน Vat ไม่ถูกต้อง inv. CIIN02600005  เหมือนระบนำ Total ก่อน Vat  *  total Qty = 4  ได้ยอด 38,800 ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.470393	2026-03-16 00:00:00	AR	2026-03-16 00:00:00	แก้ไขเงื่อนไขการดึงข้อมูลจำนวนเงินทั้งสิ้นก่อนหักส่วนลดคำนวณ	\N	\N	\N	14	PKF	PKF2603001	\N	PPCC_AR Tax Invoice and Receive Service Report A4	\N	Customized	Customized Bug	K.Mewadee	2026-03-16	13:45:00	จำนวนเงินทั้งสิ้นก่อนหักส่วนลดคำนวณจากยอด Sum ของ Inv Amount ซึ่ง Inv Amount ดึงมาด้วยยอด 9700	\N	2026-03-19
1098	รบกวนนำ tagงานเศษ  เข้าระบบให้หน่อยค่ะ และลบข้อมูล Tag SNPR-0226010586 เพื่อจะรวมเศษใหม่ และใช้Lotเดิม	รบกวนนำ tagงานเศษ  เข้าระบบให้หน่อยค่ะ\nและลบข้อมูล Tag SNPR-0226010586\nเพื่อจะรวมเศษใหม่ และใช้Lotเดิม	medium	C	\N	14	2026-06-21 20:53:40.472867	2026-01-23 00:00:00	Automation	2026-01-23 00:00:00	Update Field flag = 1 ที่ตาราง ppcc_fraction_bal และลบข้อมูล Tag ที่นำไปรวมเศษแล้วออกจากตาราง PPCC_tmp_fractiontag	\N	\N	\N	14	SNPR	SNPR260101	\N	Print Tag FG	\N	Customized	Human Error	wannisa kik👑	2026-01-23	09:30:00	ยกเลิกเศษเพื่อจะนำมารวมใหม่ แต่ระบบบไม่ขึ้น Tag เศษให้เลือก	\N	2026-01-28
1099	รบกวนแก้ไข Job J226010188  ก่อนหน้านี้กดรวมเศษ แล้วเข้าเบิ้ล2รอบ จึงถอยงานออกแล้วยกเลิกรวมเศษ แต่Tagไม่ขึ้นค่ะ	รบกวนแก้ไข Job J226010188 \nก่อนหน้านี้กดรวมเศษ แล้วเข้าเบิ้ล2รอบ จึงถอยงานออกแล้วยกเลิกรวมเศษ แต่Tagไม่ขึ้นค่ะ	medium	C	\N	14	2026-06-21 20:53:40.474427	2026-01-23 00:00:00	Automation	2026-01-23 00:00:00	Update Field flag = 1 ที่ตาราง ppcc_fraction_bal และลบข้อมูล Tag ที่นำไปรวมเศษแล้วออกจากตาราง PPCC_tmp_fractiontag และลบข้อมูล Tag ตาราง ppcc_mv_trans และลบข้อมูล Tag ตาราง ppcc_mv_trans	\N	\N	\N	14	SNPR	SNPR260102	\N	Print Tag FG	\N	Customized	Human Error	wannisa kik👑	2026-01-23	10:50:00	\N	\N	2026-01-28
1100	PPCC ช่วยยกเลิกรวมเศษ Job J226020431 ให้หน่อยค่ะ กดยกเลิกไปแล้วแต่เศษยังอยู่	PPCC ช่วยยกเลิกรวมเศษ Job J226020431 ให้หน่อยค่ะ กดยกเลิกไปแล้วแต่เศษยังอยู่	medium	C	\N	14	2026-06-21 20:53:40.475274	2026-02-12 00:00:00	Automation	2026-02-12 00:00:00	Update Field flag = 0 ที่ตาราง ppcc_fraction_bal และลบข้อมูล Tag ที่นำไปรวมเศษแล้วออกจากตาราง PPCC_tmp_fractiontag	\N	\N	\N	14	SNPR	SNPR260201	\N	Print Tag FG	\N	Customized	Human Error	wannisa kik👑	2026-02-12	11:35:00	\N	\N	2026-02-17
1174	ยอด Scrap ไม่ถูกต้องค่ะ	รบกวนช่วยดูเคสนี้ให้หน่อยค่ะ ยอด Scrap ไม่ถูกต้องค่ะ ที่หน้า Job order	medium	C	\N	14	2026-06-21 20:53:40.610825	2026-02-26 00:00:00	SFC	2026-02-26 00:00:00	นำข้อมูล Scrap เข้าระบบ	\N	\N	\N	14	TAK	TAK2602006	\N	Job Orders	\N	Customized	Customized Bug	K.Naruedee	2026-02-23	08:25:00	\N	\N	2026-02-26
1205	ADD BOM	Code Item ที่หาจากใน ITEM แต่ไม่เจอ ใน เมนู  Current Materials\r\n\r\nรบกวนตรวจสอบให้ด้วยครับเนื่องจากจะ ADD BOM เข้าไปในระบบ\r\n	medium	C	\N	18	2026-06-21 20:53:40.640179	2026-01-16 00:00:00	BOM	2026-01-16 00:00:00	จากที่ได้คุยและสอบถามเพิ่มเติมครับก็คือ Item ที่แจ้งมายังไม่ได้มีการสร้างไว้ในหน้า Current Material จึงทำให้ค้นหาในหน้า Current Material ไม่เจอครับ ในกรณีนี้ต้องทำการสร้าง Current Material ของแต่ละ Item ก่อนครับ \r\nโดยการที่กด New และระบุรหัส Item ที่แจ้งมาเป็น Item ที่จะใช้ในการผลิตและกำหนด Material ที่ใช้ครับ จากนั้นทำการกด Save และเมื่อทำการค้นหาในหน้า Current Material จึงจะเจอครับ	\N	\N	\N	18	TTSC	TTSC260105	\N	Current Material	\N	Standard	Knowledge	Panyapon	2026-01-16	\N	\N	\N	2026-01-16
1218	แจ้งปัญหาการแสดงข้อมูล Job Order ในระบบ ERP ค่ะ	รบกวนทาง PPCC ช่วยดำเนินการถอย Job No. RC26040002 – RC26040006 ตามรายการที่ระบุในเอกสารแนบ ได้หรือไม่ครับ	medium	C	\N	17	2026-06-21 20:53:40.666476	2026-06-08 00:00:00	SFC	2026-06-08 00:00:00	\N	\N	\N	\N	14	TTSC	TTSC260601	\N	Job Orders	\N	Standard	Human Error	K.Pongpisut	2026-06-04	09:45:00	\N	\N	2026-06-11
1207	INV260100672	รบกวนตรวจสอบค่ะ  INV260100672 บัญชีดึงมาตั้งหนี้ และโพส แล้ว\nแต่จำนวนเงิน ไม่ตรงกันค่ะ  Vat 7% ในรายงานภาษีไม่แสดงค่ะ	medium	C	\N	14	2026-06-21 20:53:40.644417	2026-01-28 00:00:00	AR	2026-01-28 00:00:00	แก้ไขยอดเงินภาษีของ Invoice INV260100672 ในระบบจาก 0 เป็น 363.90 และเพิ่มรายการขาบัญชี 2200-1 Out Put Vat ที่ Journal Entries	\N	\N	\N	14	TTSC	TTSC260107	\N	Slaes Tax Report	\N	Standard	Human Error	Amporn	2026-01-28	11:35:00	ตอนแรก CO KMTN260123 ใช้ Tax Code EXC จึงทำให้ Invoice INV260100672 ถูกบันทึกด้วย Tax Code EXC หลังจากนั้นเวลา 17.05 น. User ได้ทำการแก้ไข Tax Code จาก EXC เป็น VAT7	\N	2026-02-02
1208	รบกวนทาง PPCC ช่วยถอย GRN เลขที่ S26011574 ค่ะ เนื่องจากมีการคีย์รับผิด PO ค่ะ	รบกวนทาง PPCC ช่วยถอย GRN เลขที่ S26011574 ค่ะ เนื่องจากมีการคีย์รับผิด PO ค่ะ\n\nทางบัญชีมีดึงไปแล้ว จึงทำให้ถอยไม่ได้ค่ะ	medium	C	\N	15	2026-06-21 20:53:40.645877	2026-01-29 00:00:00	PO	2026-01-29 00:00:00	แนะนำขั้นตอนการถอย GRN ที่ถูกตั้งหนี้ไปแล้วให้กับ User	\N	\N	\N	14	TTSC	TTSC260108	\N	PPCC_Purchase Order Receiving	\N	Standard	Knowledge	Natsaranphorn	2026-01-28	15:35:00	\N	\N	2026-02-03
1209	รบกวนทาง PPCC ช่วยถอย GRN เลขที่ S26011574 ค่ะ เนื่องจากมีการคีย์รับผิด PO ค่ะ	ทำขั้นตอน Adjustment แต่ตัวเลขไม่มาคะ  รบกวนตรวจสอบ และแก้ไขให้หน่อยได้ไหมคะ	medium	C	\N	14	2026-06-21 20:53:40.646624	2026-01-29 00:00:00	PO	2026-01-29 00:00:00	ลบ Adjustment 157797 ยอดเงิน 0 ออกจากระบบและทำ Adjustment 157797 ใหม่	\N	\N	\N	14	TTSC	TTSC260109	\N	Generate A/P Transactions	\N	Standard	Human Error	KASSARIN	2026-01-29	08:55:00	User ไม่ได้เลือก PO ที่ต้องการถอยที่ Tab PO Selection และไม่ได้สร้างข้อมูล Tax Code ที่ Tab Taxes ทำให้พอกดปุ่ม Generate Adjustment ยอดเงินจึงเป็น 0	\N	2026-02-03
1210	รบกวนช่วยกู้คืน INV260200268	รบกวนช่วยกู้คืน  Invoice เลขที่ INV260200268 ให้หน่อยค่ะ	medium	C	\N	14	2026-06-21 20:53:40.647552	2026-02-10 00:00:00	DO	2026-02-10 00:00:00	แก้ไข DO INV260200384 เป็น INV260200268	\N	\N	\N	14	TTSC	TTSC260201	\N	PPCC_Delivery Orders	\N	Customized	Human Error	Yasinee	2026-02-09	16:35:00	\N	\N	2026-02-12
986	ขอตัว add in ทีค่ะ ไม่รู้หายไปไหน	ขอตัว add in ทีค่ะ ไม่รู้หายไปไหน	medium	C	\N	\N	2026-06-21 20:53:40.329044	2026-06-10 00:00:00	GL	2026-06-10 00:00:00	ไป Eanble และ Active กลับมา	\N	\N	\N	14	ADI	ADI2606001	\N	Excel Add In	\N	Tech	Technical	K.Tarn	2026-06-10	10:30:00	Add-In ถูก Disable ไว้	\N	2026-06-15
1212	ขอให้ดึงข้อมูลกลับมา No. PV2603025#	รบกวนขอให้ดึงข้อมูลกลับมาเหมือนเดิมค่ะ ที่รายการจ่าย PV2603025 \n\nE000020\tE AND V. CO., LTD.\t0\tManual Check\t2603025\t0\tStandard Check\t10/03/2026\tMHS\tMizuho Bank S/A\tฉากกั้นห้อง PVC ใต้บันไดตึก VR\tPV2603025#\tTHB\t1,124.00\t1,124.00\n	medium	C	\N	14	2026-06-21 20:53:40.651427	2026-03-10 00:00:00	AP	2026-03-10 00:00:00	สร้างข้อมูลผ่านหน้าจอ PPCC_AP Payments	\N	\N	\N	14	TTSC	TTSC260302	\N	PPCC_AP Payments	\N	Localized	Human Error	Amporn	2026-03-10	15:45:00	\N	\N	2026-03-13
1213	ขอให้แก้ไข วันที่ ค่ะ	ตามไฟล์แนบมานี้  รบกวนขอให้แก้ไขวันที่ ดึงมาตั้งหนี้  จากวันที่ 30/04/2026  เป็นที่ถูกต้อง คือ 30/03/2026 ให้หน่อยค่ะ	medium	C	\N	14	2026-06-21 20:53:40.655014	2026-04-03 00:00:00	AR	2026-04-03 00:00:00	Update Database	\N	\N	\N	14	TTSC	TTSC260401	\N	PPCC_AR Invoice Voucher Report	\N	Localized	PPCC Localized	Amporn	2026-04-01	11:10:00	\N	\N	2026-04-06
1215	TTSC to PPCC แจ้งเปิด Job orders พอกด save ไม่ได้ค่ะ	User แจ้งว่า เปิด Job order พอกด save ขึ้นหน้าแจ้งเตือน แบบในรูปค่ะ	medium	C	\N	18	2026-06-21 20:53:40.661371	2026-05-05 00:00:00	SFC	2026-05-05 00:00:00	ทำการ Roll Current Cost to Standard Cost เฉพาะ Item : 55028-0930 51A	\N	\N	\N	14	TTSC	TTSC260403	\N	Job order	\N	Standard	Knowledge	K.Kamolrat	2026-04-30	16:30:00	Item : 55028-0930 51A ยังไม่ได้ทำการ Roll Current Cost to Standard Cost	\N	2026-05-05
1211	ทำรายการในหน้า PPCC Order Shipping แล้วมี Error และหน้า PPCC Customer Order Lines user ต้องการแก้ไข วันที่ Dur Date แล้วมี Error	1.รบกวนช่วยตรวจสอบ User ทำรายการในหน้า PPCC Order Shipping แล้วมี Error ขึ้นมาตามภาพครับ\nError PostShipCleanUp: Conversation from string "" to type 'Decimal'\n\n2.และในหน้า PPCC Customer Order Lines user ต้องการแก้ไข วันที่ Due Date แล้วมี Error ครับ\nError A. NET Framework error occurred during exeution of user-defined routine or aggregate "FireEventSp"	medium	C	\N	\N	2026-06-21 20:53:40.648951	2026-03-06 00:00:00	CO	2026-03-06 00:00:00	Restart Server	\N	\N	\N	14	TTSC	TTSC260301	\N	PPCC_Order Shipping	\N	Tech	Technical	PHOOMSIT	2026-03-06	09:00:00	\N	\N	2026-03-06
973	ช่วยทำให้ หน้า RMA Status Report ช่อง Total Credit 1,062,001.64 ของ RT25000731 ให้เท่ากับ Amt.(THB) ของ AR - Invoice Voucher ได้มั้ยคะ	ช่วยทำให้ หน้า RMA Status Report ช่อง Total Credit 1,062,001.64 ของ RT25000731 ให้เท่ากับ Amt.(THB) ของ AR - Invoice Voucher ได้มั้ยคะ	medium	C	\N	14	2026-06-21 20:53:40.301039	2026-01-12 00:00:00	RMA	2026-01-12 00:00:00	แก้ไขไม่ได้เนื่องจาก RMA Status Report เป็นรายงาน Standard	\N	\N	\N	14	ADI	ADI2601001	\N	RMA Status Report	\N	Standard	Standard Bug	K.Natthakan	2026-01-09	15:10:00	หลักการคำนวณของรายงาน RMA Status Report กับรายงาน PPCC ไม่เหมือนกัน	\N	2026-01-14
993	สอบถาม ข้อมูล CN2604001 ค่ะ	เนื่องจากทาง ASP มีความประสงค์สอบถามเกี่ยวกับการดูข้อมูลย้อนหลังเลขที่ CN26040001 ว่าสามารถเปิดไฟล์เรียกดูเอกสารได้หรือไม่  เนื่องจาก\n\nตอนแรกนั้นทาง ASP ได้ทำการเปิดเอกสารCN26040001 และเกิดความเข้าใจผิด จึงได้ทำการลบข้อมูล CN ออกจากระบบ Syteline  หลังจากนั้น ทาง ASP จะมาทำการเปิดเอกสารใหม่อีกครั้งแต่ทำไม่ได้แล้ว เนื่องจากได้ดึงข้อมูลมาทำแล้ว\n\nจึงอยากให้ทาง PPCC เช็คข้อมูลแก้ไขปัญหา สอบถามว่า\n\nสามารถดึงข้อมูล CN2604001 ขึ้นมาใหม่ได้หรือไม่   \nถ้าดึงข้อมูลเก่าไม่ได้ ทาง ASP สามารถเปิด CN ใหม่โดยที่ไม่กระทบกับยอดในระบบ ได้หรือไม่	medium	C	\N	15	2026-06-21 20:53:40.345628	2026-05-05 00:00:00	RMA	2026-05-05 00:00:00	- ไม่สามารถดึงข้อมูลขึ้นมาใหม่ได้ค่ะเนื่องจากมีการลบข้อมูลไปแล้ว - ทาง ASP สามารถเปิด CN ใหม่ได้ โดยที่จะไม่กระทบกับยอดในระบบค่ะ	\N	\N	\N	14	ART	ART2604005	\N	RMAs	\N	Standard	Knowledge	ASP	2026-04-30	08:25:00	\N	\N	2026-05-05
995	ASP_รบกวนช่วยแก้ไข User ทำผิดพลาด	User ทำการยิง Tag ALUMINIUM แล้วไปกดโดนปุ่ม Select All แล้วกด Process ทำให้มีรายการเบิกไปทั้งหมด 6/6/2026 JOB: L026060002-0000 ตามไฟล์แนบให้ครับ\nรบกวนช่วยแก้ไขรายการทั้งหมดที่ user ทำผิดไปกลับมาทีครับ	medium	C	\N	19	2026-06-21 20:53:40.348825	2026-06-10 00:00:00	SFC	2026-06-10 00:00:00	ถอยรายการที่ทำผิด	\N	\N	\N	14	ART	ART2606001	\N	Job Material Transactions	\N	Standard	Human Error	K.เอี้ยม	2026-06-09	10:10:00	\N	\N	2026-06-12
998	invoice generation ได้ แค่ข้อมูลไม่มาค่ะ	รบกวนดู INV. (CCH) ให้ด้วยนะคะ ทางเรา generation ได้นะคะ แต่ มาเช็คที่ invoices debit and credit memos ไม่มีข้อมูลมาค่ะ รบกวนเช็คให้หน่อยนะคะ (เอกสารตามที่แนบนะคะ)	medium	C	\N	14	2026-06-21 20:53:40.353836	2026-02-04 00:00:00	AR	2026-02-04 00:00:00	Update Last Invoice D0028340	\N	\N	\N	14	CCH	CCH2602001	\N	Invoices, Debit and Credit Memos	\N	Customized	Human Error	K.Pornnipa	2026-02-03	11:05:00	Last Invoice ที่หน้าจอ Invoice Debit and Credit Memo Sequences เป็นค่า D6901136 จึงทำให้ Next Invoice จะเป็น D6901137 แต่เนื่องจาก Invoice D6901137 มีอยู่แล้วในระบบจึงทำให้ Post DO ไม่สำเร็จ	User ลบ Invoice Debit and Credit Memo Sequences	2026-02-06
1000	Project Invoice Miles.	User ทางฝั่ง CCH แจ้ง มาว่า ทำ Project Invoice Miles. ที่จะหักมัดจำที่เป็น Include Vat  เข้ามา ไม่ได้ ฟ้องดังรูป ตั้งแต่ทำมา ยังไม่เคยมี Case ทำ Invlude Vat เลยไม่แน่ใจ ว่าเกิดจาก  User หรือ ไม่เข้าใจระบบ ว่าต้อง Set อย่างไร  รบกวน\nช่วยชี้แนะ ด้วยครับ	medium	C	\N	14	2026-06-21 20:53:40.357726	2026-03-09 00:00:00	PJC	2026-03-09 00:00:00	ยอดเงิน Invoiced To Date ของ Project 2512000009 จะเป็น 35,046.73 ดังนั้นเมื่อทำรายการข้อมูล Invoice หักเงินมัดจำ Field Adv. Pay Deduct Amt จะต้องคีย์ยอดเงิน 35,046.73	\N	\N	\N	14	CCH	CCH2603001	\N	PPCC_Project Invoice Milestone Lines	\N	Customized	Knowledge	K.Paisan	2026-03-06	16:45:00	ยอดเงิน Advance Payments Deduction มากกว่ายอดเงิน Invoiced To Date	\N	2026-03-11
1004	Ship ไม่ได้ ขึ้น error ดังภาพค่ะ	Error Not one Distribution Account where Product Code is (Blank) or Warehouse is MAIN exists for item that has [Item: .]	medium	C	\N	14	2026-06-21 20:53:40.364351	2026-04-29 00:00:00	CO	2026-04-29 00:00:00	แจ้ง User ให้แก้ไข Unit Cost ของ Line #2 เป็น 0 และลองทำ Order Shipping อีกครั้ง	\N	\N	\N	14	CCH	CCH2604001	\N	PPCC_Order Shipping	\N	Customized	Human Error	K.Khanisorn	2026-04-27	16:40:00	ข้อมูล Line #2 เป็น Non Inventory Item แต่คีย์ Unit Cost	\N	2026-05-01
1005	inv.consolidated invoice generation ไม่ได้ค่ะ	รบกวนดู inv.ให้ด้วยนะคะ ทรงเรา consolidated invoice generation ไม่ได้ค่ะ (ฝั่ง CCH) นะคะ\nD6904142  3,500- 245- 3,745.- VAT 7%	medium	C	\N	14	2026-06-21 20:53:40.366013	2026-05-11 00:00:00	DO	2026-05-11 00:00:00	ปลด Invoice Hold ที่หน้าจอ Customer Order Lines ออกแล้วทำรายการใหม่	\N	\N	\N	14	CCH	CCH2605001	\N	Consolidated Invoice Generation	\N	Customized	Human Error	K.Pornnipa	2026-05-11	11:30:00	CO CCH1910076 Line #1 ถูกติ๊ก Invoice Hold อยู่	\N	2026-05-14
1011	หน้าทำการ ORDER SHIP พอแสกนแล้วเด้งมาให้แสกนอีก ไม่ไปส่วนของแสกนแท็กลูกค้า	มีการตัดไปบ้างเเล้วค่ะ ORDER นี้ 15 ตัว เเต่ตัดได้ 5 ตัว พอจะเข้าไปตัดใหม่ ตัดไม่ได้เเล้วค่ะ รหัสลูกค้า 0101 FG300100435 ค่ะ	medium	C	\N	20	2026-06-21 20:53:40.373773	2026-01-07 00:00:00	SH	2026-01-07 00:00:00	ถอย CO68114119 จำนวน 10 ที่หน้าจอ Order Shipping โดยเลือก transaction date ตามเคสคือ ให้ถอยที่ transaction date วันที่ 06/01 และเลือกถอย lot 260105000000001 จากนั้นทำการ ทำ order shipping pick list ใบใหม่ต่อ	\N	\N	\N	14	CNI	CNI2601003	\N	PPCC_Order Shipping	\N	Customized	Human Error	K.Witaya	2026-01-07	09:25:00	History CO68114119 จำนวน อีก 10 ถูกตัดไปด้วย Picklist P260106010	\N	2026-01-12
1014	ขอสอบถามเพิ่มเติมค่ะ รบกวนอยู่ยอด TOTAL ให้หน่อยค่ะ ทำไมถึงมีรวมยอด ที่หน้าที่ 2 ทำไมมันถึงไม่รวมยอดให้ทั้งหมดที่หน้าสุดท้ายค่ะ เกิดจากอะไร	ขอสอบถามเพิ่มเติมค่ะ รบกวนอยู่ยอด TOTAL ให้หน่อยค่ะ ทำไมถึงมีรวมยอด ที่หน้าที่ 2 ทำไมมันถึงไม่รวมยอดให้ทั้งหมดที่หน้าสุดท้ายค่ะ เกิดจากอะไร	medium	C	\N	14	2026-06-21 20:53:40.377957	2026-01-09 00:00:00	GL	2026-01-09 00:00:00	Update Database	\N	\N	\N	14	CNI	CNI2601006	\N	PPCC_Journal Voucher Listing Report	\N	Localized	PPCC Localized	K.Monthakan	2026-01-08	11:05:00	Ref เดียวกันแต่มี Ref Journal No คนละเลข ซึ่งรายงานมีแบ่งกลุ่มตาม Ref Journal No	\N	2026-01-13
1015	รบกวนแก้ไขที่อยู่หนังสือรับรองการหักภาษี ณ ที่จ่าย PV2511000266	รบกวนแก้ไขที่อยู่ หนังสือรับรองการหักภาษี ณ ที่จ่าย เดือน 11 /2568 แก้ไขเป็นที่อยู่ : 11 หมู่ที่ 2 ถนนลำลูกกา-ธัญบุรี คลอง 7 ตำบลบึงคำพร้อย อำเภอลำลูกกา จังหวัดปทุมธานี 12150 ค่ะ\n\nรายการถูก Post ไปแล้วค่ะ	medium	C	\N	14	2026-06-21 20:53:40.379279	2026-01-09 00:00:00	AP	2026-01-09 00:00:00	Update Database	\N	\N	\N	14	CNI	CNI2601007	\N	PPCC_Withholding Tax Certificate	\N	Localized	PPCC Localized	Accounting	2026-01-08	16:45:00	\N	\N	2026-01-13
1019	รบกวนตรวจสอบภงด.PV2512000266	รบกวนตรวจสอบ PV2512000266 เนื่องจากเป็นการกลับรายการ ภงด ที่บันทึกผิดไปและต้องการกลับรายการจาก PV2512000216\n\nซึ่งกลับรายการแล้วแต่ยอด ภงด 53. ในใบแนบ กับ General Ledger By Account Report ไม่ตรงกันค่ะ รบกวนตรวจสอบให้หน่อยนะคะ	medium	C	\N	14	2026-06-21 20:53:40.384471	2026-01-14 00:00:00	GL	2026-01-14 00:00:00	\N	\N	\N	\N	14	CNI	CNI2601011	\N	PPCC_General Ledger By Account Report	\N	Localized	Knowledge	Accounting	2026-01-13	17:40:00	รายงาน General Ledger By Account เป็นการคำนวณยอดเงินโดยแยกฝั่ง Credit และ Debit ซึ่งยอดถอย Withholding Tax 53 จำนวน 170.63 ถูกคำนวณยอดเงินรวมในฝั่ง Debit\n\nรายงาน Withholding Tax Statement เป็นการคำนวณยอดเงินรวมทุกรายการโดยไม่แยกฝั่ง Credit หรือ Debit	\N	2026-01-16
1024	รบกวนดูให้หน่อยค่ะ ต้องรีบเปิดเอกสาร  INV ค่ะ	รบกวนดูให้หน่อยค่ะ ต้องรีบเปิดเอกสาร  INV ค่ะ\nError Meassage does not exist. Object:PK_ppcc_preinvoice_hdr_1, Type:17 :ppcc_preinvoice_hdrInsert:20	medium	C	\N	14	2026-06-21 20:53:40.391528	2026-02-02 00:00:00	AR	2026-02-02 00:00:00	ลบ Invoice 999999999	\N	\N	\N	14	CNI	CNI2602001	\N	PPCC_Pre Invoice	\N	Customized	Human Error	K.Sornsupat	2026-02-02	09:35:00	ในระบบมี Invoice 999999999	\N	2026-02-05
1025	ยอด Invoice ไม่ตรงกันค่ะ	เอกสารตัวจริง ตรงกับหน้า PPCC_Pre Invoice ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.39275	2026-02-02 00:00:00	AR	2026-02-02 00:00:00	แจ้ง User ให้เพิ่ม Do Seq ให้ตรงกับ Pre Invoice หลังจากนั้นทาง PPCC แก้ไขยอดเงินที่ Invoice เป็น 6260.82 และ Insert ข้อมูล Do Seq ที่เพิ่มที่ตาราง inv_item และ Update qty_invoiced ที่ตาราง coitem และ co_ship	\N	\N	\N	14	CNI	CNI2602002	\N	InvoicesDebitandCreditMemos	\N	Customized	Human Error	Accounting	2026-02-02	11:25:00	DO6901000898 มีแค่ 3 Seq แต่ Pre Invoice มี 4 Seq	\N	2026-02-05
1037	รบกวนตรวจสอบ GJ2601000059	รบกวนตรวจสอบ GJ2601000059 เนื่องจาก POST  รายการไปแล้วแต่ไม่เข้าหน้า GL ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.406342	2026-02-23 00:00:00	GL	2026-02-23 00:00:00	Insert ข้อมูลเข้า journal และลบข้อมูลออกจากตาราง tmp_mass_journal	\N	\N	\N	14	CNI	CNI2602014	\N	G/L Posted Transactions	\N	Standard	Standard Bug	Accounting	2026-02-20	16:30:00	\N	\N	2026-02-25
1039	พี่สงสัยทำไม บรรทัดที่ 2 เวลา รีวิว ขึ้นแบบนั่นแต่หน้าระบบ โชว์น่ะค่ะ	พี่สงสัยทำไม บรรทัดที่ 2 เวลา รีวิว ขึ้นแบบนั่นแต่หน้าระบบ โชว์น่ะค่ะ	medium	C	\N	14	2026-06-21 20:53:40.408181	2026-03-20 00:00:00	PO	2026-03-20 00:00:00	\N	\N	\N	\N	14	CNI	CNI2603002	\N	Purchase Order Report	\N	Customized	Knowledge	K.Tuk	2026-03-18	11:20:00	เงื่อนไขของรายงานกรณีถ้ามี Vendor Item ระบบจะนำ Vendor Item ไปแสดง	\N	2026-03-23
1048	รบกวนตรวจสอบรายการ RV2512000066	รบกวนตรวจสอบรายการ RV2512000066   เนื่องจากใน General Ledger By Account Report ไม่โชว์รายงาน ในขณะที่ post ปกติค่ะ\n	medium	C	\N	14	2026-06-21 20:53:40.416166	2026-04-20 00:00:00	GL	2026-04-20 00:00:00	Insert ข้อมูลเข้า journal และลบข้อมูลออกจากตาราง tmp_mass_journal	\N	\N	\N	14	CNI	CNI2604003	\N	General Ledger By Account Report	\N	Localized	PPCC Localized	Narin	2026-04-18	21:50:00	ข้อมู Post เข้า tmp_mass_journal	\N	2026-04-23
1056	ตั้งแต่เปิด po. หน้า po ไปดึง ต้นทันพวกค่าขนส่งเก่ามาด้วย  ทำให้หน้าpoออกยอดผิดค่ะ	ปกติ จะขึ้นตรงนี้ก็ต่อเมื่อเรา land Cost  แต่ตอนนี้เหมือนระบบขึ้น ตั้งแต่เปิด po  เลยค่ะ	medium	C	\N	19	2026-06-21 20:53:40.427081	2026-05-28 00:00:00	PO	2026-05-28 00:00:00	หากมีการแก้ไขเปลี่ยนแปลงราคาซื้อ แล้วต้องการให้ระบบดึง Unit Cost ให้ใหม่จากที่เคยกด Save ไปแล้ว ให้กดปุ่ม Recalculate Cost ที่หน้าจอ Purchase Order	\N	\N	\N	14	CNI	CNI2605006	\N	Purchase Orders Lines	\N	Standard	Knowledge	K.Yada	2026-05-26	11:15:00	1. ถ้าเปิด PO จาก PR หรือระบบวางแผน ระบบจะไปดึงราคาตามที่กำหนดไว้ในหน้าจอ Vendor contract Price\n2. ถ้ามีการสร้าง  PO Line และไม่ได้ใส่จำนวนตามเงื่อนไข จำนวน ตามที่กำหนดไว้ที่หน้าจอ Vendor contract Price แล้วกด Save ระบบจะดึงราคาจากหน้าจอ Item warehouse cost	\N	2026-06-01
1058	รบกวนตรวจสอบรายการ GJ2605000026	รบกวนตรวจสอบรายการ GJ2605000026   เนื่องจากใน General Ledger By Account Report ไม่โชว์รายงาน\n  ในขณะที่ post ปกติค่ะ\n	medium	C	\N	14	2026-06-21 20:53:40.429419	2026-06-15 00:00:00	GL	2026-06-15 00:00:00	Insert ข้อมูลเข้า journal และลบข้อมูลออกจากตาราง tmp_mass_journal	\N	\N	\N	14	CNI	CNI2606002	\N	G/L Posted Transactions	\N	Standard	Standard Bug	Narin	2026-06-11	13:20:00	ข้อมูลค้างอยู่ที่ตาราง tmp_mass_journal	\N	2026-06-16
1060	สอบถามค่ะ  รายการที่ 1 ราคาต่อหน่วย 64.41  ส่งงาน 100 ชิ้น  ราคารวมต้องได้ 6441 บาท  แต่ในระบบ  6440.80  ค่ะ	สอบถามค่ะ  รายการที่ 1 ราคาต่อหน่วย 64.41  ส่งงาน 100 ชิ้น  ราคารวมต้องได้ 6441 บาท  แต่ในระบบ  6440.80  ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.432415	2026-06-17 00:00:00	AR	2026-06-17 00:00:00	ถ้าราคา 64.41 เป็นราคาที่ถูกต้อง เคสนี้ต้องทำถอยและไปแก้ราคาที่ CO ให้เป็น 64.41 และออก Invoice ใหม่	\N	\N	\N	14	CNI	CNI2606004	\N	PPCC_Pre Invoices	\N	Customized	Knowledge	Accounting	2026-06-17	11:25:00	CO เปิดมาด้วย 64.408 ซึ่งข้อมูลราคาในระบบถูกต้องแล้ว แต่ที่หน้าจอ Pre Invoice แสดงทศนิยม 2 ตำแหน่งจึงมองเป็น 64.41	\N	2026-06-22
1062	รบกวนสอบถามครับคุณแอน หน้า PPCC_A/PVoucherPosting  กด process แล้ว error ไม่แน่ใจว่า form/report ตัวไหนที่ต้องเซ็ตให้รันรีพอร์ตนี้ได้ครับ	รบกวนสอบถามครับคุณแอน หน้า PPCC_A/PVoucherPosting  กด process แล้ว error ไม่แน่ใจว่า form/report ตัวไหนที่ต้องเซ็ตให้รันรีพอร์ตนี้ได้ครับ\nError You do not have permission to run form A/P Voucher Posting Report Viewer	medium	C	\N	14	2026-06-21 20:53:40.435684	2026-01-14 00:00:00	AP	2026-01-14 00:00:00	คุณบอยกำหนดสิทธิ์หน้าจอ APVoucherPostingReportViewer2	\N	\N	\N	14	HHT	HHT2601001	\N	PPCC_AP Voucher Posting	\N	Customized	Knowledge	K.Boy	2026-01-14	16:15:00	User ไม่มีสิทธิ์ใช้หน้าจอ APVoucherPostingReportViewer2	\N	2026-01-19
1066	เรื่อง Non inventory items	1 ในส่วนของ products code เราสามารถ setup account ให้มัน Auto popup ได้มั้ยจ้ะ\r\n2 non inventory เก่าๆลบได้มั้ย ไม่ได้ใช่เเล้ว ข้อมูลเก่าๆ มันจะยังอยู่ใช่มั้ย	medium	C	\N	15	2026-06-21 20:53:40.439501	2026-03-12 00:00:00	IC	2026-03-12 00:00:00	1 ในส่วนของ products code เราสามารถ setup account ให้มัน Auto popup ได้มั้ยจ้ะ --> ถ้าในส่วน Non-Inventory ไม่ได้ ปกติฝั่งซื้อระบบจะดึงรหัสบัญชีจากหน้าจอ Vendor ที่เป็น Purchase Account , ฝั่งขายขาย ดึงจาก Sale Non-Inventory ที่ End User Type , ฝั่งที่เบิกเข้า Job ต้องระบุรหัสบัญชีเอง\r\n\r\n2 non inventory เก่าๆลบได้มั้ย ไม่ได้ใช่เเล้ว ข้อมูลเก่าๆ มันจะยังอยู่ใช่มั้ย --> ไม่ใช้แล้วลบได้ ข้อมูลเก่าๆ ที่เคยเปิด PO จะยังอยู่ โดยบันทึกไว้ ณ หน้าจอเก็บต่างๆ ไว้แล้ว เช่น PR line , PO Line , Material Transaction	\N	\N	\N	14	HHT	HHT2603002	\N	Non inventory items	\N	Standard	Knowledge	K.Tongty	2026-03-11	10:00:00	\N	\N	2026-03-13
1068	ERP Ice Solutions : แจ้งปัญญา Background Task PPCC_ICashBGInsert Error	แจ้งปัญหาเรื่อง  Background Task PPCC_ICashBGInsert Error รบกวนช่วยตรวจสอบและแก้ไขให้ด้วยนะคะ โดยมีรายละเอียดปัญหาดังนี้ค่ะ\nปัญหาที่พบ\nพบปัญหารอบการ Sync ข้อมูลทุกวันศุกร์ที่มีทั้ง Advance และ Actual จาก Salesforce BG Task Name "PPCC_ICashBGInsert" ที่ ERP Error\nโดยล่าสุดพบในช่วงวันศุกร์ที่ 19 และ 26 ธันวาคม 2568\n\nลักษณะการส่งข้อมูลจาก Salesforce มี 3 แบบ\nรายการที่เป็น Advance อย่างเดียว >> PPCC_IcashBGInsert  Process รายการผ่านตามปกติ\nรายการที่เป็น Advance และ Actual >>  PPCC_IcashBGInsert  พบ Error ข้อมูลไม่เข้า iCash\nรายการที่เป็น Actual (ยอดเงินติดลบ) >>  PPCC_IcashBGInsert  พบ Error ข้อมูลไม่เข้า iCash\n \nStep การ Run ข้อมูลปัจจุบัน (Focus เฉพาะรอบวันศุกร์ที่เกิดปัญหา)\n1. Job Run เพื่อ Sync Data ด้วย Job Name "PKDV_Salesforce_Sync_i-Cash_Service_ACT"\n2. ข้อมูล insert ลง table  "PPCC_Appointment"\n3. ERP ทำการ Insert iCash ด้วย BG Task Name "PPCC_ICashBGInsert"  >> พบปัญหา Task Failed เฉพาะรอบวันศุกร์\nBatch id ที่ ลงท้ายด้วย A ข้อมูลไม่เข้า\n4. ข้อมูลบันทึกเข้า Table "ppcc_icash_hdr" และ "ppcc_icash_line"  **ไม่เกิด Transaction เนื่องจาก Task Failed จากข้อ 3\n	medium	C	\N	14	2026-06-21 20:53:40.442129	2026-01-08 00:00:00	ISH	2026-01-08 00:00:00	\N	\N	\N	\N	14	ICE	ICE2601001	\N	PPCC_i-Cash	\N	Customized	Knowledge	K.Sirinat	2026-01-07	11:10:00	จากการตรวจสอบพบว่า Step 3 เรียกใช้ SP_SFTiemSheet_ADV_Prepare_Step2 และใน SP นี้มี Step ทำงานดังนี้\n1. Insert ข้อมูลเข้า PPCC_tmp_Appointment\n2. Execute SP PPCC_iCashCheckFormatAppointmentSp และใน SP นี้มี Step การทำงานดังนี้\n2.1. Validate Data \n2.2. Insert ข้อมูลเข้า PPCC_Appointment\n2.3. เรียก Background Task ด้วย SP PPCC_iCashInsertHDRInLoopSp (Background Task จะไปเรียก SP PPCC_Icash_BGInsertSp)\n\nในส่วน Step 8 ทำงานเหมือน Step 3 แต่การทำงานขั้นตอน 1. Insert ข้อมูลเข้า PPCC_tmp_Appointment จะดึงข้อมูลจาก View คนละตัว\nการตั้ง Job PKDV_Salesforce_Sync_i-Cash_Service_ACT ลักษณะนี้จึงมีโอกาสที่จะทำให้ Background Task ของ Step 3 ยังทำงานไม่จบ และไปทำ Step 8 ต่อ ทำให้มีการเรียกใช้ SP PPCC_Icash_BGInsertSp พร้อมกัน จึงเกิดปัญหา Generate ได้เลข iCash ซ้ำได้	\N	2026-01-13
1073	ดึงPO ส่งโรงงานและเจอช่องว่างไลน์ที่3ทำให้เวลาโรงงานอัพโหลดnew poใหม่เข้าไปจับแค่บรรทัดแรกสุด อันนี้รบกวนเช็คและแก้ไข้ให้ด้วยนะคะว่าสาเหตุเกิดจากอะไร เพราะเคสส่งผลให้ทางโรงงงานโหลดPOไม่ครบจำนวนline	รบกวนเช็คเคสนี้ให้หน่อยนะคะ\nพอดีดึงPO ส่งโรงงานและเจอช่องว่างไลน์ที่3ทำให้เวลาโรงงานอัพโหลดnew poใหม่เข้าไปจับแค่บรรทัดแรกสุด อันนี้รบกวนเช็คและแก้ไข้ให้ด้วยนะคะว่าสาเหตุเกิดจากอะไร เพราะเคสส่งผลให้ทางโรงงงานโหลดPOไม่ครบจำนวนline	medium	C	\N	14	2026-06-21 20:53:40.446342	2026-02-09 00:00:00	PO	2026-02-09 00:00:00	แก้ไข SSRS โดยเพิ่ม Report Footer และซ่อนไว้ หลังจากนั้นทดสอบ Export ข้อมูลชุดเดิมออกมา Line 4 ไม่ถูกซ่อนแล้ว	\N	\N	\N	14	NTH	NTH2602001	\N	PPCC_PurchaseOrderExport	\N	Customized	Customized Bug	K.Jutatip	2026-02-09	10:45:00	เบื้องต้นทาง PPCC ลอง Export ข้อมูลตามที่ User แจ้งมาไม่พบ Line 3 ว่าง หลังจากนั้น User ลองเรียกไม่พบ Line 3 ว่างเช่นกัน แต่แจ้งปัญหาเรื่อง Line 4 หายไป (ถูกซ่อน) เพิ่มเติม	\N	2026-02-12
1074	Check CO25101163	รบกวนเช็ค CO25101163 ให้ด้วยค่ะ ว่าเกิดจากอะไร\n\nCO25101163 ยังไม่ได้ทำการขายใดๆ ในหน้า CO มีรายละเอียดครบ  แต่พอหน้า PICK WORKBENCH  ไม่มีรายการนี้โชว์ค่ะ CO25101163	medium	C	\N	14	2026-06-21 20:53:40.447032	2026-02-12 00:00:00	Shipment	2026-02-12 00:00:00	\N	\N	\N	\N	14	NTH	NTH2602002	\N	PPCC_Pick Workbench	\N	Customized	Knowledge	K.Nisakarn	2026-02-10	17:00:00	CO CO25011163 ถูกนำไปใช้ที่ Pick List 105651 แล้ว	\N	2026-02-16
1078	รบกวนช่วยเช็คให้หน่อยค่ะ ว่าทำไม่แท็กอินวอยด์รันออกมาผิดเบอร์	เนื่องจากออกแท็กอินวอยด์ แล้วพริ้นท์ออกมา เลขแท็กรันข้ามเบอร์ ปกติต้องเป็นเบอร์ 001 แต่ได้ออกมาเป็น 003\nรบกวนช่วยเช็คและแก้ไขให้ด่วนด้วยค่ะ ส่งงานพรุ่งนี้ ต้องรีบส่งให้ทางแวร์เฮ้าท์ค่ะ\n\nShip : 103961\nTax Inv. ออกมาเป็น # SV2603-003 >>  จริงๆต้องเป็น # SV2603-001	medium	C	\N	14	2026-06-21 20:53:40.450311	2026-03-16 00:00:00	AR	2026-03-16 00:00:00	Update Database	\N	\N	\N	14	NTH	NTH2603003	\N	PPCC_Invoices Debit and Credit Memos	\N	Customized	Technical	K.Suladda	2026-03-12	14:30:00	\N	\N	2026-03-17
1081	ด่วน! รบกวนช่วยลบข้อมูลใน Vendor customer contract price ให้หน่อยคะ	รบกวนด้วยค่ะ พอดีโหลดข้อมูลเข้าในเมนู Vendor customer contract price ผิด\nสำหรับ Customer: 6376 & 7326   >>  ภายใต้ Effective Date: 01/04/2026\nอยากให้ช่วยลบข้อมูลทั้งหมด ออกให้ด่วนด้วยค่ะ \n	medium	C	\N	14	2026-06-21 20:53:40.452619	2026-03-27 00:00:00	CU	2026-03-27 00:00:00	ลบข้อมูล Vendor Customer Contract Price ของ Customer 6376 และ 7326 ที่เงื่อนไข Effective Date = 01/04/2026	\N	\N	\N	14	NTH	NTH2603006	\N	PPCC_Vendor Customer Contract Prices	\N	Customized	Human Error	K.Suladda	2026-03-27	15:50:00	\N	ลบข้อมูลตาราง itemcustprice	2026-03-30
1085	Domestic invoicing for JPY	Currently, we have transactions for tax invoice in USD with conversion to THB.\nIn case we want to sell and issue tax invoice in JPY with conversion to THB same as format in attached.\nPlease advise how to we do it.\n	medium	C	\N	14	2026-06-21 20:53:40.456679	2026-05-25 00:00:00	AR	2026-05-25 00:00:00	กำหนดไว้ที่หน้าจอ PPCC_Customers ที่ Tab PPCC ตรงส่วนของ Default Form Invoice ให้เลือก Domestic Foreign Invoice	\N	\N	\N	14	NTH	NTH2605002	\N	PPCC_Consolidate Invocing	\N	Customized	Knowledge	K.Chinchutha	2026-05-19	14:50:00	\N	\N	2026-05-22
1088	แก้ไขยอดเงินใน Jounal Entries	เนื่องจากว่า Invoice No. DN2026-062 เป็นรายการที่คีย์ตรงจาก PPCC Invoice credit and debit memo แล้วถูก Post ไปยัง Journal Entries เรียบร้อยแล้วแต่ยอดเงินผิด\nรบกวนช่วยแก้ไขยอดเงินให้ตรงกับช่องสีเหลืองที่แนบมาให้ด้วยค่ะ \n\nสำหรับรายงานที่ต้องแก้ไขให้ตรงกัน มีดังนี้\n\n1.\tPPCC_Sales report\n2.\tPPCC_Output Vat report\n3.\tรายการใน Journal Entries ที่แจ้งไว้	medium	C	\N	14	2026-06-21 20:53:40.459933	2026-05-25 00:00:00	GL	2026-05-25 00:00:00	Update Database	\N	\N	\N	14	NTH	NTH2605005	\N	Journal Entries	\N	Customized	Human Error	K.Dararat	2026-05-25	11:20:00	\N	\N	2026-05-28
1095	รบกวนตรวจสอบ (Site PKS) : ref inv.ASIN02102023  หน้า PPCC_serviceTaxInvoice  โดยปกติงวดเดือนอื่นๆ จะแสดง  inv. amount = 3,014,018.69 แต่เลขที่ : ARIN26021005  แสดงยอด 190015219.39  ค่ะ	รบกวนตรวจสอบ (Site PKS) : ref inv.ASIN02102023  หน้า PPCC_serviceTaxInvoice  โดยปกติงวดเดือนอื่นๆ จะแสดง  inv. amount = 3,014,018.69 แต่เลขที่ : ARIN26021005  แสดงยอด 190015219.39  ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.467787	2026-03-27 00:00:00	AR	2026-03-27 00:00:00	เบื้องต้นทดสอบที่ CRP จังหวะสร้าง Header Invoice Amount จะดึงยอดคงเหลือของ Ref To Tax Invoice No มาแสดง แต่หากมีการสร้าง Line ด้วยยอดที่ไม่เต็มจำนวน ระบบจะคำนวณยอดจาก Line มาแสดงแทน	\N	\N	\N	14	PK	PK26030001	\N	PPCC_Service Tax Invoice	\N	Customized	Knowledge	K.Mewadee	2026-03-26	10:05:00	\N	\N	2026-03-31
1101	PPCC รบกวนลบจำนวน800 Location VB-1203  ของ Item FG050009	PPCC รบกวนลบจำนวน800 Location VB-1203  ของ Item FG050009\r\nออกจากระบบให้หน่อยค่ะ ไม่มียอดงานอยู่จริง	medium	C	\N	18	2026-06-21 20:53:40.476154	2026-03-20 00:00:00	IC	2026-03-20 00:00:00	กรณีนี้ไม่แนะนำให้ทำการลบ Location ที่หน้า Item Stockroom Location ออกครับ เนื่องจากว่าจะทำให้ข้อมูลไม่ตรงกับใน Material Transaction ครับ\r\n\r\nซึ่งกรณีนี้ทาง PPCC จะทำการ Update ข้อมูลของ Item : FG050009 ที่ Location : VB-1203 ของ Lot : SNPR-0226020141 จำนวน 800 และเมื่อทำการ Update เสร็จแล้วให้ทำการ Miscellaneous Issue ออกครับ	\N	\N	\N	18	SNPR	SNPR260202	\N	Item Stockroom Location	\N	Standard	Technical	wannisa kik👑	2026-02-20	\N	จากที่ตรวจสอบ material transaction ก็คือ item : FG050009 ที่ location : VB-1203 ของ lot : SNPR-0226020141 จะต้องมีของอยู่ใน lot นี้จำนวน 800 ครับ\r\n\r\nแต่ว่าจากที่เข้าไปดูในหน้า item stockroom location ตอนนี้พบว่า item : FG050009 ที่ location : VB-1203 มี location on hand เป็น 0 ครับ	\N	2026-03-20
1103	PPCCรบกวนตรวจสอบให้หน่อยค่ะ ระบบมียอดงานติดลบ	PPCCรบกวนตรวจสอบให้หน่อยค่ะ ระบบมียอดงานติดลบ	medium	C	\N	14	2026-06-21 20:53:40.479145	2026-03-27 00:00:00	IC	2026-03-27 00:00:00	ตรวจสอบ Material Transaction ไม่มี Lot ติดลบ ทาง PPCC จึงลบ Lot ติดลบออกแล้วทำ Rebalance Item Qty On Hand	\N	\N	\N	14	SNPR	SNPR260302	\N	Item Lot Locations	\N	Standard	Knowledge	wannisa kik👑	2026-03-25	10:35:00	\N	\N	2026-03-30
1104	PPCCรบกวนตรวจสอบให้หน่อยค่ะ ข้อมูลTag  ใบที่3หายไป รับงานเข้า lot นี้  7000 KG.  แต่TAG ออกแค่6ใบค่ะ	PPCCรบกวนตรวจสอบให้หน่อยค่ะ ข้อมูลTag  ใบที่3หายไป รับงานเข้า lot นี้  7000 KG.  แต่TAG ออกแค่6ใบค่ะ	medium	C	\N	14	2026-06-21 20:53:40.480144	2026-06-10 00:00:00	Oth	2026-06-10 00:00:00	ลบ Tag ของ Lot PL260610-05-001 ออกจากระบบและให้ User Print Tag ใหม่	\N	\N	\N	14	SNPR	SNPR260601	\N	PPCC_PrintTagRM	\N	Customized	Customized Bug	wannisa kik👑	2026-06-10	15:25:00	\N	\N	2026-06-15
1107	รบกวนช่วยตรวจสอบให้หน่อยค่ะ	จะออก Invoice ต่างประเทศ (เป็นลูกค้าใหม่ ยังไม่เคยขายมาก่อน) กด Pre-invoice ตามขั้นตอนปกติ แต่พอกด generate invoice no. แล้วขึ้น pop-up ตามหน้าจอค่ะ	medium	C	\N	14	2026-06-21 20:53:40.482333	2026-01-07 00:00:00	AR	2026-01-07 00:00:00	แก้ไขความยาวของ Field เป็น 255 ตัวอักษร	\N	\N	\N	14	SRN	SRN2601003	\N	PPCC_Pre-Invoice	\N	Customized	Customized Bug	K.Panita	2026-01-07	15:45:00	เกิดจาก Long Name ของ Customer EANG001 มีความยาว 61 ตัวอักษร แต่ Field Shipping Mark ชื่อลูกค้ากำหนดความยาวไว้แค่ 60 ตัวอักษร	\N	2026-01-12
1105	รบกวนตรวจสอบและแก้ไขการตัดสต็อค	สืบเนื่องจากเคสนี้ ก่อนแก้ไขเคสนี้ CO นี้มี2ไลน์ ซึ่งทาง PPCC ลบไลน์ที่อ้างอิงเลขที่ Inv. ออกไป ทำให้ตอนนี้ยอด QTY ใน PPCC_PreInvoiceLineSequences  ไม่ตรงกับ Order รบกวนUpdate ข้อมูลหน้า PPCC_PreInvoiceLineSequences   ให้ภายใน14.30 ด้วยนะคะ เนื่องจากกำลังปิดงบค่ะ	medium	C	\N	23	2026-06-21 20:53:40.481	2026-01-06 00:00:00	Automation	2026-01-06 00:00:00	Update Database	\N	\N	\N	14	SRN	SRN2601001	\N	PPCC_PreInvoiceLineSequences	\N	Customized	Customized Bug	K.Panita	2026-01-05	14:15:00	\N	\N	2026-01-09
1111	แจ้งปัญหา ข้อมูลไม่ถูกต้องค่ะ	จากการตรวจสอบ คาดว่าน่าจะเกิดจาก  Gen : GRN ผิดค่ะ เลยทำการถอยและรับเข้าใหม่ค่ะ จังหวะการถอยไม่แน่ใจว่าระบบเอาราคาจากไหนมาค่ะ และมีการGen: GRN ใหม่  ตอนรับ PO Receiving ราคาก็ไม่ตรงกับ PO ไม่แน่ใจว่า Error จังหวะไหนค่ะ\nรบกวน PPCC ตรวจสอบความถูกต้อง และรบกวรอัพเดตข้อมูลให้ด้วยนะคะ \n\nอัพเดตข้อมูล 2 PO นี้นะคะ \nPO : RM25120006    \nPO : RM25120031   \n\nและอัพเดตข้อมูลในหน้านี้ด้วยนะคะ เพราะการคำนวณผิดเลยกระทบไปหลายรายงานเลยค่ะ\n1.PPCC_Journal Entries เล่ม PO Dist ( GL Post )\n2.PPCC_Material Transactions\n3.PPCC_Material Transactions Amount\n4.PPCC_Inventory Balance Report 8 Digits\nไม่แน่ใจว่ายังมีหน้าอื่นๆเพิ่มไหม รบกวน PPCC ตรวจสอบและแก้ไขให้ด้วยนะคะ	medium	C	\N	14	2026-06-21 20:53:40.485137	2026-02-02 00:00:00	PO	2026-02-02 00:00:00	Update ยอดเงินขาบัญชี 900007 Inventory Adjustment เป็น 0 และ Update ยอดเงินขาบัญชี 130100 โดยคำนวณจาก Qty * Cost	\N	\N	\N	14	SRN	SRN2601007	\N	PPCC_Purchase Orders	\N	Customized	Customized Bug	K.Sunisa	2026-01-31	21:20:00	\N	\N	2026-02-05
1181	ตรวจสอบการ Post A/R Paymenr Posting ไม่ผ่าน	รบกวนตรวจสอบการ Post RE69020101  เนื่องจาก Post ไม่ผ่าน\nรบกวนทีม PPCC ตรวจสอบเพื่อทำการ Post ให้ผ่าน	medium	C	\N	14	2026-06-21 20:53:40.617117	2026-03-06 00:00:00	AR	2026-03-06 00:00:00	แก้ไขยอดเงิน ที่ AR Payments ให้ตรงกับ AR Payment Distributions	\N	\N	\N	14	TAK	TAK2603006	\N	AR Payment Posting	\N	Localized	PPCC Localized	K.Jittima	2026-03-05	13:45:00	ข้อมูลยอดเงินของ Invoice SR69020049 บันทึกยอดเงินด้วยทศนิยม 4 ตำแหน่ง (-3313.2053)	\N	2026-03-10
1116	รบกวน Update ข้อมูลหน้า PPCC_Pre-InvoiceLineSequences	เนื่องจากข้อมูล PO. มีการเปลี่ยนแปลงข้อมูล(ลูกค้าเลื่อนแผน) ทำให้ระบบจำข้อมูลเดิม รบกวนทาง PPCC ช่วย Update ข้อมูลให้หน่อยนะคะ\n\nโดยทาง ปณิตา ต้องการให้ PPCC ลบข้อมูล Line ที่ 3 และ 4 ออกจาก PPCC_Pre-InvoiceLineSequences  ตามที่ไฮไลท์สีเหลืองไว้ และ คงเหลือข้อมูลที่ไฮไลท์สีชมพูไว้  ตามรูปที่2 ที่แนบมาค่ะ\n\nCustomer : DHATC01  : HONDA (PRACHINBURI) : CO. CO26011573 : Invoice No.D260209/0005\n	medium	C	\N	14	2026-06-21 20:53:40.496019	2026-02-18 00:00:00	AR	2026-02-18 00:00:00	ลบข่อมูล Line 3,4 ที่ตาราง do_seq และแก้ไขข้อมูล DO Num, DO Line, DO Seq ทีตาราง co_ship	\N	\N	\N	14	SRN	SRN2602005	\N	PPCC_Pre Invoice Line Sequences	\N	Customized	Human Error	K.Panita	2026-02-16	11:40:00	\N	\N	2026-02-19
1366	รบกวนสอบถามค่ะ DL ทำการถอยคืน Stock ของ HONDA _ออก Inv. ก่อนตัด Stock แต่เมื่อถอยคืน ถอยคืนจาก Barcode แต่วันที่ถอยคืนข้ามไปเดือน มค. ค่ะ วันที่ไม่ได้อ้างอิงมากจาก Inv. เหมือนตอนที่ตัด Stock หรือค่ะ แล้วพอจะไปตัดใหม่ ใน SL มีข้อความตามภาพ ไม่สามารถทำได้ค่ะ	รบกวนสอบถามค่ะ DL ทำการถอยคืน Stock ของ HONDA _ออก Inv. ก่อนตัด Stock แต่เมื่อถอยคืน ถอยคืนจาก Barcode แต่วันที่ถอยคืนข้ามไปเดือน มค. ค่ะ วันที่ไม่ได้อ้างอิงมากจาก Inv. เหมือนตอนที่ตัด Stock หรือค่ะ แล้วพอจะไปตัดใหม่ ใน SL มีข้อความตามภาพ ไม่สามารถทำได้ค่ะ	medium	C	\N	14	2026-06-21 20:54:10.65529	2026-02-18 00:00:00	CO	2026-02-18 00:00:00	แก้ไข Transaction Date ที่ตาราง matltran, matltrack, journal และเนื่องจากวันที่ลงข้ามเดือนจึงต้องแก้ไข Control Period และ Control Number ที่ Journal ด้วย	\N	\N	\N	14	SRN	SRN2602008	\N	PPCC_Order Shipping	\N	Customized	Customized Bug	K.Jutathip	2026-02-18	10:00:00	\N	\N	2026-02-23
1120	รบกวนเปลี่ยน Status ให้หน่อยค่ะ	เนื่องจากมีการตั้งหนี้หน้าตรง Inv.O2602/000002 : Sun Vending  และยังไม่ได้เปลี่ยน Status เป็น Approved และยังไม่ได้ส่งข้อมูลไป EZTax แต่ได้ทำการ Post ไปหน้า Journal แล้ว รบกวนเปลี่ยน Status ให้หน่อยได้ไหมคะ	medium	C	\N	14	2026-06-21 20:53:40.533712	2026-02-26 00:00:00	AR	2026-02-26 00:00:00	แก้ไข Document Status จาก In Process เป็น Approved	\N	\N	\N	14	SRN	SRN2602010	\N	PPCC_InvoicesDebitandCreditMemosHistorical	\N	Customized	Human Error	K.Panita	2026-02-23	08:55:00	\N	\N	2026-02-26
1124	พบปัญหา รายงานแล้ววัตถุดิบ BFRMPAP00002  ไม่ถูกตัด *** แต่รายงานได้ค่ะ	พบปัญหา รายงานแล้ววัตถุดิบ BFRMPAP00002  ไม่ถูกตัด *** แต่รายงานได้ค่ะ\r\nเข้าไปตัดเบิกที่หน้า Job Material Transaction   แต่ระบบไม่ยอมตัดให้ค่ะ	medium	C	\N	18	2026-06-21 20:53:40.536806	2026-02-27 00:00:00	SFC	2026-02-27 00:00:00	ทาง PPCC ขอลองทำการตัดเบิก สามารถทำการเบิกได้เรียบร้อยครับ\r\n\r\nเมื่อเปิดเข้ามาหน้า Job Material Transaction แล้วทำการติ๊ก Show Backflush Materials (ในกรอบสีแดง) จากนั้นเลือก Lot : 251201000000001 ที่ Location : FORMI-CP2 แล้วติ๊ก Select ที่รายการนี้ตามรูป จากนั้นกด Process	\N	\N	\N	18	SRN	SRN2602014	\N	Job Material Transaction	\N	Standard	Technical	Thidaporn	2026-02-27	\N	ขั้นตอนการระบุข้อมูลยังไงบ้างหรอครับ พอดีว่าเห็นว่าไม่ได้ทำการติ๊ก Show Backflush Materials (ในกรอบสีแดง) แต่ว่ามีข้อมูลของ Material ที่จะต้องทำการ Backflush แสดงขึ้นมาครับ	\N	2026-02-27
1127	รบกวนแก้ไขตารางใบลดหนี้	เนื่องจากมีการออกเอกสารใบลดหนี้ และเอกสารมี 2 แผ่นต่อกัน Inv.CNE260310/01 Customer  Code : ENMT001\nรบกวนแก้ไขเส้นตรงใต้ข้อที่ 25 หน้าที่ 1 (รูปที่1)  และ หัวของตารางหน้าที่ 2 (รูปที่2) ให้หน่อยค่ะ\nรบกวนแก้ไขก่อนเวลา 15.00 น.นะคะ	medium	C	\N	14	2026-06-21 20:53:40.54329	2026-03-10 00:00:00	AR	2026-03-10 00:00:00	แก้ไข SSRS	\N	\N	\N	14	SRN	SRN2603003	\N	PPCC_Confirm Send e-Tax Invoice (Account)	\N	Customized	Customized Bug	K.Panita	2026-03-10	14:00:00	\N	\N	2026-03-13
1128	Reconfirm เรื่องการเปลี่ยนแปลงราคา เนื่องจากลูกค้ามีการเปลี่ยนราคา หลังจากที่ Load order	ที่เคยถาม “ ถ้าเป็นช่วงรอยต่อราคา ทาง MK ต้องใส่เลข CO ที่ต้องการอัพเดตราคาใช่หรือไม่ค่ะ (ระบบไม่ได้จับที่ Ship due date (Invoice) ใช่ไหมค่ะเพราะออเดอร์ถูกเลื่อนแล้วไม่ได้ update วันที่ค่ะ”\n\nได้ลองทำการ Reprice ในระบบแล้วค่ะแต่ราคาไม่เปลี่ยนให้เนื่องจาก ระบบมองที่ Ship due date ราคา Effective วันที่ 1/3/2026 แต่ออเดอร์ที่โหลดก่อนหน้าไม่ได้ถูกแก้ไขวันที่เรียกงานในครั้งแรก (ไม่ได้จัดส่งตาม Due) มีวิธีไหนที่สามารถทำได้หรือไม่ค่ะ	medium	C	\N	15	2026-06-21 20:53:40.545193	2026-03-12 00:00:00	CO	2026-03-12 00:00:00	\N	\N	\N	\N	14	SRN	SRN2603004	\N	PPCC_Customer Order Reprice	\N	Customized	Knowledge	K.Jutathip	2026-03-10	14:30:00	\N	\N	2026-03-13
1133	Reconfirm เรื่องการเปลี่ยนแปลงราคา เนื่องจากลูกค้ามีการเปลี่ยนราคา หลังจากที่ Load order	สืบเนื่องจากที่ลูกค้า Honda มีเปลี่ยนแปลงราคา E-Date 1 Mar’2026 : และมีเลื่อน Order เดือน Feb’2026 มาจัดส่งในเดือน Mar’2026\nส่งผลให้ Invoice วันที่ 03-05 Mar’2026 มีราคาที่ไม่ตรงกับของลูกค้าค่ะ เพราะว่าเป็น Order date เดือน Feb’2026 รายการตามไฟล์แนบ\nซึ่ง SRN จะต้องมีการแก้ไขราคาใน Invoice ที่ออกไปแล้ว ที่เป็น Status Filled และต้องรบกวนขอความช่วยเหลือจาก PPCC ค่ะ\n→ รบกวนขอให้ PPCC ช่วย Support การแก้ไขราคาใน Excel file sheet : SRN Price errors ให้หน่อย ซึ่งเราได้ List Invoice. มาให้แล้วค่ะ\nช่วยดำเนินการให้แล้วเสร็จภายในเวลา 16.00 ได้มั้ยคะ เนื่องจากว่า SRN มีความจำเป็นต้องรีบนำ Invoice ไปแลกเปลี่ยนกับลูกค้าโดยเร็วที่สุดค่ะ	medium	C	\N	14	2026-06-21 20:53:40.549165	2026-03-20 00:00:00	AR	2026-03-20 00:00:00	Update Price ที่ Customer Order Lines, Order Shipments, Pre Invoice	\N	\N	\N	14	SRN	SRN2603009	\N	PPCC_Pre Invoice	\N	Customized	Unidentified	K.Siriwan	2026-03-19	14:25:00	\N	\N	2026-03-25
1134	พบปัญหา หลายเลข Tag ไม่รันต่อเนื่องอีกแล้วค่ะ Job SF2645	พบปัญหา หลายเลข Tag ไม่รันต่อเนื่องอีกแล้วค่ะ\nJob SF2645\nช่วยตรวจสอบ ว่าเกิดจากสาเหตุอะไรค่ะ	medium	C	\N	14	2026-06-21 20:53:40.557136	2026-03-25 00:00:00	Oth	2026-03-25 00:00:00	Update Tag ID ของ Job SF00002645	\N	\N	\N	14	SRN	SRN2603011	\N	PPCC_Print Production Tag	\N	Customized	Customized Bug	K.Wipa	2026-03-23	13:45:00	เบื้องต้นตรวจสอบพบว่ามีการกด Process ตอน commit ซ้ำหลายรอบ	\N	2026-03-26
1382	แจ้งเจอปัญหา  หน้า รวบ Pickเจอปัญหา  หน้า รวบ Pick List  เจอ Pick List หาย ค่ะ ข้อมูล ไม่ขึ้นในรวบ ค่ะ  รบรวนกวน ตรวจสอบให้หน่อยค่ะ หน้างานแจ้ง ปัญหา  ดังกล่าว เกิดจากตอน กด Process  แล้วสัญญาณ อินเตอร์เน็ต หาย ค่ะ จึงทำให้เป็นเช่นนี้  รบกวนแก้ไขให้หน่อยค่ะ	เจอปัญหา  หน้า รวบ Pick List  เจอ Pick List หาย ค่ะ ข้อมูล ไม่ขึ้นในรวบ ค่ะ  รบรวนกวน ตรวจสอบให้หน่อยค่ะ หน้างานแจ้ง ปัญหา  ดังกล่าว เกิดจากตอน กด Process  แล้วสัญญาณ อินเตอร์เน็ต หาย ค่ะ จึงทำให้เป็นเช่นนี้  รบกวนแก้ไขให้หน่อยค่ะ	medium	C	\N	23	2026-06-21 20:54:10.669626	2026-03-20 00:00:00	Automation	2026-03-20 00:00:00	Insert ข้อมูล Pick List และ Ship Label	\N	\N	\N	14	SRN	SRN2603010	\N	Scan Order PickList	\N	Customized	Human Error	K.Jintana	2026-03-18	15:35:00	หากทำการกดปุ่ม process แล้วรบกวนให้รอจนกว่าจะมีข้อความขึ้นแจ้งว่าทำรายการสำเร็จนะคะ หากกด back กลับออกระหว่างระบบทำรายการ ระบบจะลบข้อมูล tag และ shiplabel ที่แสกนไว้ทั้งหมดทิ้งไป	\N	2026-03-23
1135	รบกวนช่วยตรวจสอบ Type เอกสารหน้าตรง	เนื่องจากมีการออกเอกสารใบลดหนี้ หน้าตรง และมีความสงสัยตรง Type  : Invoice  ในวันที่ทำเอกสารและ Save ข้อมูลไว้ ตรง Type : เลือก Credit ตามรูปที่ 1 แต่ข้อมูลหน้า ERP ณ ตอนนี้ Type : Invoice  ตามรูปที่ 2 ค่ะ\n1.\tCNE260310/01 = NMT KM.21 (NISSAN MOTOR - VAT 0)\n2.\tCNN2603/0001 = NMT KM.21 (NISSAN MOTOR - Non Vat)\n	medium	C	\N	14	2026-06-21 20:53:40.574501	2026-03-25 00:00:00	AR	2026-03-25 00:00:00	แจ้ง User ให้แก้ไขยอดเงินของ Invoice CNE260310/01 และ CNN2603/0001 เป็นค่าติดลบ	\N	\N	\N	14	SRN	SRN2603012	\N	PPCC_Invoices Debit and Credit Memos	\N	Localized	Knowledge	K.Panita	2026-03-25	08:40:00	หน้าจอ Invoices Debit and Credit Memo กรณีใบลดหนี้ทาง PPCC จะมี Customized ให้เปลี่ยน Type จาก Credit Note เป็น Invoice แต่ยอดเงินจะเป็นค่าติดลบ	\N	2026-03-30
1183	รบกวนแก้ไข Line Item ที่จะลดหนี้ให้ถูกต้องตาม AI ที่อ้างอิง	เนื่องจากทางทีมบัญชีได้ทำการลดหนี้ price Adj เนื่องจาก Line Item ไม่ได้ออกตามที่อ้างอิง AI68120003 \nรบกวนทาง PPCC แก้ไข Line Item ออกให้ถูกต้องตามอ้างอิงเลขที่ Invoive ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.618661	2026-03-20 00:00:00	PAJ	2026-03-20 00:00:00	ลบข้อมูล Price Adjustment Line รายการเก่าออกจากระบบและ Insert ข้อมูล Invoice AI68120003 เข้าระบบ	\N	\N	\N	14	TAK	TAK2603008	\N	PPCC_PriceAdjustmentInvoice	\N	Customized	Customized Bug	K.Jittima	2026-03-19	10:30:00	คาดว่า User มีการแก้ไข Apply To Invoice หลังจากบันทึกข้อมูล Header ไปแล้ว	\N	2026-03-25
1138	Reconfirm เรื่องการเปลี่ยนแปลงราคา เนื่องจากลูกค้ามีการเปลี่ยนราคา หลังจากที่ Load order	จากที่ลูกค้า Honda มีเปลี่ยนแปลงราคา E-Date 1 Mar’2026 : และมีเลื่อน Order เดือน Feb’2026 มาจัดส่งในเดือน Mar’2026 ตอนนี้อยู่ในช่วงเคลียร์ Reprint Invoice ราคาผิด\n\nคือ SRN จะต้องแก้ไขราคาใน Invoice ที่ออกไปแล้ว จึงต้องรบกวนให้ช่วย Support จนกว่าจะแล้วเสร็จตามที่ลูกค้าแจ้งมาค่ะ ทั้งนี้เราได้สรุปข้อมูลที่ต้องแก้ไขรายการตามไฟล์แนบค่ะ\n \n→ รบกวนขอให้ PPCC ช่วย Support การแก้ไขราคาใน Excel file sheet : Invoice Price errors(Reprint1) ; (Reprint2) ; (Reprint3) ให้หน่อย ซึ่งได้ List INV. มาให้แล้วค่ะ	medium	C	\N	14	2026-06-21 20:53:40.576961	2026-03-27 00:00:00	AR	2026-03-27 00:00:00	Update Price ที่ Customer Order Lines, Order Shipments, Pre Invoice	\N	\N	\N	14	SRN	SRN2603015	\N	PPCC_Pre Invoice	\N	Customized	Unidentified	K.Duangporn	2026-03-27	13:20:00	\N	\N	2026-04-01
1141	รบกวนช่วย Update ข้อมูลให้หน่อยนะคะ	เนื่องจากมีการตั้งหนี้หน้าตรง Inv.No.CNE260310/01  และทำข้อมูลเสร็จเรียบร้อยไปแล้ว 1 รอบโยนข้อมูลเข้า EZtax ไปแล้ว และมีการแก้ไขข้อมูลตัวเลขรอบ 2 และโยนข้อมูลเข้าไปที่ EZtax อีกรอบ ข้อมูลการบันทึกบัญชีและข้อมูลหน้า Invoice ตรงกัน แต่พอดึงข้อมูล Report Vat จาก ERP ข้อมูลจำตัวเลขรอบแรกไม่ถูกเปลี่ยนเป็นข้อมูลตัวเลขรอบสอง รบกวน Update ข้อมูลให้เป็นตัวเลขปัจจุบันได้ไหมคะ รบกวนขอก่อนเวลา 09.30 น. นะคะเนื่องจากว่ากำลังปิดงบอยู่ค่ะ\n\nข้อมูลตัวเลขรอบแรกที่ทำการบันทึกบัญชี  98,513.88\n\nข้อมูลตัวเลขรอบสองที่ทำการบันทึกบัญชี 100,899.28 ตามรูปที่แนบมาค่ะ	medium	C	\N	14	2026-06-21 20:53:40.579105	2026-04-03 00:00:00	AR	2026-04-03 00:00:00	Update Database	\N	\N	\N	14	SRN	SRN2604001	\N	PPCC_OutputVatReport	\N	Customized	Human Error	K.Panita	2026-04-03	09:05:00	User ไม่ได้แก้ไขยอดเงิน Tax Basis ที่ Invoices Debit and Credit Memo G/L Distributions	\N	2026-04-08
1146	ข้อมูล Pre-Invoice ของลูกค้า Honda ข้อมูลไม่ตรงกันระหว่างหน้า Invoice Report กับหน้า PPCC_Pre-Invoice	หน้า PPCC_Pre-Invoice ระบบแสดงข้อมูลทั้งหมด 9 CO ตามภาพด้านล่างค่ะ\nโดยรายการที่ 6-8 ของหน้า PPCC_Pre-Invoice เป็น Part no. เดียวกัน ต่างกันที่จำนวน\nเมื่อดึงข้อมูลที่หน้า Invoice Report ระบบแสดงข้อมูลแค่ 7 CO ตามภาพด้านล่างค่ะ โดยรายการที่ 6-8 ของหน้า PPCC_Pre-Invoice เป็น Part no. เดียวกัน ต่างกันที่จำนวนระบบทำการดึง Report รวบไปเป็นรายการเดียวเลยให้อยู่ในรายการที่ 6 และรวมจำนวนไว้ที่รายการเดียวเลยค่ะ	medium	C	\N	14	2026-06-21 20:53:40.584591	2026-05-05 00:00:00	AR	2026-05-05 00:00:00	แก้ไขเงื่อนไขการดึงข้อมูลมาแสดงในรายงาน และแก้ไขกลับเป็นเงื่อนไขเดิม	\N	\N	\N	14	SRN	SRN2605001	\N	Invoice Report	\N	Customized	Unidentified	K.Siriwan	2026-05-05	08:40:00	เนื่องจากเป็นรหัสสินค้า และ PO เป็นเลขเดียวกันระบบจึงรวบแสดงเป็น 1 บรรทัด	\N	2026-05-08
1153	รบกวนแก้ไข Output Vat	เนื่องจากมีการตั้งหนี้หน้าตรง Inv.No.O2605/000002 และได้มีการ Generate 2 ครั้ง \nในส่วนของ Distribution มีการบันทึกบัญชี Output Vat แค่ 1 ไลน์ แต่พอดึงข้อมูล Invoice Voucher มีการบันทึกบัญชี Output Vat 2 ไลน์   (ตามรูปข้างล่าง)\nรบกวนแก้ไขโดยการนำ ยอด Output Vat 70 ออกให้หน่อยค่ะ  เหลือ Output Vat ไว้แค่ยอด 141.15 ค่ะ\n	medium	C	\N	14	2026-06-21 20:53:40.58994	2026-06-02 00:00:00	AR	2026-06-02 00:00:00	ลบข้อมูลที่ค้างอยู่ที่ตาราง ppcc_arinvd_mst ออกจากระบบ	\N	\N	\N	14	SRN	SRN2605008	\N	PPCC_AR Invoice Voucher Report	\N	Localized	PPCC Localized	K.Panita	2026-05-28	15:40:00	ข้อมูลค้างที่ตาราง ppcc_arinvd_mst	\N	2026-06-02
1155	แจ้งปัญหา  วันที่ 6-06-2026   DL เจอ Tag ไลน์ การผลิต ในระบบ ไม่ตรงกับ Tag PD ค่ะ	แจ้งปัญหา  วันที่ 6-06-2026   DL เจอ Tag ไลน์ การผลิต ในระบบ ไม่ตรงกับ Tag PD ค่ะ  ทำให้ไม่สามารถตัด Stock ได้ โดยปัญหาดังกล่วา คือ JOBDB00011019-0-20 = 210 pcs  โดยตรวจสอบ หน้า PPCC_TAG  Line โชว์ ที่ RUL 2 แต่ หน้า Quantity Move เป็น RUL 3 ทำให้เกิด ปํญหา ตัดงานขายไม่ได้ ค่ะ  เบื้องต้น คุณจิราพร ได้ทำการแก้ไข ให้แล้วค่ะ  แต่ยังไม่ได้สอบถามว่าปัญหา เกิดจากจุดไหน ค่ะ  รบกวนช่วยตรวจสอบให้หน่อยค่ะ เพราะว่า หากเกิดปัญหาที่ วันหยุดอีก ไม่ทราบว่าหน่วยงานไหน ต้องทำการแก้ไขให้ได้ค่ะ	medium	C	\N	23	2026-06-21 20:53:40.593099	2026-06-08 00:00:00	Automation	2026-06-08 00:00:00	ยังไม่พบสาเหตุ เบื้องต้นทำการ Update Location ที่ Tag ให้เป็น RUL-3 และเปิด Audit Log ไว้ตรวจสอบข้อมูลเพิ่มเติมหากมีเคสนี้เกิดขึ้นอีก	\N	\N	\N	14	SRN	SRN2606002	\N	Order Shipping	\N	Customized	Customized Bug	K.Jintana	2026-06-08	09:25:00	จังหวะทำ job receipt ระบบจะดึง Loc ตาม Production Line ที่อยู่ที่หน้าจอ ppcc_job operation โดยที่ job ที่เกิดปัญหาระบบไปดึง RUL-2 มา แต่ตอนนี้ยังตรวจสอบต่อไม่พบว่าทำไมระบบถึงดึง RUL-2 มา เพราะ Transaction ทำรับด้วย RUL-3 ถูกต้องแล้ว แต่ผิดเฉพาะแท็กที่ไปดึง RUL-2 มาอัพเดต	\N	2026-06-11
1159	รายการที่บันทึกไม่โชว์ในรายงานภาษีขาย	เนื่องจากทางบัญชีได้ทำการบันทึกตามที่ PPCC  แจ้งแล้ว แต่รายการยังไม่ออกรายงานภาษีขาย\nรบกวนทีม PPCC ตรวจสอบและดำเนินการค่ะ	medium	C	\N	14	2026-06-21 20:53:40.596057	2026-01-07 00:00:00	AR	2026-01-07 00:00:00	ใส่เงื่อนไขที่ถูกต้อง ควรจะเป็นเลขที่ Invoice ในระบบ เช่น TAK6812001-TAK6812005	\N	\N	\N	14	TAK	TAK2601003	\N	PPCC Sales VAT Register	\N	Localized	Human Error	K.Jittima	2026-01-07	13:25:00	เงื่อนไขการเรียกรายงานพบว่า User ใส่เงื่อนไข Invoice เป็น TAK*-TAK* ซึ่งไม่ถูกต้อง จึงทำให้รายงานไม่แสดง	\N	2026-01-12
1108	แจ้งปัญหาข้อมูลไม่ถูกต้องค่ะ	รบกวนตรวจสอบข้อมูลตามนี้ค่ะ\nPO : RM25120007\nGRN : R2601000000050\nVender : ECO TEX BANGKOK CO.,LTD.\n\nเบื้องต้น ตรวจสอบที่ได้ข้อมูลแล้วว่าไม่ตรงกัน รบกวนตรวจสอบให้หน่อยค่ะว่าเกิดจากสาเหตุอะไร\n1.รูปที่ 1 ในหน้า PPCC_Purchase Order Lines   มีการซื้อเข้ามาทั้งหมด 1 รายการซึ่งราคา Cost = 13 บาท ค่ะ  \n2.รูปที่ 2  เมื่อดูข้อมูลที่ การรับ Type : Receopt ในหน้า PPCC_Material Transactions  พบว่า ในช่อง Total Posted  ข้อมูลยอดรวมไม่ถูกต้อง   \n3.รูปที่ 3  ข้อมูลในหน้า PPCC_Inventory Balance Report 8 Digits ราคาหน่วยทำไมเป็น 21.38 บาทคะ\n\nจากที่ดูข้อมูล ระบบคำนวณ 5,752 x 21.38 = 122,977.76 บาท   อยากทราบว่าทำไมถึงจับราคานี้มาคะ  รบกวนขอสาทราบสาเหตุที่เกิดขึ้นด้วยนะคะ จะได้รู้ว่าเกิดจากอะไร\n\nรบกวนอัพเดตข้อมูลในหน้านี้ด้วยนะคะ เพราะการคำนวณผิดเลยกระทบไปหลายรายงานเลยค่ะ\n\nPPCC_Journal Entries เล่ม PO Dist\nPPCC_Material Transactions\nPPCC_Material Transactions Amount\nPPCC_Inventory Balance Report 8 Digits\n\nไม่แน่ใจว่ายังมีหน้าอื่นๆเพิ่มไหม รบกวน PPCC ตรวจสอบและแก้ไขให้ด้วยนะคะ	medium	C	\N	14	2026-06-21 20:53:40.482984	2026-01-14 00:00:00	IC	2026-01-14 00:00:00	เบื้องต้นทำการแก้ไขยอดเงินที่ Material Transaction และ G/L Posted Transaction	\N	\N	\N	14	SRN	SRN2601004	\N	PPCC_Material Transactions	\N	Customized	Unidentified	K.Sunisa	2026-01-13	17:15:00	จังหวะทำรับ PO เกิดการบันทึกบัญชี Inventory Adjustment	\N	2026-01-16
1171	รบกวนแก้ไขเลขที่ Runnumber	รบกวนแก้ไขเลขที่ Runnumber  เนื่องจากไม่ถูกต้อง\nSR69020018  แก้ไขเป็น  SR69020010\nDR69020002 แก้ไขเป็น  DR69020001\n	medium	C	\N	14	2026-06-21 20:53:40.606599	2026-02-09 00:00:00	PAJ	2026-02-09 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2602003	\N	PPCC_PriceAdjustmentInvoice	\N	Customized	Customized Bug	K.Jittima	2026-02-06	10:35:00	\N	\N	2026-02-11
1163	ระบบรายงานเวลาเบิ้ล	ช่วยเช็คให้หน่อยค่ะ ระบบรายงานเวลาเบิ้ล T250402566	medium	C	\N	18	2026-06-21 20:53:40.599501	2026-01-07 00:00:00	SFC	2026-01-07 00:00:00	คาดว่าอาจจะเกิดจากการที่มีการกรอกข้อมูลการรายงานของการ Setup มา 2 ครั้งครับ จึงทำให้เกิดการเบิ้ล\r\nซึ่งที่รายงานผลเข้ามาเบิ้ลสามารถทำการถอยได้ โดยที่ทำการถอยเฉพาะในส่วนของเวลา Setup ที่เบิ้ลมาครับ โดยที่ควรทำการถอยเนวันที่ปัจจุบัน เพื่อไม่ให้กระทบกับงบการเงินที่ปิดไปแล้วครับ\r\nแต่ถ้าไม่ทำการถอยก็ได้ครับ เนื่องจากว่าผลต่างจะไปอยู่ใน Variance ตอนปิด Job แล้วครับ	\N	\N	\N	18	TAK	TAK2601007	\N	Post Job Transaction	\N	Standard	Technical	K.Naruedee	2026-01-07	\N	\N	\N	2026-01-07
1164	ถอย PO ไม่ได้คะ	รบกวนช่วยดูเคสนี้ ให้หน่อยค่ะ ไม่สามารถ ถอย PO ได้ ทั้ง 2 line เลยนะคะ	medium	C	\N	18	2026-06-21 20:53:40.600616	2026-01-16 00:00:00	PO	2026-01-16 00:00:00	สาเหตุที่ทำการถอยของ line 1 ไม่ได้เนื่องจากว่า Item : RM3-SOV-SIW01-HARDENER-NO-10 ไม่มีของใน Location : RM-1 (รูปที่ 1) จึงทำการถอยไม่ได้ แต่ว่ามีของใน Location : Stock จำนวน 16 KG (รูปที่ 1) และเมื่อเช็คจาก Material Transaction พบว่า Item นี้ได้ทำการรับเข้ามาใน Location : Stock จำนวน 16 KG (รูปที่ 2) ถ้าหากจะทำการถอยของรายการนี้ต้องทำการถอยที่ Location : Stock ครับ\r\n\r\nและในส่วนของ line 2 จากการตรวจสอบ Material Transaction พบว่า Item : RM2-INK-SIW01-VARNISH-MAT-EK2K ได้ทำการรับเข้ามาใน Location : Stock จำนวน 192 KG (รูปที่ 2) ถ้าหากจะทำการถอยของรายการนี้ ต้องทำการถอยที่ Location : Stock เหมือนกันครับเนื่องจากว่า Item นี้มีของใน Location : Stock จำนวน 192 KG (รูปที่ 3) ครับ	\N	\N	\N	18	TAK	TAK2601008	\N	Purchase Orde Receiving	\N	Standard	Knowledge	K.Naruedee	2026-01-16	\N	\N	\N	2026-01-16
1170	ตรวจสอบรายการ Price Adjustment รายละเอียดออกไม่ครบ	รบกวนตรวจสอบรายการลดหนี้  ตามหน้า Adjustment  ไม่ออก Vat และรายละเอียดลูกค้า\nแต่หน้าแบบฟอร์ม ออกรายละเอียดครบ\n	medium	C	\N	14	2026-06-21 20:53:40.605789	2026-02-09 00:00:00	AR	2026-02-09 00:00:00	คีย์ข้อมูล Ship To = 0	\N	\N	\N	14	TAK	TAK2602002	\N	PPCC_PriceAdjustmentInvoice	\N	Customized	Human Error	K.Jittima	2026-02-05	13:55:00	ไม่ได้ใส่ข้อมูล Ship To	\N	2026-02-10
1172	แก้ไขภาษีซื้อ	รบกวนแก้ไขรายงานภาษีซื้อ ตามไฟล์แนบคะ	medium	C	\N	14	2026-06-21 20:53:40.607284	2026-02-10 00:00:00	AR	2026-02-10 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2602004	\N	PPCC_Input Vat Report	\N	Localized	PPCC Localized	K.Nattakan	2026-02-10	08:55:00	\N	\N	2026-02-13
1187	แก้ไขเลขใบกำกับภาษี	รบกวนแก้ไขเลขใบกำกับภาษี ใน APV 88397 จากเลข 1526032571  เป็น 1526032634	medium	C	\N	14	2026-06-21 20:53:40.622375	2026-04-01 00:00:00	AP	2026-04-01 00:00:00	Update Database	\N	\N	\N	14	TAK	TAK2604001	\N	AP Posted Transaction Detail	\N	Localized	PPCC Localized	K.Nattakan	2026-04-01	10:10:00	\N	\N	2026-04-06
1214	PPCC APVouchersandAdjustments	รบกวนแก้ไขวันที่ Invoice Date 27/04/2026 .ให้เป็น วันที่ 27/03/2026  ให้หน่อยคะ  Voucher 159492	medium	C	\N	14	2026-06-21 20:53:40.657109	2026-04-03 00:00:00	AP	2026-04-03 00:00:00	Update Database	\N	\N	\N	14	TTSC	TTSC260402	\N	PPCC APVouchersandAdjustments	\N	Localized	PPCC Localized	KASSARIN	2026-04-01	13:45:00	\N	\N	2026-04-06
1119	แจ้งปัญหา ระบบค้าง ค่ะ ทำให้ Pick List No.P260218001  เกิดปัญหา Stock เบิ้ล ค่ะ รบกวนช่วยตรวจสอบให้หน่อยค่ะ	แจ้งปัญหา ระบบค้าง ค่ะ ทำให้ Pick List No.P260218001  เกิดปัญหา Stock เบิ้ล ค่ะ รบกวนช่วยตรวจสอบให้หน่อยค่ะ	medium	C	\N	23	2026-06-21 20:53:40.509689	2026-02-18 00:00:00	Automation	2026-02-18 00:00:00	ทำถอยรายการตัด Stock ผ่านหน้าจอ Order Shipping	\N	\N	\N	14	SRN	SRN2602009	\N	Order Shipping	\N	Customized	Human Error	K.Jintana	2026-02-17	13:25:00	\N	\N	2026-02-23
1190	รบกวนแก้ไขเลขที่ Run number	เนื่องจากทีมบัญชี จะ Post แต่ไม่สามารถ Post ได้ รบกวนตรวจสอบค่ะ	medium	C	\N	14	2026-06-21 20:53:40.624384	2026-04-03 00:00:00	AR	2026-04-03 00:00:00	User แก้ไขโดยใส่ New Price แต่เมื่อเรียกรายงานแสดงยอดเงินไม่ถูกต้องทาง PPCC จึงแก้ไขรายงานและดึงรายงานให้ User แทน	\N	\N	\N	14	TAK	TAK2604004	\N	PPCC_PriceAdjustmentInvoice	\N	Customized	Knowledge	K.Jittima	2026-04-03	09:15:00	โปรแกรม Price Adjustment จะต้องแก้ไขราคาระบบจึงจะคำนวณ Line Net, Sales Tax, Invoice Total ให้	\N	2026-04-08
1176	สอบถามเนื่องจาก Post เพิ่มหนี้ไม่ได้	เนื่องจากทางทีมบัญชีได้ทำการ Post DR69020003  ไม่สามารถPost  เพิ่มหนี้ได้\nรบกวนทาง PPCC ตรวจสอบรายการนี้ค่ะ	medium	C	\N	14	2026-06-21 20:53:40.612855	2026-03-04 00:00:00	PAJ	2026-03-04 00:00:00	ลบข้อมูล CO Line 4,5 ให้เหลือเพียง 1 รายการ	\N	\N	\N	14	TAK	TAK2603001	\N	PPCC_PriceAdjustmentInvoice	\N	Customized	Customized Bug	K.Jittima	2026-03-02	16:20:00	CO Line 4, 5 มีมากกว่า 1 รายการจึงไม่สามารถสร้างสร้างข้อมูลที่ตาราง tt_inv_adj ได้	\N	2026-03-09
1199	ข้อมูลหน้า PPCC_GLPostedTransactions ช่อง Order ไม่แปะเลข CO	รบกวนตรวจสอบและแก้ไขเคสให้ด้วยครับ เนื่องจากมีการคีย์ Inv down งาน CO ผ่าน ProgressiveBillings อ้างอิง CO : F260000043 , F260000048 \nจากนั้นตรวจสอบที่หน้า PPCC_GLPostedTransactions ที่ Tab Additional ช่อง Order ไม่แปะเลข CO ครับ\n	medium	C	\N	14	2026-06-21 20:53:40.634988	2026-04-08 00:00:00	GL	2026-04-08 00:00:00	แก้ไข Reference เป็น มัดจำ 30% FIIN02600029 และ มัดจำ 30% FIIN02600030	\N	\N	\N	14	TG	TG26040001	\N	PPCC_GLPostedTransactions	\N	Application Support	Knowledge	K.Nattakit	2026-04-07	16:40:00	บันทึก Reference เป็น FIIN02600029 มัดจำ 30% และ FIIN02600030 มัดจำ 30% จึงทำให้เงื่อนไขการตัดข้อความจาก Reference เพื่อหาเลขที่ Invoice ทำงานไม่ถูกต้อง	\N	2026-04-13
1194	สอบถามรายงานGL	รบกวนตรจสอบรายงานในGLให้หน่อยค่ะว่าเรียกGL  รายงานออกไม่เหมือนกันดังรูปข้างล่าง GL 2124-02\nกรณีที่ 1 รายงานแสดงข้อมูลไม่ตรงกัน\nแบบที่ 1 เรียกGL ตั้งแต่01/01/2026-31/03/2026  ข้อมูลเป็น 0ถูกต้อง\nแบบที่2  เรียกGL ตั้งแต่01/03/2026-31/03/2026  เรียกเงื่อนไขเหมือนกัน แต่รายงานออกไม่ตรงกัน\nกรณีที่2  รายการนี้ไม่มีเอกสาร แต่มีในระบบซึ่งตอนเดือน 2 ปิดตัวเลขไปแล้วไม่มีข้อมูลชุดนี้ ไม่รู้เกิดจากสาเหตุอะไร รบตรวจสอบให้ทีนะค่ะ	medium	C	\N	14	2026-06-21 20:53:40.627149	2026-04-08 00:00:00	GL	2026-04-08 00:00:00	ลบข้อมูลที่ตาราง ledger_all	\N	\N	\N	14	TAK	TAK2604008	\N	General Ledger	\N	Standard	Standard Bug	K.Budsaya	2026-04-06	07:30:00	คาดว่าเกิดจากลบข้อมูล Reference APPR KNA0002 ที่ตาราง ledger แต่ข้อมูลที่ตาราง ledger_all ไม่ได้ถูกลบตามไปด้วยจึงทำให้เกิดยอดค้างจำนวน -20916.23	\N	2026-04-10
1200	รบกวนช่วยตรวจสอบ icash รอบ 14.10 น. วันนี้ให้ด้วยครับ Task Failed ครับ	รบกวนช่วยตรวจสอบ icash รอบ 14.10 น. วันนี้ให้ด้วยครับ Task Failed ครับ\nรายการที่ส่งเข้ามาครับ\nTotal size: 40 row(s)\n\nSuccess : 34 Batch(s)\nSite name: ERP_PKM / Success : 9 Batch(s)\n\n\nEmployee Batch ID \n49034 WAP-2A26052500001 \n60371 WAP-2A26052500005 \n61014 WAP-2C26052500004 \n61014 WAP-2C26052500005 \n53047 WAP-2P26052500005 \n60371 WAP-2P26052500017 \n66016 WAP-2P26052500020 \n66016 WAP-2P26052500021 \n68085 WAP-2P26052500022 \n\n\nSite name: ERP_PK / Success : 2 Batch(s)\n\n\nEmployee Batch ID \n55091 WAP-2A26052500002 \n63020 WAP-2A26052500006 \n\n\nSite name: ERP_TG / Success : 16 Batch(s)\n\n\nEmployee Batch ID \n56147 WAP-2A26052500003 \n58121 WAP-2A26052500004 \n69029 WAP-2A26052500007 \n57360 WAP-2C26052500001 \n57360 WAP-2C26052500002 \n57360 WAP-2C26052500003 \n56147 WAP-2P26052500006 \n56147 WAP-2P26052500007 \n58152 WAP-2P26052500008 \n58152 WAP-2P26052500009 \n58152 WAP-2P26052500010 \n58152 WAP-2P26052500011 \n58202 WAP-2P26052500012 \n58202 WAP-2P26052500013 \n58202 WAP-2P26052500014 \n58202 WAP-2P26052500015 \n\n\nSite name: ERP_PKT / Success : 7 Batch(s)\n\n\nEmployee Batch ID \n45025 WAP-2P26052500001 \n45025 WAP-2P26052500002 \n47121 WAP-2P26052500003 \n47121 WAP-2P26052500004 \n60144 WAP-2P26052500016 \n62053 WAP-2P26052500018 \n65244 WAP-2P26052500019	medium	C	\N	23	2026-06-21 20:53:40.635943	2026-05-25 00:00:00	ISH	2026-05-25 00:00:00	Run Stored Procedure PPCC_ICash_BGInsertSp	\N	\N	\N	14	TG	TG26050001	\N	Sync i-Cash	\N	Customized	Technical	Alex Bozo (Line)	2026-05-25	14:15:00	ระบบ Deadlock	\N	2026-05-28
1206	(no subject)	ต้องการให้ตรวจสอบ AR ---> Invoices, Debit and Credit Memos ค่ะ\n\nยังไม่ได้ทำการดึงข้อมูลมาตั้งหนี้เลยค่ะ แต่มีรายการแสดงที่บัญชีค่ะ\n\nส่วนInvoices ที่ทำการดึง แต่ไม่แสดงรายการ มี 8 ใบค่ะ 552, 553, 625, 650, 670, 671, 701, 703	medium	C	\N	14	2026-06-21 20:53:40.641757	2026-01-28 00:00:00	AR	2026-01-28 00:00:00	ลบ Invoice ขึ้นต้น DO และ VO และแก้ไข Invoice Number ให้ตรงกับ DO	\N	\N	\N	14	TTSC	TTSC260106	\N	Invoices, Debit and Credit Memos	\N	Customized	Human Error	Amporn	2026-01-27	13:40:00	เวลา 9.44 น. มีการ Post Delivery Order โดยไม่ใส่เงื่อนไข จึงทำให้ระบบกวาด CO ที่ตัด Stock แต่ยังไม่ออก Invoice มาออก Invoice ทั้งหมด ในส่วน Invoice ที่แจ้งว่าทำการ Post แต่ไม่มีรายการ เกิดจากระบบ Post DO เรียบร้อยแล้วแต่ระบบไม่แก้ไข Invoice Number ให้ตรงกับเลขที่ DO	\N	2026-01-30
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: tunited
--

COPY public.users (id, name, email, password_hash, role, created_at, is_verified, cust_num, reset_password_token, reset_password_expires) FROM stdin;
11	somchai	supachai.athan@live.com	$2a$10$VzzqwSpxtjy7eJRKciryOevSJSAG4toOtSf2yYYwo0zdJ9qUO9afS	Customer	2026-06-02 13:32:54.76252	t	ADI	9d69c77414c9895c41282dc848ce5629317f2e4cbc5d4a0fe43f3c9dcacb6868	2026-06-05 00:40:32.81
1	Supachai Athan	supachai.a@ppcc.co.th	$2a$10$8TTaP1kOivDx6GiMtmxkv.ez/H2oCQCHZKCBPwE6i3NTc9ygJ5Qr2	Admin	2026-05-26 09:32:28.57279	t	CUST001	\N	\N
23	Jiraporn Jittayanan	jiraporn.j@ppcc.co.th	dummy	Agent	2026-06-21 20:53:40.480617	t	\N	\N	\N
22	Chotipat Thantananon	chotipat.t@ppcc.co.th	dummy	Agent	2026-06-21 20:53:40.440093	t	\N	\N	\N
21	Jittra Chotwongvachira	jittra.c@ppcc.co.th	dummy	Agent	2026-06-21 20:53:40.402587	t	\N	\N	\N
20	Attaphol Changphasuk	attaphol.c@ppcc.co.th	dummy	Agent	2026-06-21 20:53:40.372909	t	\N	\N	\N
19	Suchawadee Phatthanaprichachan	suchawadee.p@ppcc.co.th	dummy	Agent	2026-06-21 20:53:40.347735	t	\N	\N	\N
18	Wranyu Intarasub	wranyu.i@ppcc.co.th	dummy	Agent	2026-06-21 20:53:40.343537	t	\N	\N	\N
17	Sowalot U-In	sowalot.u@ppcc.co.th	dummy	Agent	2026-06-21 20:53:40.332583	t	\N	\N	\N
15	Jirapa Jittayanan	jirapa.j@ppcc.co.th	dummy	Agent	2026-06-21 20:53:40.307542	t	\N	\N	\N
14	Jiraphan  Jittayanan	jiraphan.j@ppcc.co.th	dummy	Agent	2026-06-21 20:53:40.297539	t	\N	\N	\N
10	tee	supachai.athan@gmail.com	$2a$10$.QhcOBPcLUqrA9HBNI8Bv.oCMmguLNfa1z3mIzqRe740VjnuWhfUq	agent	2026-06-02 13:32:36.225101	t	\N	\N	\N
\.


--
-- Name: customer_contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tunited
--

SELECT pg_catalog.setval('public.customer_contracts_id_seq', 823, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tunited
--

SELECT pg_catalog.setval('public.customers_id_seq', 74, true);


--
-- Name: issue_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tunited
--

SELECT pg_catalog.setval('public.issue_types_id_seq', 4, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tunited
--

SELECT pg_catalog.setval('public.messages_id_seq', 18, true);


--
-- Name: module_program_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tunited
--

SELECT pg_catalog.setval('public.module_program_group_id_seq', 268, true);


--
-- Name: modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tunited
--

SELECT pg_catalog.setval('public.modules_id_seq', 82, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tunited
--

SELECT pg_catalog.setval('public.notifications_id_seq', 49, true);


--
-- Name: program_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tunited
--

SELECT pg_catalog.setval('public.program_types_id_seq', 5, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tunited
--

SELECT pg_catalog.setval('public.roles_id_seq', 6, true);


--
-- Name: ticket_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tunited
--

SELECT pg_catalog.setval('public.ticket_attachments_id_seq', 7, true);


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tunited
--

SELECT pg_catalog.setval('public.tickets_id_seq', 1467, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tunited
--

SELECT pg_catalog.setval('public.users_id_seq', 23, true);


--
-- Name: customer_contacts customer_contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.customer_contacts
    ADD CONSTRAINT customer_contracts_pkey PRIMARY KEY (id);


--
-- Name: customers customers_cust_num_key; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_cust_num_key UNIQUE (cust_num);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: error_types error_types_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.error_types
    ADD CONSTRAINT error_types_pkey PRIMARY KEY (error_id);


--
-- Name: issue_types issue_types_name_key; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.issue_types
    ADD CONSTRAINT issue_types_name_key UNIQUE (name);


--
-- Name: issue_types issue_types_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.issue_types
    ADD CONSTRAINT issue_types_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: module_program_group module_program_group_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.module_program_group
    ADD CONSTRAINT module_program_group_pkey PRIMARY KEY (id);


--
-- Name: modules modules_name_key; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_name_key UNIQUE (name);


--
-- Name: modules modules_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: program_types program_types_name_key; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.program_types
    ADD CONSTRAINT program_types_name_key UNIQUE (name);


--
-- Name: program_types program_types_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.program_types
    ADD CONSTRAINT program_types_pkey PRIMARY KEY (id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: support_stats support_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.support_stats
    ADD CONSTRAINT support_stats_pkey PRIMARY KEY (stat);


--
-- Name: ticket_attachments ticket_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.ticket_attachments
    ADD CONSTRAINT ticket_attachments_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_ticket_number_key; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_ticket_number_key UNIQUE (ticket_number);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_messages_ticket; Type: INDEX; Schema: public; Owner: tunited
--

CREATE INDEX idx_messages_ticket ON public.messages USING btree (ticket_id);


--
-- Name: idx_notifications_unread; Type: INDEX; Schema: public; Owner: tunited
--

CREATE INDEX idx_notifications_unread ON public.notifications USING btree (user_id, is_read);


--
-- Name: idx_notifications_user; Type: INDEX; Schema: public; Owner: tunited
--

CREATE INDEX idx_notifications_user ON public.notifications USING btree (user_id);


--
-- Name: idx_ticket_attachments_ticket; Type: INDEX; Schema: public; Owner: tunited
--

CREATE INDEX idx_ticket_attachments_ticket ON public.ticket_attachments USING btree (ticket_id);


--
-- Name: idx_tickets_agent; Type: INDEX; Schema: public; Owner: tunited
--

CREATE INDEX idx_tickets_agent ON public.tickets USING btree (agent_id);


--
-- Name: idx_tickets_customer; Type: INDEX; Schema: public; Owner: tunited
--

CREATE INDEX idx_tickets_customer ON public.tickets USING btree (customer_id);


--
-- Name: idx_tickets_status; Type: INDEX; Schema: public; Owner: tunited
--

CREATE INDEX idx_tickets_status ON public.tickets USING btree (status);


--
-- Name: messages messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: messages messages_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: ticket_attachments ticket_attachments_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.ticket_attachments
    ADD CONSTRAINT ticket_attachments_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- Name: tickets tickets_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: tickets tickets_cust_num_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_cust_num_fkey FOREIGN KEY (cust_num) REFERENCES public.customers(cust_num) ON DELETE SET NULL;


--
-- Name: tickets tickets_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: tickets tickets_resolved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tunited
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_resolved_by_fkey FOREIGN KEY (resolved_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict f7VrWXVIfXPVvypEfnf76J4woXt353qGwSWKXJ4q3pD9fjffnQWGgdbJvDoIczU

