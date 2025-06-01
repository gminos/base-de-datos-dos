--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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
-- Name: client_schedules; Type: TABLE; Schema: public; Owner: gminos
--

CREATE TABLE public.client_schedules (
    client_schedule_id integer NOT NULL,
    schedule_id integer NOT NULL,
    client_id integer NOT NULL
);


ALTER TABLE public.client_schedules OWNER TO gminos;

--
-- Name: client_schedules_client_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: gminos
--

CREATE SEQUENCE public.client_schedules_client_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_schedules_client_schedule_id_seq OWNER TO gminos;

--
-- Name: client_schedules_client_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gminos
--

ALTER SEQUENCE public.client_schedules_client_schedule_id_seq OWNED BY public.client_schedules.client_schedule_id;


--
-- Name: client_training_programs; Type: TABLE; Schema: public; Owner: gminos
--

CREATE TABLE public.client_training_programs (
    client_training_program_id integer NOT NULL,
    start_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    end_date timestamp without time zone,
    status character varying(20) NOT NULL,
    client_id integer NOT NULL,
    training_program_id integer NOT NULL,
    CONSTRAINT client_training_programs_status_check CHECK (((status)::text = ANY ((ARRAY['activo'::character varying, 'finalizado'::character varying, 'cancelado'::character varying])::text[])))
);


ALTER TABLE public.client_training_programs OWNER TO gminos;

--
-- Name: client_training_programs_client_training_program_id_seq; Type: SEQUENCE; Schema: public; Owner: gminos
--

CREATE SEQUENCE public.client_training_programs_client_training_program_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_training_programs_client_training_program_id_seq OWNER TO gminos;

--
-- Name: client_training_programs_client_training_program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gminos
--

ALTER SEQUENCE public.client_training_programs_client_training_program_id_seq OWNED BY public.client_training_programs.client_training_program_id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: gminos
--

CREATE TABLE public.clients (
    client_id integer NOT NULL,
    name character varying(15) NOT NULL,
    last_name character varying(15) NOT NULL,
    phone character varying(10) NOT NULL,
    email character varying(30) NOT NULL
);


ALTER TABLE public.clients OWNER TO gminos;

--
-- Name: clients_client_id_seq; Type: SEQUENCE; Schema: public; Owner: gminos
--

CREATE SEQUENCE public.clients_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_client_id_seq OWNER TO gminos;

--
-- Name: clients_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gminos
--

ALTER SEQUENCE public.clients_client_id_seq OWNED BY public.clients.client_id;


--
-- Name: coaches; Type: TABLE; Schema: public; Owner: gminos
--

CREATE TABLE public.coaches (
    coach_id integer NOT NULL,
    name character varying(15) NOT NULL,
    last_name character varying(15) NOT NULL,
    phone character varying(10) NOT NULL,
    availability character varying(10) NOT NULL,
    specialty character varying(15) NOT NULL,
    CONSTRAINT coaches_availability_check CHECK (((availability)::text = ANY ((ARRAY['activo'::character varying, 'inactivo'::character varying])::text[])))
);


ALTER TABLE public.coaches OWNER TO gminos;

--
-- Name: coaches_coach_id_seq; Type: SEQUENCE; Schema: public; Owner: gminos
--

CREATE SEQUENCE public.coaches_coach_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coaches_coach_id_seq OWNER TO gminos;

--
-- Name: coaches_coach_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gminos
--

ALTER SEQUENCE public.coaches_coach_id_seq OWNED BY public.coaches.coach_id;


--
-- Name: exercises; Type: TABLE; Schema: public; Owner: gminos
--

CREATE TABLE public.exercises (
    exercise_id integer NOT NULL,
    name character varying(30) NOT NULL,
    muscle_group text NOT NULL,
    type text NOT NULL,
    required_equipment text,
    duration_aprox_seconds integer NOT NULL
);


ALTER TABLE public.exercises OWNER TO gminos;

--
-- Name: exercises_exercise_id_seq; Type: SEQUENCE; Schema: public; Owner: gminos
--

