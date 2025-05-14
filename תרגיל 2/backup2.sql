--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.4

-- Started on 2025-05-13 23:58:32 UTC

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
-- TOC entry 217 (class 1259 OID 25198)
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
-- TOC entry 218 (class 1259 OID 25203)
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
-- TOC entry 219 (class 1259 OID 25208)
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
-- TOC entry 222 (class 1259 OID 25238)
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
-- TOC entry 221 (class 1259 OID 25218)
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
-- TOC entry 220 (class 1259 OID 25213)
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
-- TOC entry 3393 (class 0 OID 25198)
-- Dependencies: 217
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.customer (customer_id, full_name, phone_number, email, join_date) FROM stdin;
1	Customer_1	050-1234561	customer1@example.com	2024-07-17
2	Customer_2	050-1234562	customer2@example.com	2024-12-01
3	Customer_3	050-1234563	customer3@example.com	2022-06-17
4	Customer_4	050-1234564	customer4@example.com	2022-02-18
5	Customer_5	050-1234565	customer5@example.com	2023-01-28
6	Customer_6	050-1234566	customer6@example.com	2023-02-20
7	Customer_7	050-1234567	customer7@example.com	2024-05-22
8	Customer_8	050-1234568	customer8@example.com	2022-07-09
9	Customer_9	050-1234569	customer9@example.com	2024-10-08
10	Customer_10	050-1234560	customer10@example.com	2023-07-11
11	Customer_11	050-1234561	customer11@example.com	2023-09-13
12	Customer_12	050-1234562	customer12@example.com	2023-09-21
13	Customer_13	050-1234563	customer13@example.com	2024-03-12
14	Customer_14	050-1234564	customer14@example.com	2023-12-21
15	Customer_15	050-1234565	customer15@example.com	2022-05-08
16	Customer_16	050-1234566	customer16@example.com	2022-02-24
17	Customer_17	050-1234567	customer17@example.com	2024-06-09
18	Customer_18	050-1234568	customer18@example.com	2023-11-30
19	Customer_19	050-1234569	customer19@example.com	2022-04-29
20	Customer_20	050-1234560	customer20@example.com	2023-05-28
21	Customer_21	050-1234561	customer21@example.com	2024-08-08
22	Customer_22	050-1234562	customer22@example.com	2023-07-29
23	Customer_23	050-1234563	customer23@example.com	2023-09-14
24	Customer_24	050-1234564	customer24@example.com	2022-09-25
25	Customer_25	050-1234565	customer25@example.com	2022-11-17
26	Customer_26	050-1234566	customer26@example.com	2022-06-27
27	Customer_27	050-1234567	customer27@example.com	2023-06-30
28	Customer_28	050-1234568	customer28@example.com	2024-12-18
29	Customer_29	050-1234569	customer29@example.com	2023-03-02
30	Customer_30	050-1234560	customer30@example.com	2022-08-07
31	Customer_31	050-1234561	customer31@example.com	2024-04-24
32	Customer_32	050-1234562	customer32@example.com	2023-07-08
33	Customer_33	050-1234563	customer33@example.com	2024-12-11
34	Customer_34	050-1234564	customer34@example.com	2023-11-09
35	Customer_35	050-1234565	customer35@example.com	2024-08-13
36	Customer_36	050-1234566	customer36@example.com	2023-12-24
37	Customer_37	050-1234567	customer37@example.com	2024-04-17
38	Customer_38	050-1234568	customer38@example.com	2024-08-14
39	Customer_39	050-1234569	customer39@example.com	2022-08-22
40	Customer_40	050-1234560	customer40@example.com	2023-10-01
41	Customer_41	050-1234561	customer41@example.com	2022-08-16
42	Customer_42	050-1234562	customer42@example.com	2024-08-21
43	Customer_43	050-1234563	customer43@example.com	2023-05-24
44	Customer_44	050-1234564	customer44@example.com	2022-07-02
45	Customer_45	050-1234565	customer45@example.com	2022-11-07
46	Customer_46	050-1234566	customer46@example.com	2024-04-19
47	Customer_47	050-1234567	customer47@example.com	2024-08-05
48	Customer_48	050-1234568	customer48@example.com	2022-02-18
49	Customer_49	050-1234569	customer49@example.com	2022-07-10
50	Customer_50	050-1234560	customer50@example.com	2023-10-21
\.


