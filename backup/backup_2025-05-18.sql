--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.4

-- Started on 2025-05-18 19:34:04 UTC

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
-- TOC entry 217 (class 1259 OID 32965)
-- Name: customer; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.customer (
    customer_id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    phone_number character varying(20) NOT NULL,
    email character varying(100) NOT NULL,
    join_date date NOT NULL
);


ALTER TABLE public.customer OWNER TO myuser;

--
-- TOC entry 218 (class 1259 OID 32970)
-- Name: dish; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.dish (
    dish_id integer NOT NULL,
    name character varying(100) NOT NULL,
    price numeric(6,2) NOT NULL,
    category character varying(50) NOT NULL,
    is_vegan character(1) NOT NULL,
    CONSTRAINT chk_price_positive CHECK ((price >= (0)::numeric))
);


ALTER TABLE public.dish OWNER TO myuser;

--
-- TOC entry 219 (class 1259 OID 32975)
-- Name: employee; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.employee (
    employee_id integer NOT NULL,
    name character varying(100) NOT NULL,
    hire_date date NOT NULL,
    salary numeric(10,2) NOT NULL
);


ALTER TABLE public.employee OWNER TO myuser;

--
-- TOC entry 222 (class 1259 OID 33005)
-- Name: order_details; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.order_details (
    order_id integer NOT NULL,
    dish_id integer NOT NULL,
    quantity integer NOT NULL,
    note character varying(255) NOT NULL
);


ALTER TABLE public.order_details OWNER TO myuser;

--
-- TOC entry 221 (class 1259 OID 32985)
-- Name: orders; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    customer_id integer NOT NULL,
    employee_id integer NOT NULL,
    table_id integer NOT NULL,
    order_date date NOT NULL,
    status character varying(30) NOT NULL,
    total_amount numeric(8,2) NOT NULL
);


ALTER TABLE public.orders OWNER TO myuser;

--
-- TOC entry 223 (class 1259 OID 33020)
-- Name: payment; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.payment (
    payment_id integer NOT NULL,
    payment_method character varying(20) NOT NULL,
    payment_status character varying(20) NOT NULL,
    payment_date date NOT NULL,
    order_id integer NOT NULL
);


ALTER TABLE public.payment OWNER TO myuser;

--
-- TOC entry 220 (class 1259 OID 32980)
-- Name: restaurant_table; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.restaurant_table (
    table_id integer NOT NULL,
    seats integer NOT NULL,
    is_available character(1) DEFAULT 'Y'::bpchar NOT NULL,
    last_cleaned date NOT NULL
);


ALTER TABLE public.restaurant_table OWNER TO myuser;