CREATE SEQUENCE public.exercises_exercise_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exercises_exercise_id_seq OWNER TO gminos;

--
-- Name: exercises_exercise_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gminos
--

ALTER SEQUENCE public.exercises_exercise_id_seq OWNED BY public.exercises.exercise_id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: gminos
--

CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    price numeric(10,2) NOT NULL,
    status character varying(15) NOT NULL,
    payment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    client_training_program_id integer NOT NULL,
    CONSTRAINT payments_status_check CHECK (((status)::text = ANY ((ARRAY['pagado'::character varying, 'pendiente'::character varying])::text[])))
);


ALTER TABLE public.payments OWNER TO gminos;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: gminos
--

CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_payment_id_seq OWNER TO gminos;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gminos
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;


--
-- Name: routine_exercises; Type: TABLE; Schema: public; Owner: gminos
--

CREATE TABLE public.routine_exercises (
    routine_exercise_id integer NOT NULL,
    routine_id integer NOT NULL,
    exercise_id integer NOT NULL
);


ALTER TABLE public.routine_exercises OWNER TO gminos;

--
-- Name: routine_exercises_routine_exercise_id_seq; Type: SEQUENCE; Schema: public; Owner: gminos
--

CREATE SEQUENCE public.routine_exercises_routine_exercise_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.routine_exercises_routine_exercise_id_seq OWNER TO gminos;

--
-- Name: routine_exercises_routine_exercise_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gminos
--

ALTER SEQUENCE public.routine_exercises_routine_exercise_id_seq OWNED BY public.routine_exercises.routine_exercise_id;


--
-- Name: routine_training_program; Type: TABLE; Schema: public; Owner: gminos
--

CREATE TABLE public.routine_training_program (
    routine_training_program_id integer NOT NULL,
    status boolean NOT NULL,
    routine_id integer NOT NULL,
    training_program_id integer NOT NULL
);


ALTER TABLE public.routine_training_program OWNER TO gminos;

--
-- Name: routine_training_program_routine_training_program_id_seq; Type: SEQUENCE; Schema: public; Owner: gminos
--

CREATE SEQUENCE public.routine_training_program_routine_training_program_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.routine_training_program_routine_training_program_id_seq OWNER TO gminos;

--
-- Name: routine_training_program_routine_training_program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gminos
--

ALTER SEQUENCE public.routine_training_program_routine_training_program_id_seq OWNED BY public.routine_training_program.routine_training_program_id;


--
-- Name: routines; Type: TABLE; Schema: public; Owner: gminos
--

CREATE TABLE public.routines (
    routine_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text NOT NULL,
    objective text NOT NULL,
    level character varying(15) NOT NULL,
    duration_weeks integer NOT NULL,
    days_of_the_week integer NOT NULL,
    CONSTRAINT routines_level_check CHECK (((level)::text = ANY ((ARRAY['principiante'::character varying, 'intermedio'::character varying, 'profesional'::character varying])::text[])))
);


ALTER TABLE public.routines OWNER TO gminos;

--
-- Name: routines_routine_id_seq; Type: SEQUENCE; Schema: public; Owner: gminos
--

CREATE SEQUENCE public.routines_routine_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.routines_routine_id_seq OWNER TO gminos;

--
-- Name: routines_routine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gminos
--

ALTER SEQUENCE public.routines_routine_id_seq OWNED BY public.routines.routine_id;


--
-- Name: schedules; Type: TABLE; Schema: public; Owner: gminos
--

CREATE TABLE public.schedules (
    schedule_id integer NOT NULL,
    coach_id integer NOT NULL,
    routine_id integer NOT NULL,
    start_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    end_time timestamp without time zone
);


ALTER TABLE public.schedules OWNER TO gminos;

--
-- Name: schedules_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: gminos
--

CREATE SEQUENCE public.schedules_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schedules_schedule_id_seq OWNER TO gminos;

--
-- Name: schedules_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gminos
--

ALTER SEQUENCE public.schedules_schedule_id_seq OWNED BY public.schedules.schedule_id;