--
-- TOC entry 3394 (class 0 OID 25203)
-- Dependencies: 218
-- Data for Name: dish; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.dish (dish_id, name, price, category, is_vegan) FROM stdin;
1	Dish_1	82.08	Main	N
2	Dish_2	48.60	Dessert	Y
3	Dish_3	117.16	Dessert	Y
4	Dish_4	44.09	Main	N
5	Dish_5	38.12	Starter	Y
6	Dish_6	40.25	Dessert	N
7	Dish_7	65.22	Dessert	N
8	Dish_8	94.02	Main	N
9	Dish_9	121.19	Dessert	Y
10	Dish_10	102.02	Dessert	Y
11	Dish_11	32.36	Main	Y
14	Dish_14	98.38	Main	N
15	Dish_15	106.79	Starter	Y
16	Dish_16	99.41	Main	N
17	Dish_17	54.38	Main	N
18	Dish_18	35.94	Dessert	N
19	Dish_19	119.42	Starter	N
20	Dish_20	81.33	Dessert	Y
21	Dish_21	90.28	Dessert	N
22	Dish_22	36.54	Dessert	N
23	Dish_23	116.94	Dessert	N
24	Dish_24	73.44	Starter	Y
25	Dish_25	50.83	Main	N
26	Dish_26	102.96	Main	Y
27	Dish_27	112.74	Main	N
28	Dish_28	66.25	Starter	N
29	Dish_29	29.14	Dessert	Y
31	Dish_31	78.08	Main	Y
32	Dish_32	89.94	Main	Y
34	Dish_34	44.57	Main	Y
35	Dish_35	117.93	Dessert	Y
37	Dish_37	78.18	Main	Y
38	Dish_38	130.82	Starter	Y
39	Dish_39	58.75	Starter	Y
40	Dish_40	60.38	Main	Y
41	Dish_41	125.32	Starter	N
42	Dish_42	92.09	Starter	N
43	Dish_43	119.42	Main	N
44	Dish_44	100.62	Starter	N
45	Dish_45	56.29	Starter	Y
46	Dish_46	91.47	Main	N
47	Dish_47	116.14	Dessert	N
48	Dish_48	39.43	Main	N
49	Dish_49	44.12	Starter	Y
50	Dish_50	124.27	Starter	N
\.


--
-- TOC entry 3395 (class 0 OID 25208)
-- Dependencies: 219
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.employee (employee_id, name, hire_date, salary) FROM stdin;
1	Employee_1	2022-05-13	12302.97
2	Employee_2	2023-07-10	7645.57
3	Employee_3	2023-08-17	11750.18
4	Employee_4	2024-05-08	5785.49
5	Employee_5	2022-01-17	13175.55
6	Employee_6	2023-04-19	7076.28
7	Employee_7	2024-01-29	10258.97
8	Employee_8	2022-06-10	8960.19
9	Employee_9	2023-10-12	9945.40
10	Employee_10	2024-07-01	7135.48
11	Employee_11	2024-01-29	7319.35
12	Employee_12	2023-01-07	10282.37
13	Employee_13	2024-02-22	6791.03
14	Employee_14	2022-09-03	6950.05
15	Employee_15	2022-10-10	8392.56
16	Employee_16	2023-11-29	12194.67
17	Employee_17	2023-01-03	5553.80
18	Employee_18	2024-12-26	7411.98
19	Employee_19	2023-02-17	6861.46
20	Employee_20	2024-11-05	12888.28
21	Employee_21	2024-06-05	11230.31
22	Employee_22	2023-05-06	5537.74
23	Employee_23	2022-10-08	7643.46
24	Employee_24	2024-11-04	7568.28
25	Employee_25	2024-04-12	12417.03
26	Employee_26	2024-01-29	6498.95
27	Employee_27	2022-07-24	12647.81
28	Employee_28	2022-08-03	8391.39
29	Employee_29	2023-06-03	12333.78
30	Employee_30	2022-07-19	5986.00
31	Employee_31	2022-11-22	11943.49
32	Employee_32	2022-08-26	12610.15
33	Employee_33	2024-05-02	9149.88
34	Employee_34	2024-06-19	12819.86
35	Employee_35	2024-06-12	10411.28
36	Employee_36	2022-05-06	11113.30
37	Employee_37	2022-10-17	10121.80
38	Employee_38	2023-08-14	11062.04
39	Employee_39	2024-06-06	12970.93
40	Employee_40	2024-06-02	12364.97
41	Employee_41	2022-04-07	8898.91
42	Employee_42	2024-11-06	12565.92
43	Employee_43	2023-12-28	10808.28
44	Employee_44	2024-12-28	7942.20
45	Employee_45	2022-01-04	12849.82
46	Employee_46	2024-09-27	8508.20
47	Employee_47	2024-05-26	11994.04
48	Employee_48	2024-02-26	6871.85
49	Employee_49	2023-09-03	9616.01
50	Employee_50	2024-07-20	12282.61
\.