--
-- TOC entry 3400 (class 0 OID 32965)
-- Dependencies: 217
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.customer (customer_id, full_name, phone_number, email, join_date) FROM stdin;
1	Maria Clarke	402.780.7142x2514	markbennett@example.org	2023-11-13
2	Willie Watkins	+1-280-448-6865x635	bakerjeffrey@example.org	2025-07-10
3	Michael Montgomery	(605)640-6071x36998	adamgutierrez@example.net	2025-05-31
4	Colton Booth	591.723.2736	rachel93@example.net	2022-04-12
5	Crystal Duncan	942.336.4368x184	amacias@example.com	2023-07-30
6	Larry Chan	001-629-224-0229	anthonyhernandez@example.org	2023-04-14
7	Hunter Smith	+1-271-941-1776x6711	ctaylor@example.com	2025-12-09
8	Danielle Young	(261)514-6585x9415	juareztodd@example.net	2025-07-05
9	Joe Smith	892.331.8343	patricia27@example.net	2022-02-16
10	Beth Graves	940-496-3664	laurenduncan@example.net	2024-07-19
11	Natalie Contreras	687-726-1843x498	debrahorton@example.com	2025-01-06
12	Dr. Matthew Johnson	001-923-490-5454x136	christine09@example.com	2022-10-31
13	Jose Clark	662.613.4971x58866	wclark@example.com	2022-03-24
14	Jonathan Hickman	001-356-751-9698x333	jonathan36@example.org	2025-05-17
15	Leslie Bailey	001-468-632-6102x852	janerodriguez@example.net	2022-11-26
16	Sherri Hale	001-855-838-5851x760	mendozachristopher@example.net	2023-09-08
17	Jacob Garcia	+1-323-474-4372x8846	gonzalezandrew@example.com	2024-06-25
18	Oscar Campbell	9537032804	zweaver@example.com	2025-07-19
19	Steven Roberson	(889)238-6688x79509	isaiah67@example.net	2022-05-06
20	Shannon Horne	001-665-465-8606	nfranco@example.com	2023-01-24
21	Dominique Logan	956-591-4498	markcollier@example.net	2022-02-19
22	Brandon Mccarthy	4619724802	greg75@example.net	2024-02-19
23	Olivia Bryant	+1-317-960-7598x4832	lorichapman@example.net	2023-12-23
24	Alex Miller	929-336-9762	gerald10@example.com	2022-12-18
25	George Aguilar	(355)510-2565x8042	aorr@example.org	2023-08-19
26	Sarah Austin	001-795-390-5969x280	dgutierrez@example.net	2024-05-31
27	Warren Pearson	(821)852-7895x618	ehoward@example.com	2025-02-06
28	Austin Diaz	(829)552-5256x42269	ksmith@example.net	2025-11-25
29	Heather Gilmore	001-605-470-9889x272	drewjoyce@example.org	2023-03-14
30	Brian Nichols	733-499-8894x04768	bradley34@example.org	2022-06-03
31	Zachary Kelley	850-278-8976x695	natashamartinez@example.com	2024-05-28
32	Edwin Booth	982.526.9273x1262	malik42@example.net	2023-05-24
33	Kimberly Bush	278.200.0189	ugood@example.org	2022-09-22
34	Christopher Curtis	(453)755-2918x5172	kimberlylewis@example.org	2022-11-27
35	Valerie Roberts	857-682-8515x93209	kkoch@example.net	2022-06-03
36	Carol Gentry	(942)397-5326x3900	bcooke@example.com	2024-01-09
37	Angelica Cole	836-623-2505	william86@example.com	2023-09-12
38	Deanna Mitchell	426.961.5894x634	mitchellmcguire@example.net	2024-11-13
39	Timothy Moore	001-565-625-0015	douglas93@example.org	2022-03-05
40	Michael Rowland	5108790286	matthew41@example.net	2024-07-16
41	John Garza	001-642-978-5727x236	rodriguezricky@example.com	2025-04-14
42	Robert Kelly	993-560-6691x992	susanpugh@example.net	2025-07-29
43	David Hutchinson	795.865.1175x21073	wyattmark@example.org	2022-08-25
44	April Brooks	(606)866-6453x4124	victoria46@example.com	2022-12-05
45	Danielle Hodge	(880)910-7912	erin40@example.com	2023-07-22
46	Mary Spears	001-600-776-7200x760	derekalexander@example.org	2025-03-28
47	Leslie Carroll	(495)651-3505x40234	rodriguezemily@example.net	2025-02-02
48	Daniel Harris	756-460-6085x126	troy59@example.net	2025-12-19
49	Kimberly Avery	+1-534-243-3357	robertsscott@example.net	2023-12-29
50	Thomas Pierce	(785)411-8597	bwhite@example.net	2023-07-17
51	Carol Valdez PhD	230.322.1119x8420	ujones@example.org	2022-12-16
52	Katie Hunt	001-829-333-8951x227	xfrench@example.org	2025-01-13
53	Sherry Ross	001-838-497-7344x300	taylor70@example.com	2024-02-20
54	Colin Reynolds	8019328917	rodriguezjulia@example.org	2025-10-29
55	Kelly Brown	438.693.0659x262	lking@example.com	2024-08-25
56	Sandra Hall	257-976-2892x143	hcameron@example.net	2025-09-19
57	Cynthia Sparks	316.771.8159x6866	jessicaholder@example.org	2024-03-10
58	Stacey Ewing	+1-289-907-6496	beckyharvey@example.net	2023-01-24
59	Beth Rogers	(734)532-8814x2753	lori46@example.org	2024-04-18
60	Danny Boyer	+1-824-370-3245x999	austin12@example.org	2022-10-25
\.


