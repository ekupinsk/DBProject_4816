--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.4

-- Started on 2025-05-13 16:00:38 UTC

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
-- TOC entry 217 (class 1259 OID 25087)
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
-- TOC entry 218 (class 1259 OID 25092)
-- Name: dish; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.dish (
    dish_id integer NOT NULL,
    name character varying(100) NOT NULL,
    price numeric(6,2) NOT NULL,
    category character varying(50) NOT NULL,
    is_vegan character(1) NOT NULL
);


ALTER TABLE public.dish OWNER TO myuser;

--
-- TOC entry 219 (class 1259 OID 25097)
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
-- TOC entry 222 (class 1259 OID 25127)
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
-- TOC entry 221 (class 1259 OID 25107)
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
-- TOC entry 220 (class 1259 OID 25102)
-- Name: restaurant_table; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.restaurant_table (
    table_id integer NOT NULL,
    seats integer NOT NULL,
    is_available character(1) NOT NULL,
    last_cleaned date NOT NULL
);


ALTER TABLE public.restaurant_table OWNER TO myuser;

--
-- TOC entry 3391 (class 0 OID 25087)
-- Dependencies: 217
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.customer (customer_id, full_name, phone_number, email, join_date) FROM stdin;
1	Alice Levi	0501234567	alice@example.com	2022-01-15
2	David Cohen	0529876543	david@example.com	2023-05-10
3	Miriam Azulay	0534567890	miriam@example.com	2024-03-22
5	Harald Squires	544-649-3105	hsquires4@altervista.org	2028-01-10
6	Boycie Lashmar	670-332-2623	blashmar5@icq.com	2024-11-28
7	Kliment Backen	522-852-1628	kbacken6@unesco.org	2030-01-05
8	Palm Angel	708-872-2107	pangel7@hugedomains.com	2029-07-13
9	Carmon Hendren	506-325-2018	chendren8@usa.gov	2024-12-29
10	Mercedes Ogglebie	357-805-2098	mogglebie9@mayoclinic.com	2027-03-19
11	Livvie Hadny	721-360-0733	lhadnya@canalblog.com	2027-10-30
12	Cord Taillant	740-979-1996	ctaillantb@cnbc.com	2028-10-19
13	Sue Alenichicov	697-160-3608	salenichicovc@jigsy.com	2024-10-14
14	Syd Mattiazzo	473-439-4782	smattiazzod@digg.com	2028-10-18
15	Kaleb Heald	698-997-4359	khealde@elpais.com	2028-10-14
22	Beverly Oneal	(906)678-6668x778	davidsara@example.com	2025-10-09
23	Jonathan Johnson	001-301-989-6365x233	andersontara@example.com	2022-10-15
24	Tammy Nielsen	(531)914-1010x54661	mark50@example.org	2022-10-16
25	Jason Payne	924.400.7871	dunnjoshua@example.net	2025-05-17
26	Jacob Bennett	(570)541-0506	nicole62@example.com	2023-04-03
27	Shelby Kelly	664-814-0236x607	rhondabaker@example.org	2022-10-02
28	Nicholas West	507-733-7564x34457	gonzalezryan@example.com	2023-03-30
1001	David Levi	0521234567	david.levi@example.com	2023-01-10
1002	Sarah Cohen	0549876543	sarah.cohen@example.com	2024-03-12
1003	Yosef Mizrahi	0506789012	yosef.m@example.com	2022-07-25
\.


--
-- TOC entry 3392 (class 0 OID 25092)
-- Dependencies: 218
-- Data for Name: dish; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.dish (dish_id, name, price, category, is_vegan) FROM stdin;
1	Pizza Margherita	42.50	Main Course	F
2	Green Salad	25.00	Starter	T
3	Chocolate Cake	29.90	Dessert	F
5	Spaghetti Carbonara	36.00	Appetizer	1
6	Vegetable Stir Fry	73.00	Entree	1
7	Beef Stroganoff	62.00	Dessert	0
8	Vegetable Stir Fry	96.00	Pasta	1
9	Lemon Herb Roasted Chicken	15.00	Main Course	0
10	Lemon Herb Roasted Chicken	61.00	Main Course	0
11	Lemon Herb Roasted Chicken	27.00	Salad	0
12	Mushroom Risotto	40.00	Soup	1
13	Lemon Herb Roasted Chicken	11.00	Appetizer	1
14	Lemon Herb Roasted Chicken	39.00	Entree	0
15	Shrimp Scampi	45.00	Starter	1
19	Mushroom Risotto	56.00	Main Course	F
20	By Plate	94.77	Main Course	T
21	Detail Dish	52.98	Starter	F
22	Whose Meal	93.58	Main Course	F
23	My Dish	32.11	Dessert	T
24	Weight Meal	22.88	Dessert	F
201	Spaghetti Plate	45.00	Main Course	F
202	Green Vegan Salad	29.90	Starter	T
203	Chocolate Cake	32.50	Dessert	F
\.