--
-- Name: training_programs; Type: TABLE; Schema: public; Owner: gminos
--

CREATE TABLE public.training_programs (
    training_program_id integer NOT NULL,
    name character varying(30) NOT NULL,
    price numeric(10,2) NOT NULL,
    goal character varying(30) NOT NULL
);


ALTER TABLE public.training_programs OWNER TO gminos;

--
-- Name: training_programs_training_program_id_seq; Type: SEQUENCE; Schema: public; Owner: gminos
--

CREATE SEQUENCE public.training_programs_training_program_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.training_programs_training_program_id_seq OWNER TO gminos;

--
-- Name: training_programs_training_program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gminos
--

ALTER SEQUENCE public.training_programs_training_program_id_seq OWNED BY public.training_programs.training_program_id;


--
-- Name: client_schedules client_schedule_id; Type: DEFAULT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.client_schedules ALTER COLUMN client_schedule_id SET DEFAULT nextval('public.client_schedules_client_schedule_id_seq'::regclass);


--
-- Name: client_training_programs client_training_program_id; Type: DEFAULT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.client_training_programs ALTER COLUMN client_training_program_id SET DEFAULT nextval('public.client_training_programs_client_training_program_id_seq'::regclass);


--
-- Name: clients client_id; Type: DEFAULT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.clients ALTER COLUMN client_id SET DEFAULT nextval('public.clients_client_id_seq'::regclass);


--
-- Name: coaches coach_id; Type: DEFAULT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.coaches ALTER COLUMN coach_id SET DEFAULT nextval('public.coaches_coach_id_seq'::regclass);


--
-- Name: exercises exercise_id; Type: DEFAULT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.exercises ALTER COLUMN exercise_id SET DEFAULT nextval('public.exercises_exercise_id_seq'::regclass);


--
-- Name: payments payment_id; Type: DEFAULT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- Name: routine_exercises routine_exercise_id; Type: DEFAULT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.routine_exercises ALTER COLUMN routine_exercise_id SET DEFAULT nextval('public.routine_exercises_routine_exercise_id_seq'::regclass);


--
-- Name: routine_training_program routine_training_program_id; Type: DEFAULT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.routine_training_program ALTER COLUMN routine_training_program_id SET DEFAULT nextval('public.routine_training_program_routine_training_program_id_seq'::regclass);


--
-- Name: routines routine_id; Type: DEFAULT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.routines ALTER COLUMN routine_id SET DEFAULT nextval('public.routines_routine_id_seq'::regclass);


--
-- Name: schedules schedule_id; Type: DEFAULT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.schedules ALTER COLUMN schedule_id SET DEFAULT nextval('public.schedules_schedule_id_seq'::regclass);


--
-- Name: training_programs training_program_id; Type: DEFAULT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.training_programs ALTER COLUMN training_program_id SET DEFAULT nextval('public.training_programs_training_program_id_seq'::regclass);


--
-- Data for Name: client_schedules; Type: TABLE DATA; Schema: public; Owner: gminos
--

COPY public.client_schedules (client_schedule_id, schedule_id, client_id) FROM stdin;
1	1	1
2	2	2
3	3	3
\.


--
-- Data for Name: client_training_programs; Type: TABLE DATA; Schema: public; Owner: gminos
--

COPY public.client_training_programs (client_training_program_id, start_date, end_date, status, client_id, training_program_id) FROM stdin;
1	2025-05-01 08:00:00	2025-08-01 08:00:00	activo	1	1
2	2025-04-01 08:00:00	2025-06-01 08:00:00	finalizado	2	2
3	2025-05-15 08:00:00	\N	cancelado	3	3
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: gminos
--

COPY public.clients (client_id, name, last_name, phone, email) FROM stdin;
1	Laura	Ramírez	5551112233	laura.ramirez@example.com
2	Diego	Torres	5553344556	diego.torres@example.com
3	Claudia	Martínez	5556677889	claudia.martinez@example.com
\.