--
-- TOC entry 3401 (class 0 OID 32970)
-- Dependencies: 218
-- Data for Name: dish; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.dish (dish_id, name, price, category, is_vegan) FROM stdin;
1	Media Plate	32.13	Main Course	F
2	Never Meal	37.02	Starter	F
3	Ball Plate	32.71	Dessert	F
4	Hotel Dish	37.04	Dessert	F
5	No Meal	26.05	Dessert	T
6	Suffer Dish	13.02	Starter	T
7	Reality Meal	44.45	Dessert	F
8	Network Dish	77.63	Dessert	T
9	Team Meal	58.87	Main Course	F
10	Of Dish	77.16	Starter	T
11	Activity Plate	61.90	Starter	T
12	Decide Plate	60.21	Main Course	T
13	Serious Plate	78.48	Starter	T
14	A Dish	58.13	Starter	F
15	Election Dish	73.26	Dessert	T
16	Hair Meal	56.52	Starter	F
17	Herself Meal	70.51	Dessert	T
18	Often Meal	30.76	Main Course	T
19	Air Dish	90.94	Dessert	T
20	Listen Meal	16.11	Main Course	T
21	Prevent Dish	78.05	Dessert	T
22	Full Meal	94.62	Dessert	F
23	Run Meal	52.34	Dessert	F
24	Idea Meal	33.35	Main Course	T
25	Everyone Dish	71.11	Dessert	T
26	Argue Plate	81.93	Dessert	F
27	Couple Meal	46.03	Main Course	F
28	Moment Meal	71.45	Starter	T
29	Myself Plate	44.66	Main Course	T
30	Religious Plate	35.43	Starter	F
31	Either Meal	31.39	Dessert	T
32	Treat Meal	45.03	Starter	T
33	Body Dish	63.07	Main Course	T
34	Crime Plate	40.82	Main Course	F
35	Plant Dish	87.21	Dessert	T
36	Gun Meal	29.09	Dessert	T
37	Exactly Meal	78.47	Starter	T
38	Grow Meal	52.61	Starter	F
39	Week Meal	94.07	Starter	T
40	Entire Plate	67.19	Main Course	T
41	Somebody Meal	98.19	Starter	T
42	Day Plate	62.52	Dessert	T
43	Very Plate	68.56	Dessert	T
44	Attorney Dish	87.80	Starter	F
45	Song Dish	16.96	Dessert	F
46	Face Dish	24.15	Dessert	F
47	Room Dish	73.79	Dessert	T
48	Sit Dish	12.85	Starter	F
49	Address Meal	85.22	Starter	F
50	Case Dish	11.92	Starter	F
51	Any Plate	33.77	Dessert	F
52	But Dish	33.80	Main Course	T
53	Effect Meal	73.95	Starter	F
54	Pretty Plate	18.33	Main Course	T
55	Easy Plate	94.59	Dessert	F
56	Born Plate	76.35	Starter	T
57	Public Plate	29.64	Dessert	T
58	Perform Dish	63.85	Main Course	F
59	Office Meal	36.83	Dessert	F
60	Part Dish	66.08	Starter	F
\.