--
-- TOC entry 3393 (class 0 OID 25097)
-- Dependencies: 219
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.employee (employee_id, name, hire_date, salary) FROM stdin;
1	Yossi Mizrahi	2021-06-01	5800.00
2	Sara Ben-David	2020-03-18	7200.00
3	Ronit Peretz	2019-11-27	9000.00
5	Rodrique Iowarch	2026-08-30	9705.00
6	Petr Curteis	2027-02-04	10713.00
7	Rory Vasyaev	2027-06-07	8734.00
8	Nevsa Vicent	2030-04-17	5460.00
9	Dilan Kores	2028-06-12	11953.00
10	Cinda Bonaire	2025-09-04	6427.00
11	Even Ledwidge	2030-04-09	14485.00
12	Ed Bartosch	2028-01-09	7635.00
13	Arnold Thorley	2029-03-18	12580.00
14	Isaiah Blodg	2028-01-20	10755.00
15	Rodie Potteridge	2027-01-16	5757.00
17	Marilyn Davis	2023-06-15	14432.77
18	Leon Lee	2021-08-17	9835.35
19	Mr. David Garcia	2021-09-12	7869.68
20	Sara Manning	2022-05-20	11515.18
21	Phyllis Cruz	2020-09-27	6860.02
22	Susan Gonzalez	2018-04-15	11701.08
23	Brandon Turner	2018-01-24	10917.03
301	Eli Azulay	2019-04-01	8800.00
302	Naomi Shaked	2021-11-15	7600.00
303	Itay Sharon	2020-08-21	9400.00
\.


--
-- TOC entry 3396 (class 0 OID 25127)
-- Dependencies: 222
-- Data for Name: order_details; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.order_details (order_id, dish_id, quantity, note) FROM stdin;
100	1	2	Extra cheese
100	3	1	Warm please
101	2	1	No dressing
501	201	2	Extra sauce
501	203	1	No nuts
502	202	1	No dressing
\.


--
-- TOC entry 3395 (class 0 OID 25107)
-- Dependencies: 221
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.orders (order_id, customer_id, employee_id, table_id, order_date, status, total_amount) FROM stdin;
100	1	1	1	2025-04-08	Completed	97.50
101	2	2	2	2025-04-07	Preparing	25.00
102	3	3	3	2025-04-06	Cancelled	0.00
501	1001	301	401	2025-04-06	Completed	120.00
502	1002	302	402	2025-04-07	Preparing	89.90
503	1003	303	403	2025-04-08	Cancelled	0.00
\.


--
-- TOC entry 3394 (class 0 OID 25102)
-- Dependencies: 220
-- Data for Name: restaurant_table; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.restaurant_table (table_id, seats, is_available, last_cleaned) FROM stdin;
1	4	T	2025-04-08
2	2	F	2025-04-07
3	6	T	2025-04-06
5	5	F	2026-06-13
6	9	F	2029-02-12
7	8	T	2025-07-13
8	2	T	2028-12-26
9	6	F	2029-02-18
10	6	F	2028-01-04
11	4	T	2028-04-30
12	6	T	2026-11-08
13	5	T	2026-10-04
14	9	T	2024-06-11
15	9	T	2030-03-31
19	8	T	2023-11-19
20	6	T	2023-11-27
21	7	T	2024-06-08
22	5	F	2025-03-13
23	5	F	2024-02-15
24	9	F	2024-09-14
401	4	T	2025-04-05
402	2	F	2025-04-04
403	6	T	2025-04-03
\.


--
-- TOC entry 3230 (class 2606 OID 25091)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 3232 (class 2606 OID 25096)
-- Name: dish dish_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.dish
    ADD CONSTRAINT dish_pkey PRIMARY KEY (dish_id);


--
-- TOC entry 3234 (class 2606 OID 25101)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3240 (class 2606 OID 25131)
-- Name: order_details order_details_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (order_id, dish_id);


--
-- TOC entry 3238 (class 2606 OID 25111)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3236 (class 2606 OID 25106)
-- Name: restaurant_table restaurant_table_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.restaurant_table
    ADD CONSTRAINT restaurant_table_pkey PRIMARY KEY (table_id);


--
-- TOC entry 3244 (class 2606 OID 25132)
-- Name: order_details order_details_dish_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.dish(dish_id);


--
-- TOC entry 3245 (class 2606 OID 25137)
-- Name: order_details order_details_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3241 (class 2606 OID 25112)
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- TOC entry 3242 (class 2606 OID 25117)
-- Name: orders orders_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);


--
-- TOC entry 3243 (class 2606 OID 25122)
-- Name: orders orders_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.restaurant_table(table_id);


-- Completed on 2025-05-13 16:00:38 UTC

--
-- PostgreSQL database dump complete
--