--
-- TOC entry 3398 (class 0 OID 25238)
-- Dependencies: 222
-- Data for Name: order_details; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.order_details (order_id, dish_id, quantity, note) FROM stdin;
1	29	4	No salt
1	18	1	Extra spicy
2	26	3	Extra spicy
2	20	1	Extra spicy
3	16	2	Gluten free
3	6	5	Extra spicy
4	19	4	
4	39	3	
5	27	4	
5	11	3	Gluten free
6	48	2	Extra spicy
6	26	3	No salt
7	26	2	Extra spicy
7	2	5	
8	25	3	Gluten free
8	41	4	No salt
9	41	2	Gluten free
9	19	1	No salt
10	41	2	Gluten free
10	27	1	No salt
11	4	2	No salt
11	46	1	No salt
12	37	5	Extra spicy
12	20	4	
13	24	2	Extra spicy
13	26	5	
14	40	4	Gluten free
14	1	1	Gluten free
15	21	2	Extra spicy
15	11	1	
16	25	5	Extra spicy
16	17	3	
17	10	1	Extra spicy
17	22	2	
18	40	5	Extra spicy
18	43	4	Extra spicy
19	48	5	Gluten free
19	46	3	Extra spicy
20	31	1	No salt
20	8	1	
21	46	2	No salt
21	3	4	
22	26	3	Extra spicy
22	25	3	Gluten free
23	49	1	Extra spicy
23	15	5	
24	43	1	No salt
24	50	1	Gluten free
25	48	1	Extra spicy
25	4	2	Gluten free
26	3	5	
26	5	2	
27	22	5	Extra spicy
27	17	5	Gluten free
28	35	1	Gluten free
28	45	3	Extra spicy
29	38	2	Gluten free
29	25	1	Extra spicy
30	31	3	Extra spicy
30	44	2	Gluten free
31	48	1	
31	28	1	
32	4	4	No salt
32	5	3	
33	41	3	Gluten free
33	23	2	Gluten free
34	50	1	No salt
34	45	3	No salt
35	31	5	Extra spicy
35	10	5	
36	32	3	Extra spicy
36	11	4	
37	42	2	Extra spicy
37	16	4	
38	11	3	Extra spicy
38	28	4	No salt
39	31	5	No salt
39	43	4	No salt
40	3	5	Extra spicy
40	42	4	Extra spicy
41	6	3	Gluten free
41	28	1	Extra spicy
42	23	1	Gluten free
42	11	5	No salt
43	41	4	
43	34	2	Extra spicy
44	4	1	Gluten free
44	24	1	Extra spicy
45	26	5	
45	47	2	
46	39	2	
46	9	1	Extra spicy
47	49	2	Gluten free
47	14	3	
48	21	3	
48	39	5	Extra spicy
49	17	5	
49	16	5	No salt
50	11	5	Extra spicy
50	7	1	
\.


--
-- TOC entry 3397 (class 0 OID 25218)
-- Dependencies: 221
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.orders (order_id, customer_id, employee_id, table_id, order_date, status, total_amount) FROM stdin;
3	3	3	3	2023-11-07	closed	89.61
5	5	5	5	2024-11-19	closed	56.58
6	6	6	6	2022-01-30	closed	242.15
8	8	8	8	2023-10-09	closed	201.48
9	9	9	9	2022-05-09	archived	222.19
10	10	10	10	2023-12-25	closed	112.70
11	11	11	11	2023-02-17	closed	287.84
12	12	12	12	2022-10-18	archived	223.16
13	13	13	13	2024-01-29	closed	86.82
14	14	14	14	2022-04-19	archived	83.53
18	18	18	18	2022-05-27	archived	255.54
19	19	19	19	2022-11-14	archived	92.89
20	20	20	20	2023-11-07	closed	242.49
22	22	22	22	2024-01-05	archived	241.07
24	24	24	24	2022-06-17	closed	290.17
25	25	25	25	2023-09-23	archived	291.94
26	26	26	26	2024-10-25	closed	62.28
27	27	27	27	2023-01-16	closed	191.79
28	28	28	28	2023-04-30	archived	132.77
29	29	29	29	2023-12-31	archived	142.48
30	30	30	30	2024-09-19	archived	222.32
31	31	31	31	2023-06-04	archived	61.15
33	33	33	33	2022-01-23	archived	88.54
34	34	34	34	2023-09-26	closed	278.72
37	37	37	37	2022-04-25	archived	236.98
39	39	39	39	2023-02-17	archived	88.69
41	41	41	41	2023-10-20	archived	264.94
43	43	43	43	2022-01-01	archived	102.33
45	45	45	45	2024-05-15	archived	267.85
47	47	47	47	2022-11-28	closed	213.72
48	48	48	48	2024-10-24	closed	197.08
49	49	49	49	2022-05-09	closed	144.05
50	50	50	50	2023-08-29	archived	177.78
1	1	1	1	2024-08-15	archived	66.74
2	2	2	2	2024-09-24	archived	173.25
4	4	4	4	2022-10-10	archived	103.79
7	7	7	7	2022-04-05	archived	171.52
15	15	15	15	2023-07-16	archived	145.40
16	16	16	16	2023-06-29	archived	237.59
17	17	17	17	2023-07-08	archived	226.65
21	21	21	21	2022-03-12	archived	266.63
23	23	23	23	2023-07-01	archived	114.16
32	32	32	32	2022-07-20	archived	103.45
35	35	35	35	2023-12-04	archived	181.26
36	36	36	36	2022-06-20	archived	118.84
38	38	38	38	2023-06-18	archived	136.96
40	40	40	40	2022-08-04	archived	201.09
42	42	42	42	2024-04-19	archived	83.65
44	44	44	44	2024-10-27	archived	293.47
46	46	46	46	2024-03-31	archived	76.47
\.