--
-- TOC entry 3402 (class 0 OID 32975)
-- Dependencies: 219
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.employee (employee_id, name, hire_date, salary) FROM stdin;
1	Luke Ellis	2019-02-12	13628.49
2	Craig Lewis	2015-09-23	14521.43
3	Sheila Carr	2016-03-06	7385.01
4	Carol Martinez	2020-02-01	8843.96
5	Tammy Morrow	2016-10-20	9799.39
6	Miguel Wagner	2015-04-19	14447.98
7	David Mckenzie	2020-03-18	8468.87
8	Jennifer Moore	2018-04-27	9332.86
9	Rebecca Baker	2015-02-21	6590.96
10	Austin Ortiz	2017-03-04	12556.98
11	Ashley Yates	2017-06-06	11071.20
12	Andrew Harper	2017-02-12	8192.61
13	Mary Walsh	2022-03-02	14216.47
14	Alyssa Roy	2019-02-06	6812.28
15	Jaime Henson	2020-02-26	5641.83
16	Olivia Meyer	2022-03-11	7543.25
17	Timothy Wilson	2020-11-16	14435.73
18	Christopher Owens	2023-06-25	10422.61
19	Stephanie Roman	2019-08-21	14628.35
20	Ernest Dean	2019-02-14	6646.97
21	Gary Sharp	2017-06-28	11824.46
22	James Greene	2020-08-06	10922.54
23	Maureen Wells	2019-07-02	14737.07
24	John Gibson	2015-01-25	11769.28
25	Caroline Macdonald	2020-02-11	14563.68
26	James Guerra	2020-01-26	10237.47
27	Mark Roberts	2015-03-24	9961.58
28	Gregg Jones	2023-11-26	7167.95
29	Heidi Carroll	2020-04-20	11853.63
30	Michelle Allen	2018-07-21	11367.98
31	Mr. William Mcgee	2015-10-10	14376.00
32	Herbert Peterson	2018-12-10	7656.49
33	Shelby Perkins	2017-05-01	11845.23
34	Sean Freeman	2020-06-06	6121.64
35	Catherine Hayden	2020-07-31	6709.72
36	Christine Owen	2023-02-07	12862.15
37	Seth Mueller	2019-06-27	7010.83
38	Cassandra Baker	2020-04-20	9271.20
39	Charles Beltran	2016-03-05	10447.24
40	Andrew Webster	2021-11-10	13592.99
41	Thomas Ward	2015-11-24	11207.26
42	Mary Jones DDS	2018-09-05	12947.38
43	Jorge Elliott	2023-08-21	8648.38
44	Keith Nguyen	2017-01-15	14823.05
45	Scott Anderson	2019-11-14	6462.00
46	Sandra Allen	2016-01-07	13243.38
47	James Kline	2020-01-16	7872.28
48	Richard Ramirez	2019-03-28	7736.83
49	Patricia Owen	2017-08-13	12918.17
50	Chelsea Payne	2022-04-12	11893.07
51	Anthony Perry	2023-08-26	14719.14
52	Victor Fox	2016-03-21	10613.44
53	Robert Miles	2021-07-08	8505.37
54	Emily Baker	2022-11-25	8521.82
55	Megan Walker	2021-08-23	5957.01
56	Todd Gibson MD	2015-11-12	11127.63
57	Angela Gill	2021-02-03	10371.63
58	Dorothy Burgess	2021-01-30	9754.81
59	Daniel Robinson	2022-07-18	11749.88
60	Thomas Fields	2021-01-09	9535.68
\.