--
-- Data for Name: coaches; Type: TABLE DATA; Schema: public; Owner: gminos
--

COPY public.coaches (coach_id, name, last_name, phone, availability, specialty) FROM stdin;
1	Juan	Pérez	5551234567	activo	Cardio
2	Ana	López	5559876543	inactivo	Fuerza
3	Pedro	Gómez	5554567890	activo	Flexibilidad
\.


--
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: gminos
--

COPY public.exercises (exercise_id, name, muscle_group, type, required_equipment, duration_aprox_seconds) FROM stdin;
1	Sentadilla	Piernas	Fuerza	Pesa	60
2	Plancha	Core	Resistencia	Ninguno	45
3	Burpees	Cuerpo Completo	Cardio	Ninguno	30
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: gminos
--

COPY public.payments (payment_id, price, status, payment_date, client_training_program_id) FROM stdin;
1	99.99	pagado	2025-05-01 08:05:00	1
2	149.99	pagado	2025-04-01 08:10:00	2
3	129.99	pendiente	2025-05-15 08:15:00	3
\.


--
-- Data for Name: routine_exercises; Type: TABLE DATA; Schema: public; Owner: gminos
--

COPY public.routine_exercises (routine_exercise_id, routine_id, exercise_id) FROM stdin;
1	1	1
2	2	2
3	3	3
\.


--
-- Data for Name: routine_training_program; Type: TABLE DATA; Schema: public; Owner: gminos
--

COPY public.routine_training_program (routine_training_program_id, status, routine_id, training_program_id) FROM stdin;
1	t	1	1
2	t	2	2
3	f	3	3
\.


--
-- Data for Name: routines; Type: TABLE DATA; Schema: public; Owner: gminos
--

COPY public.routines (routine_id, name, description, objective, level, duration_weeks, days_of_the_week) FROM stdin;
1	Rutina Quema Grasa	Rutina intensa para reducir grasa corporal	Perder peso	intermedio	8	5
2	Rutina Muscular	Entrenamiento enfocado en hipertrofia	Ganar masa	profesional	12	6
3	Inicio Fit	Rutina para principiantes que comienzan	Salud general	principiante	6	3
\.


--
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: gminos
--

COPY public.schedules (schedule_id, coach_id, routine_id, start_time, end_time) FROM stdin;
1	1	1	2025-06-01 09:00:00	2025-06-01 10:00:00
2	2	2	2025-06-02 18:00:00	2025-06-02 19:00:00
3	3	3	2025-06-03 07:00:00	2025-06-03 08:00:00
\.


--
-- Data for Name: training_programs; Type: TABLE DATA; Schema: public; Owner: gminos
--

COPY public.training_programs (training_program_id, name, price, goal) FROM stdin;
1	Pérdida de Peso	99.99	Bajar de peso
2	Musculación	149.99	Ganar masa muscular
3	Fuerza Total	129.99	Aumentar fuerza
\.


--
-- Name: client_schedules_client_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gminos
--

SELECT pg_catalog.setval('public.client_schedules_client_schedule_id_seq', 1, false);


--
-- Name: client_training_programs_client_training_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gminos
--

SELECT pg_catalog.setval('public.client_training_programs_client_training_program_id_seq', 1, false);


--
-- Name: clients_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gminos
--

SELECT pg_catalog.setval('public.clients_client_id_seq', 1, false);


--
-- Name: coaches_coach_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gminos
--

SELECT pg_catalog.setval('public.coaches_coach_id_seq', 1, false);


--
-- Name: exercises_exercise_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gminos
--

SELECT pg_catalog.setval('public.exercises_exercise_id_seq', 1, false);


--
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gminos
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 1, false);


--
-- Name: routine_exercises_routine_exercise_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gminos
--

SELECT pg_catalog.setval('public.routine_exercises_routine_exercise_id_seq', 1, false);


--
-- Name: routine_training_program_routine_training_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gminos
--

SELECT pg_catalog.setval('public.routine_training_program_routine_training_program_id_seq', 1, false);