--
-- TOC entry 3396 (class 0 OID 25213)
-- Dependencies: 220
-- Data for Name: restaurant_table; Type: TABLE DATA; Schema: public; Owner: myuser
--

COPY public.restaurant_table (table_id, seats, is_available, last_cleaned) FROM stdin;
1	6	N	2022-07-29
2	2	N	2022-01-11
3	2	N	2023-06-29
4	8	N	2022-12-20
5	6	N	2022-11-13
6	8	N	2023-04-10
7	4	N	2023-09-25
8	6	N	2022-02-01
9	6	N	2023-08-24
10	8	N	2022-08-07
11	8	N	2024-05-10
12	8	N	2024-02-10
13	4	N	2022-12-09
14	8	N	2024-01-23
15	6	N	2022-01-30
16	8	N	2024-05-24
17	4	N	2023-10-01
18	6	N	2024-11-04
19	4	N	2022-10-21
20	6	N	2022-03-10
21	8	N	2022-02-12
22	6	N	2023-02-07
23	6	N	2024-11-30
24	2	N	2024-09-11
25	6	N	2022-02-10
26	8	N	2024-03-29
27	6	N	2022-02-22
28	2	N	2024-03-16
29	6	N	2022-01-05
30	8	N	2023-02-23
31	6	N	2022-07-10
32	8	N	2023-07-13
33	4	N	2023-05-29
34	2	N	2023-02-11
35	2	N	2023-04-03
36	4	N	2023-03-08
37	8	N	2024-03-27
38	4	N	2023-12-29
39	2	N	2024-07-03
40	6	N	2023-01-10
41	4	N	2024-05-27
42	8	N	2023-07-10
43	6	N	2022-10-22
44	6	N	2023-01-01
45	6	N	2024-08-17
46	6	N	2024-02-06
47	4	N	2024-10-08
48	6	N	2023-08-13
49	4	N	2024-11-16
50	2	N	2024-11-11
\.


--
-- TOC entry 3232 (class 2606 OID 25202)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 3234 (class 2606 OID 25207)
-- Name: dish dish_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.dish
    ADD CONSTRAINT dish_pkey PRIMARY KEY (dish_id);


--
-- TOC entry 3236 (class 2606 OID 25212)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3242 (class 2606 OID 25242)
-- Name: order_details order_details_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (order_id, dish_id);


--
-- TOC entry 3240 (class 2606 OID 25222)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3238 (class 2606 OID 25217)
-- Name: restaurant_table restaurant_table_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.restaurant_table
    ADD CONSTRAINT restaurant_table_pkey PRIMARY KEY (table_id);


--
-- TOC entry 3246 (class 2606 OID 25243)
-- Name: order_details order_details_dish_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.dish(dish_id);


--
-- TOC entry 3247 (class 2606 OID 25248)
-- Name: order_details order_details_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.order_details
    ADD CONSTRAINT order_details_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3243 (class 2606 OID 25223)
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- TOC entry 3244 (class 2606 OID 25228)
-- Name: orders orders_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);


--
-- TOC entry 3245 (class 2606 OID 25233)
-- Name: orders orders_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.restaurant_table(table_id);


-- Completed on 2025-05-13 23:58:32 UTC

--
-- PostgreSQL database dump complete
--