--
-- TOC entry 3405 (class 0 OID 33005)
-- Dependencies: 222
-- Data for Name: order_details; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.order_details (order_id, dish_id, quantity, note) FROM stdin;
45	15	2	Yeah gun change.
37	5	3	Administration huge.
20	31	2	Street along.
57	56	2	Want lay.
14	60	4	Do because first.
22	19	4	Girl.
32	20	5	Pull establish I.
13	59	1	Value evidence bit.
27	4	1	Mrs somebody.
20	10	3	Become deep cultural
31	57	5	Paper each discuss.
54	21	2	Information until by
56	52	4	Me table.
42	3	4	Southern well.
52	57	2	Official trial court
50	17	5	Control record.
40	54	4	Base different time.
25	51	3	Wait when.
49	52	2	Democratic stock.
10	31	4	Rather central.
8	52	2	Manager wall guess.
36	6	5	Probably.
40	60	5	Deal moment send.
3	33	3	Born own spend.
38	29	1	Popular authority.
50	34	2	Property life.
10	25	3	Through.
38	27	5	Or where up.
55	50	1	Price.
41	29	1	Event year.
14	55	4	Brother rich should.
10	24	5	Federal build.
50	14	3	Bank assume natural 
33	19	2	Affect late.
34	13	4	Car consumer hospita
30	36	1	Instead take.
3	22	5	Care plan executive.
45	6	1	Dog picture measure.
5	53	4	Single want.
3	21	4	Morning.
50	16	5	Gun every ground.
2	25	3	Ago him stand.
34	44	4	Light.
45	13	2	Media themselves.
19	6	5	Energy city common.
30	24	2	Benefit mind.
18	30	1	Impact gun.
59	56	2	Inside baby pressure
18	41	2	Need guy every fund.
11	59	5	Have television say.
8	36	3	Difficult understand
1	32	3	Mission rest forward
35	52	4	Final beat probably.
11	60	4	Above teacher.
22	53	1	Never you apply.
24	48	2	Cost alone.
7	18	4	Just protect contain
17	30	4	Natural new account.
43	59	4	Mention create.
46	8	2	Write east reach.
\.


--
-- TOC entry 3404 (class 0 OID 32985)
-- Dependencies: 221
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.orders (order_id, customer_id, employee_id, table_id, order_date, status, total_amount) FROM stdin;
1	12	26	15	2025-05-18	Cancelled	173.15
2	24	7	50	2024-05-22	Cancelled	34.56
3	60	55	29	2024-04-19	Preparing	206.75
4	33	8	60	2024-07-03	Completed	283.44
5	37	13	33	2025-05-26	Completed	68.76
6	48	5	44	2025-10-02	Completed	83.22
7	34	38	22	2024-11-03	Completed	70.49
8	25	23	50	2025-01-18	Completed	175.31
9	56	19	29	2025-03-04	Cancelled	258.85
10	46	51	13	2024-03-21	Cancelled	146.19
11	14	13	25	2025-02-01	Preparing	165.00
12	41	51	28	2025-02-04	Preparing	268.90
13	30	48	10	2024-01-14	Preparing	194.29
14	10	25	12	2024-05-27	Completed	270.04
15	11	33	19	2025-02-17	Completed	27.87
16	29	60	60	2024-06-04	Cancelled	82.32
17	55	2	4	2024-06-20	Completed	113.27
18	9	34	30	2025-07-26	Cancelled	141.50
19	29	41	20	2024-02-03	Cancelled	64.04
20	14	24	14	2024-02-21	Preparing	74.16
21	1	9	51	2025-05-24	Cancelled	133.81
22	8	9	13	2025-06-23	Preparing	253.37
23	12	25	48	2024-01-06	Completed	283.65
24	55	56	11	2025-01-13	Completed	122.26
25	21	60	15	2024-05-04	Preparing	236.11
26	23	9	19	2025-01-31	Cancelled	105.42
27	40	56	12	2024-05-05	Preparing	241.13
28	35	5	35	2025-04-02	Cancelled	230.79
29	59	47	32	2025-01-10	Cancelled	240.22
30	18	27	59	2024-11-17	Preparing	212.37
31	32	27	19	2025-07-22	Preparing	46.18
32	6	59	55	2025-05-06	Cancelled	173.53
33	15	21	60	2024-12-31	Cancelled	80.57
34	33	4	23	2025-03-15	Completed	258.78
35	20	13	57	2024-12-05	Preparing	204.00
36	18	17	26	2025-07-03	Completed	218.32
37	59	36	36	2024-03-20	Preparing	27.02
38	21	1	60	2024-12-24	Preparing	187.39
39	59	8	11	2025-03-15	Cancelled	175.88
40	44	39	15	2024-09-10	Preparing	199.36
41	58	53	31	2025-12-18	Preparing	207.54
42	7	45	3	2025-09-23	Preparing	168.99
43	59	4	47	2025-07-12	Completed	52.13
44	50	56	5	2025-11-06	Completed	155.52
45	21	50	39	2024-08-06	Preparing	236.17
46	25	44	57	2024-05-15	Cancelled	75.46
47	16	58	59	2025-08-22	Cancelled	112.02
48	6	35	10	2025-09-04	Preparing	31.98
49	18	19	56	2024-12-31	Cancelled	149.36
50	13	12	31	2025-06-19	Completed	134.93
51	60	25	54	2025-09-03	Completed	65.51
52	50	46	30	2024-10-20	Preparing	145.96
53	22	4	23	2025-08-03	Cancelled	101.84
54	32	27	38	2025-07-28	Completed	183.46
55	26	45	9	2025-11-24	Preparing	39.50
56	37	36	38	2025-03-25	Preparing	299.34
57	50	48	11	2024-02-25	Completed	243.74
58	11	33	53	2024-08-07	Completed	255.89
59	16	13	55	2024-06-25	Cancelled	97.71
60	28	2	28	2025-01-17	Completed	278.70
\.