--
-- Name: routines_routine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gminos
--

SELECT pg_catalog.setval('public.routines_routine_id_seq', 1, false);


--
-- Name: schedules_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gminos
--

SELECT pg_catalog.setval('public.schedules_schedule_id_seq', 1, false);


--
-- Name: training_programs_training_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gminos
--

SELECT pg_catalog.setval('public.training_programs_training_program_id_seq', 1, false);


--
-- Name: client_schedules client_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.client_schedules
    ADD CONSTRAINT client_schedules_pkey PRIMARY KEY (client_schedule_id);


--
-- Name: client_training_programs client_training_programs_pkey; Type: CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.client_training_programs
    ADD CONSTRAINT client_training_programs_pkey PRIMARY KEY (client_training_program_id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (client_id);


--
-- Name: coaches coaches_pkey; Type: CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.coaches
    ADD CONSTRAINT coaches_pkey PRIMARY KEY (coach_id);


--
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (exercise_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- Name: routine_exercises routine_exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.routine_exercises
    ADD CONSTRAINT routine_exercises_pkey PRIMARY KEY (routine_exercise_id);


--
-- Name: routine_training_program routine_training_program_pkey; Type: CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.routine_training_program
    ADD CONSTRAINT routine_training_program_pkey PRIMARY KEY (routine_training_program_id);


--
-- Name: routines routines_pkey; Type: CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.routines
    ADD CONSTRAINT routines_pkey PRIMARY KEY (routine_id);


--
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (schedule_id);


--
-- Name: training_programs training_programs_pkey; Type: CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.training_programs
    ADD CONSTRAINT training_programs_pkey PRIMARY KEY (training_program_id);


--
-- Name: client_schedules client_schedules_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.client_schedules
    ADD CONSTRAINT client_schedules_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(client_id) ON DELETE CASCADE;


--
-- Name: client_schedules client_schedules_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.client_schedules
    ADD CONSTRAINT client_schedules_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.schedules(schedule_id) ON DELETE CASCADE;


--
-- Name: client_training_programs client_training_programs_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.client_training_programs
    ADD CONSTRAINT client_training_programs_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(client_id) ON DELETE CASCADE;


--
-- Name: client_training_programs client_training_programs_training_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.client_training_programs
    ADD CONSTRAINT client_training_programs_training_program_id_fkey FOREIGN KEY (training_program_id) REFERENCES public.training_programs(training_program_id) ON DELETE CASCADE;


--
-- Name: payments payments_client_training_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_client_training_program_id_fkey FOREIGN KEY (client_training_program_id) REFERENCES public.client_training_programs(client_training_program_id) ON DELETE CASCADE;


--
-- Name: routine_exercises routine_exercises_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.routine_exercises
    ADD CONSTRAINT routine_exercises_exercise_id_fkey FOREIGN KEY (exercise_id) REFERENCES public.exercises(exercise_id) ON DELETE CASCADE;


--
-- Name: routine_exercises routine_exercises_routine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.routine_exercises
    ADD CONSTRAINT routine_exercises_routine_id_fkey FOREIGN KEY (routine_id) REFERENCES public.routines(routine_id) ON DELETE CASCADE;


--
-- Name: routine_training_program routine_training_program_routine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.routine_training_program
    ADD CONSTRAINT routine_training_program_routine_id_fkey FOREIGN KEY (routine_id) REFERENCES public.routines(routine_id) ON DELETE CASCADE;


--
-- Name: routine_training_program routine_training_program_training_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.routine_training_program
    ADD CONSTRAINT routine_training_program_training_program_id_fkey FOREIGN KEY (training_program_id) REFERENCES public.training_programs(training_program_id) ON DELETE CASCADE;


--
-- Name: schedules schedules_coach_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_coach_id_fkey FOREIGN KEY (coach_id) REFERENCES public.coaches(coach_id) ON DELETE CASCADE;


--
-- Name: schedules schedules_routine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gminos
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_routine_id_fkey FOREIGN KEY (routine_id) REFERENCES public.routines(routine_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