--
-- TOC entry 3406 (class 0 OID 33020)
-- Dependencies: 223
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.payment (payment_id, payment_method, payment_status, payment_date, order_id) FROM stdin;
1	PayPal	Pending	2024-03-05	1
2	Cash	Pending	2024-01-05	2
3	Cash	Paid	2024-07-06	3
4	Card	Paid	2024-09-23	4
5	Cash	Paid	2025-10-05	5
6	Card	Paid	2025-08-18	6
7	Cash	Pending	2025-01-22	7
8	PayPal	Paid	2025-09-02	8
9	Card	Paid	2025-04-03	9
10	Cash	Pending	2024-12-31	10
11	PayPal	Pending	2025-07-31	11
12	Card	Failed	2025-10-16	12
13	Cash	Pending	2025-08-02	13
14	Cash	Paid	2025-04-12	14
15	Cash	Paid	2024-10-04	15
16	Card	Paid	2024-07-10	16
17	Card	Failed	2025-03-19	17
18	PayPal	Paid	2025-11-07	18
19	PayPal	Paid	2024-08-07	19
20	PayPal	Pending	2024-09-13	20
21	Cash	Failed	2024-10-22	21
22	PayPal	Paid	2025-10-18	22
23	Card	Failed	2025-07-08	23
24	Cash	Paid	2025-05-03	24
25	PayPal	Failed	2025-10-23	25
26	PayPal	Failed	2024-09-18	26
27	Card	Pending	2025-10-07	27
28	PayPal	Failed	2024-07-29	28
29	PayPal	Failed	2025-08-03	29
30	PayPal	Paid	2024-12-15	30
31	Card	Failed	2025-07-16	31
32	Cash	Paid	2024-12-17	32
33	PayPal	Pending	2025-02-04	33
34	Cash	Failed	2025-01-02	34
35	PayPal	Failed	2024-02-04	35
36	PayPal	Failed	2024-07-28	36
37	Cash	Paid	2025-01-19	37
38	Card	Pending	2025-02-19	38
39	Card	Pending	2024-08-24	39
40	Cash	Paid	2024-09-12	40
41	PayPal	Paid	2024-04-14	41
42	Cash	Pending	2025-04-25	42
43	PayPal	Pending	2024-10-15	43
44	PayPal	Paid	2025-07-16	44
45	Card	Pending	2025-04-20	45
46	Cash	Paid	2024-01-04	46
47	Card	Paid	2024-07-01	47
48	Cash	Failed	2024-12-02	48
49	PayPal	Paid	2024-07-31	49
50	PayPal	Pending	2025-09-05	50
51	PayPal	Pending	2025-03-22	51
52	Cash	Failed	2024-02-04	52
53	Card	Paid	2024-02-22	53
54	Card	Paid	2025-03-03	54
55	Cash	Paid	2025-12-12	55
56	Cash	Pending	2024-11-19	56
57	Card	Pending	2025-04-12	57
58	Cash	Paid	2024-08-16	58
59	PayPal	Paid	2025-08-12	59
60	Card	Paid	2024-01-06	60
\.


--
-- TOC entry 3403 (class 0 OID 32980)
-- Dependencies: 220
-- Data for Name: restaurant_table; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.restaurant_table (table_id, seats, is_available, last_cleaned) FROM stdin;
1	4	T	2025-08-07
2	2	F	2024-09-14
3	10	T	2025-04-25
4	6	T	2025-12-19
5	2	F	2024-07-11
6	10	F	2024-06-28
7	10	F	2024-09-30
8	8	T	2025-11-02
9	6	T	2025-05-25
10	6	T	2025-01-27
11	6	F	2023-03-15
12	4	T	2025-06-25
13	9	F	2025-11-26
14	6	F	2025-02-26
15	5	T	2024-04-25
16	5	T	2023-06-27
17	8	T	2023-11-14
18	8	F	2023-11-08
19	6	T	2025-01-18
20	6	T	2025-04-27
21	2	T	2023-12-13
22	7	T	2025-01-22
23	9	F	2024-09-05
24	8	F	2024-11-06
25	2	F	2025-03-23
26	4	T	2024-02-27
27	3	T	2025-12-08
28	9	F	2023-07-19
29	3	F	2025-09-20
30	8	T	2024-04-03
31	10	T	2024-01-25
32	2	T	2023-04-01
33	8	T	2024-03-25
34	5	F	2023-09-05
35	8	T	2024-01-27
36	7	T	2025-02-26
37	10	T	2024-07-14
38	8	T	2023-01-14
39	8	T	2024-02-10
40	10	F	2025-09-12
41	3	T	2023-11-20
42	10	T	2023-02-24
43	10	F	2024-09-30
44	10	T	2025-10-02
45	6	T	2025-10-08
46	3	T	2023-07-09
47	4	T	2023-03-08
48	10	F	2023-01-10
49	10	F	2023-05-14
50	6	T	2025-08-04
51	3	T	2023-09-11
52	4	T	2024-01-19
53	8	F	2023-03-01
54	4	F	2025-07-09
55	9	F	2024-09-06
56	9	T	2024-12-28
57	2	F	2024-02-27
58	7	T	2025-02-05
59	3	F	2024-08-03
60	6	T	2025-09-07
\.


--
-- TOC entry 3236 (class 2606 OID 32969)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 3238 (class 2606 OID 32974)
-- Name: dish dish_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.dish
    ADD CONSTRAINT dish_pkey PRIMARY KEY (dish_id);


--
-- TOC entry 3240 (class 2606 OID 32979)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3246 (class 2606 OID 33009)
-- Name: order_details order_details_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (order_id, dish_id);


--
-- TOC entry 3244 (class 2606 OID 32989)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3248 (class 2606 OID 33024)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 3242 (class 2606 OID 32984)
-- Name: restaurant_table restaurant_table_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.restaurant_table
    ADD CONSTRAINT restaurant_table_pkey PRIMARY KEY (table_id);


--
-- TOC entry 3252 (class 2606 OID 33010)
-- Name: order_details order_details_dish_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.dish(dish_id);


--
-- TOC entry 3253 (class 2606 OID 33015)
-- Name: order_details order_details_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3249 (class 2606 OID 32990)
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- TOC entry 3250 (class 2606 OID 32995)
-- Name: orders orders_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);


--
-- TOC entry 3251 (class 2606 OID 33000)
-- Name: orders orders_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.restaurant_table(table_id);


--
-- TOC entry 3254 (class 2606 OID 33025)
-- Name: payment payment_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


-- Completed on 2025-05-18 19:34:04 UTC

--
-- PostgreSQL database dump complete
--

