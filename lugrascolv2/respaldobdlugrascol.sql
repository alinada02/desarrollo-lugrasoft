--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-07-11 18:20:11

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
-- TOC entry 245 (class 1259 OID 41083)
-- Name: Averias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Averias" (
    id_averia integer NOT NULL
);


ALTER TABLE public."Averias" OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 41137)
-- Name: Clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Clientes" (
    "Nit" numeric NOT NULL,
    nombre text NOT NULL,
    direccion text NOT NULL,
    telefono numeric NOT NULL,
    email text NOT NULL
);


ALTER TABLE public."Clientes" OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 41205)
-- Name: Facturas ; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Facturas " (
    "Nfactura" integer NOT NULL,
    fecha_facturacion date NOT NULL,
    total_factura double precision NOT NULL,
    "id_orden " integer NOT NULL
);


ALTER TABLE public."Facturas " OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 41114)
-- Name: Orden_produccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Orden_produccion" (
    id_orden integer NOT NULL,
    "Nit" integer NOT NULL
);


ALTER TABLE public."Orden_produccion" OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 41220)
-- Name: Remisiones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Remisiones" (
    "Nremision" integer NOT NULL,
    fecha_remision date NOT NULL,
    total_remision double precision NOT NULL,
    id_orden integer NOT NULL
);


ALTER TABLE public."Remisiones" OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 41178)
-- Name: Salidas_Mp_Orden; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Salidas_Mp_Orden" (
    id integer NOT NULL,
    cod_inventario integer NOT NULL,
    cantidad integer NOT NULL,
    id_orden integer NOT NULL,
    "fecha_E_produccion" date
);


ALTER TABLE public."Salidas_Mp_Orden" OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 41177)
-- Name: Salidas_Mp_Orden_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Salidas_Mp_Orden" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Salidas_Mp_Orden_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000000000
    CACHE 1
);


--
-- TOC entry 257 (class 1259 OID 41194)
-- Name: Transaccion_Factura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transaccion_Factura" (
    id integer NOT NULL,
    "Nfactura" integer NOT NULL,
    cod_inventario integer NOT NULL,
    cantidad integer NOT NULL,
    fecha_factura date NOT NULL
);


ALTER TABLE public."Transaccion_Factura" OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 41193)
-- Name: Transaccion_Factura_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Transaccion_Factura" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Transaccion_Factura_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000000000
    CACHE 1
);


--
-- TOC entry 259 (class 1259 OID 41200)
-- Name: Transaccion_Remision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transaccion_Remision" (
    id integer NOT NULL,
    "Nremision" integer NOT NULL,
    cod_inventario integer NOT NULL,
    cantidad integer NOT NULL,
    fecha_remision date NOT NULL
);


ALTER TABLE public."Transaccion_Remision" OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 41199)
-- Name: Transaccion_Remision_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Transaccion_Remision" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Transaccion_Remision_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000000000
    CACHE 1
);


--
-- TOC entry 244 (class 1259 OID 41066)
-- Name: Transaccion_ajuste; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transaccion_ajuste" (
    id integer NOT NULL,
    fecha_ajuste date NOT NULL,
    cant_ajuste numeric NOT NULL,
    descripcion text,
    id_ajuste integer NOT NULL,
    cod_inventario integer NOT NULL
);


ALTER TABLE public."Transaccion_ajuste" OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 41065)
-- Name: Transaccion_ajuste_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Transaccion_ajuste" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Transaccion_ajuste_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000000000
    CACHE 1
);


--
-- TOC entry 247 (class 1259 OID 41089)
-- Name: Transaccion_averias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transaccion_averias" (
    id integer NOT NULL,
    cant_averia numeric NOT NULL,
    fecha_averia date NOT NULL,
    id_averia integer NOT NULL,
    cod_inventario integer NOT NULL
);


ALTER TABLE public."Transaccion_averias" OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 41088)
-- Name: Transaccion_averias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Transaccion_averias" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Transaccion_averias_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 100000000
    CACHE 1
);


--
-- TOC entry 250 (class 1259 OID 41120)
-- Name: Transaccion_orden; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Transaccion_orden" (
    id integer NOT NULL,
    "fecha_Entrega" date NOT NULL,
    estado text NOT NULL,
    cod_inventario integer NOT NULL,
    cantidad integer NOT NULL,
    id_orden integer NOT NULL,
    prioridad text NOT NULL,
    fecha_creacion date NOT NULL,
    responsable text NOT NULL,
    fecha_terminacion_orden date
);


ALTER TABLE public."Transaccion_orden" OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 41119)
-- Name: Transaccion_orden_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Transaccion_orden" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Transaccion_orden_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000000000
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 33457)
-- Name: Ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ventas" (
    id_venta integer NOT NULL,
    id_factura integer NOT NULL,
    id_remi integer NOT NULL
);


ALTER TABLE public."Ventas" OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 41042)
-- Name: ajustes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ajustes (
    id_ajuste integer NOT NULL
);


ALTER TABLE public.ajustes OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 33557)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 33556)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 33565)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 33564)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 33551)
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
-- TOC entry 222 (class 1259 OID 33550)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 33571)
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 33579)
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 33578)
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 33570)
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 33585)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 33584)
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 33469)
-- Name: compras; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compras (
    id_compra integer NOT NULL,
    total_factura integer NOT NULL,
    estado boolean DEFAULT false NOT NULL
);


ALTER TABLE public.compras OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 33643)
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
-- TOC entry 234 (class 1259 OID 33642)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 33543)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 33542)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 33535)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 33534)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 236 (class 1259 OID 33671)
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 40999)
-- Name: inventario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventario (
    cod_inventario integer NOT NULL,
    nombre text NOT NULL,
    cantidad integer NOT NULL,
    id_proveedor integer DEFAULT 0 NOT NULL,
    tipo text
);


ALTER TABLE public.inventario OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 41166)
-- Name: produccion_salidasmporden; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produccion_salidasmporden (
    id bigint NOT NULL,
    cantidad integer NOT NULL,
    fecha_salida date NOT NULL,
    cod_inventario integer NOT NULL
);


ALTER TABLE public.produccion_salidasmporden OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 41165)
-- Name: produccion_salidasmporden_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.produccion_salidasmporden ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.produccion_salidasmporden_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 33462)
-- Name: proveedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proveedores (
    id_proveedor integer NOT NULL,
    nombre_proveedor text NOT NULL,
    direccion text,
    telefono text
);


ALTER TABLE public.proveedores OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 40982)
-- Name: trans_mp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trans_mp (
    id integer NOT NULL,
    nombre_mp text NOT NULL,
    cant_mp integer NOT NULL,
    costo_unitario double precision NOT NULL,
    total_linea double precision NOT NULL,
    fecha_ingreso date NOT NULL,
    unidad_medida text NOT NULL,
    id_compra integer NOT NULL,
    id_proveedor integer NOT NULL,
    cod_inventario integer NOT NULL,
    tipo text
);


ALTER TABLE public.trans_mp OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 40981)
-- Name: trans_mp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.trans_mp ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.trans_mp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1
    CYCLE
);


--
-- TOC entry 241 (class 1259 OID 41020)
-- Name: transformulas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transformulas (
    id integer NOT NULL,
    nombre text NOT NULL,
    materia1 integer,
    cant_materia1 double precision,
    materia2 integer,
    cant_materia2 double precision,
    materia3 integer,
    cant_materia3 double precision,
    materia4 integer,
    cant_materia4 double precision,
    materia5 integer,
    cant_materia5 double precision,
    materia6 integer,
    cant_materia6 double precision,
    materia7 integer,
    cant_materia7 double precision,
    materia8 integer,
    cant_materia8 double precision,
    cod_inventario integer NOT NULL,
    porcentajeiva double precision NOT NULL,
    pocentajeutilidad double precision NOT NULL,
    costosindirectos double precision NOT NULL
);


ALTER TABLE public.transformulas OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 41019)
-- Name: transformulas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.transformulas ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.transformulas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000000000
    CACHE 1
);


--
-- TOC entry 5104 (class 0 OID 41083)
-- Dependencies: 245
-- Data for Name: Averias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Averias" (id_averia) FROM stdin;
20001
\.


--
-- TOC entry 5110 (class 0 OID 41137)
-- Dependencies: 251
-- Data for Name: Clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Clientes" ("Nit", nombre, direccion, telefono, email) FROM stdin;
1019161271	keyden said peña 	bogota suba pinar	3232510605	kevin.alfred.sanchez@gmail.com
28150724	Monica Calzadilla	giron santander 	3224799858	kevin.alfred.sanchez@gmail.com
\.


--
-- TOC entry 5119 (class 0 OID 41205)
-- Dependencies: 260
-- Data for Name: Facturas ; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Facturas " ("Nfactura", fecha_facturacion, total_factura, "id_orden ") FROM stdin;
100000001	2024-07-09	9010074.54	40004
\.


--
-- TOC entry 5107 (class 0 OID 41114)
-- Dependencies: 248
-- Data for Name: Orden_produccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Orden_produccion" (id_orden, "Nit") FROM stdin;
40001	1019161271
40002	1019161271
40003	28150724
40004	1019161271
40005	28150724
40006	1019161271
\.


--
-- TOC entry 5120 (class 0 OID 41220)
-- Dependencies: 261
-- Data for Name: Remisiones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Remisiones" ("Nremision", fecha_remision, total_remision, id_orden) FROM stdin;
200000001	2024-07-09	885236	40003
200000002	2024-07-09	19039382.5	40001
\.


--
-- TOC entry 5114 (class 0 OID 41178)
-- Dependencies: 255
-- Data for Name: Salidas_Mp_Orden; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Salidas_Mp_Orden" (id, cod_inventario, cantidad, id_orden, "fecha_E_produccion") FROM stdin;
82	500006	1	40006	2024-07-03
83	500029	5	40006	2024-07-03
84	500051	1	40006	2024-07-03
85	601262	8	40006	2024-07-03
86	900002	69	40006	2024-07-03
87	900100	1	40006	2024-07-03
88	900102	2	40006	2024-07-03
\.


--
-- TOC entry 5116 (class 0 OID 41194)
-- Dependencies: 257
-- Data for Name: Transaccion_Factura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Transaccion_Factura" (id, "Nfactura", cod_inventario, cantidad, fecha_factura) FROM stdin;
9	100000001	100608	6	2024-07-09
\.


--
-- TOC entry 5118 (class 0 OID 41200)
-- Dependencies: 259
-- Data for Name: Transaccion_Remision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Transaccion_Remision" (id, "Nremision", cod_inventario, cantidad, fecha_remision) FROM stdin;
16	200000001	100606	8	2024-07-09
17	200000002	100608	15	2024-07-09
18	200000002	100606	1	2024-07-09
\.


--
-- TOC entry 5103 (class 0 OID 41066)
-- Dependencies: 244
-- Data for Name: Transaccion_ajuste; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Transaccion_ajuste" (id, fecha_ajuste, cant_ajuste, descripcion, id_ajuste, cod_inventario) FROM stdin;
32	2024-06-06	-10	llegaron menos	10001	900002
\.


--
-- TOC entry 5106 (class 0 OID 41089)
-- Dependencies: 247
-- Data for Name: Transaccion_averias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Transaccion_averias" (id, cant_averia, fecha_averia, id_averia, cod_inventario) FROM stdin;
61	10	2024-06-06	20001	900002
\.


--
-- TOC entry 5109 (class 0 OID 41120)
-- Dependencies: 250
-- Data for Name: Transaccion_orden; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Transaccion_orden" (id, "fecha_Entrega", estado, cod_inventario, cantidad, id_orden, prioridad, fecha_creacion, responsable, fecha_terminacion_orden) FROM stdin;
49	2024-06-28	en proceso	100608	1	40006	menos urgente	2024-06-25	kevin	\N
50	2024-06-28	en proceso	100606	1	40006	menos urgente	2024-06-25	kevin	\N
51	2024-06-28	en proceso	800071	1	40006	menos urgente	2024-06-25	kevin	\N
48	2024-06-30	por facturar	100606	2	40005	urgente	2024-06-25	lorena	2024-07-03
47	2024-06-26	por facturar	100608	6	40004	no urgente	2024-06-25	lorena	2024-07-03
46	2024-06-30	por facturar	100606	8	40003	menos urgente	2024-06-24	KeydenSaid	2024-07-03
45	2024-06-29	por facturar	100608	10	40002	no urgente	2024-06-24	lorena	2024-07-03
43	2024-06-27	por facturar	100608	15	40001	no urgente	2024-06-22	lorena	2024-07-05
44	2024-06-27	por facturar	100606	1	40001	no urgente	2024-06-22	lorena	2024-07-05
\.


--
-- TOC entry 5074 (class 0 OID 33457)
-- Dependencies: 215
-- Data for Name: Ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Ventas" (id_venta, id_factura, id_remi) FROM stdin;
\.


--
-- TOC entry 5101 (class 0 OID 41042)
-- Dependencies: 242
-- Data for Name: ajustes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ajustes (id_ajuste) FROM stdin;
10001
\.


--
-- TOC entry 5084 (class 0 OID 33557)
-- Dependencies: 225
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- TOC entry 5086 (class 0 OID 33565)
-- Dependencies: 227
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- TOC entry 5082 (class 0 OID 33551)
-- Dependencies: 223
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
25	Can add auth group	10	add_authgroup
26	Can change auth group	10	change_authgroup
27	Can delete auth group	10	delete_authgroup
28	Can view auth group	10	view_authgroup
29	Can add auth group permissions	11	add_authgrouppermissions
30	Can change auth group permissions	11	change_authgrouppermissions
31	Can delete auth group permissions	11	delete_authgrouppermissions
32	Can view auth group permissions	11	view_authgrouppermissions
33	Can add auth permission	12	add_authpermission
34	Can change auth permission	12	change_authpermission
35	Can delete auth permission	12	delete_authpermission
36	Can view auth permission	12	view_authpermission
37	Can add auth user	13	add_authuser
38	Can change auth user	13	change_authuser
39	Can delete auth user	13	delete_authuser
40	Can view auth user	13	view_authuser
41	Can add auth user groups	14	add_authusergroups
42	Can change auth user groups	14	change_authusergroups
43	Can delete auth user groups	14	delete_authusergroups
44	Can view auth user groups	14	view_authusergroups
45	Can add auth user user permissions	15	add_authuseruserpermissions
46	Can change auth user user permissions	15	change_authuseruserpermissions
47	Can delete auth user user permissions	15	delete_authuseruserpermissions
48	Can view auth user user permissions	15	view_authuseruserpermissions
49	Can add django admin log	16	add_djangoadminlog
50	Can change django admin log	16	change_djangoadminlog
51	Can delete django admin log	16	delete_djangoadminlog
52	Can view django admin log	16	view_djangoadminlog
53	Can add django content type	17	add_djangocontenttype
54	Can change django content type	17	change_djangocontenttype
55	Can delete django content type	17	delete_djangocontenttype
56	Can view django content type	17	view_djangocontenttype
57	Can add django migrations	18	add_djangomigrations
58	Can change django migrations	18	change_djangomigrations
59	Can delete django migrations	18	delete_djangomigrations
60	Can view django migrations	18	view_djangomigrations
61	Can add django session	19	add_djangosession
62	Can change django session	19	change_djangosession
63	Can delete django session	19	delete_djangosession
64	Can view django session	19	view_djangosession
65	Can add ajustes	20	add_ajustes
66	Can change ajustes	20	change_ajustes
67	Can delete ajustes	20	delete_ajustes
68	Can view ajustes	20	view_ajustes
69	Can add averias	21	add_averias
70	Can change averias	21	change_averias
71	Can delete averias	21	delete_averias
72	Can view averias	21	view_averias
73	Can add inventario	22	add_inventario
74	Can change inventario	22	change_inventario
75	Can delete inventario	22	delete_inventario
76	Can view inventario	22	view_inventario
77	Can add proveedores	23	add_proveedores
78	Can change proveedores	23	change_proveedores
79	Can delete proveedores	23	delete_proveedores
80	Can view proveedores	23	view_proveedores
81	Can add transaccion ajuste	24	add_transaccionajuste
82	Can change transaccion ajuste	24	change_transaccionajuste
83	Can delete transaccion ajuste	24	delete_transaccionajuste
84	Can view transaccion ajuste	24	view_transaccionajuste
85	Can add transaccion averias	25	add_transaccionaverias
86	Can change transaccion averias	25	change_transaccionaverias
87	Can delete transaccion averias	25	delete_transaccionaverias
88	Can view transaccion averias	25	view_transaccionaverias
89	Can add compras	26	add_compras
90	Can change compras	26	change_compras
91	Can delete compras	26	delete_compras
92	Can view compras	26	view_compras
93	Can add inventario	27	add_inventario
94	Can change inventario	27	change_inventario
95	Can delete inventario	27	delete_inventario
96	Can view inventario	27	view_inventario
97	Can add proveedores	28	add_proveedores
98	Can change proveedores	28	change_proveedores
99	Can delete proveedores	28	delete_proveedores
100	Can view proveedores	28	view_proveedores
101	Can add trans mp	29	add_transmp
102	Can change trans mp	29	change_transmp
103	Can delete trans mp	29	delete_transmp
104	Can view trans mp	29	view_transmp
105	Can add compras	30	add_compras
106	Can change compras	30	change_compras
107	Can delete compras	30	delete_compras
108	Can view compras	30	view_compras
109	Can add inventario	31	add_inventario
110	Can change inventario	31	change_inventario
111	Can delete inventario	31	delete_inventario
112	Can view inventario	31	view_inventario
113	Can add proveedores	32	add_proveedores
114	Can change proveedores	32	change_proveedores
115	Can delete proveedores	32	delete_proveedores
116	Can view proveedores	32	view_proveedores
117	Can add transformulas	33	add_transformulas
118	Can change transformulas	33	change_transformulas
119	Can delete transformulas	33	delete_transformulas
120	Can view transformulas	33	view_transformulas
121	Can add trans mp	34	add_transmp
122	Can change trans mp	34	change_transmp
123	Can delete trans mp	34	delete_transmp
124	Can view trans mp	34	view_transmp
125	Can add compras	35	add_compras
126	Can change compras	35	change_compras
127	Can delete compras	35	delete_compras
128	Can view compras	35	view_compras
129	Can add inventario	36	add_inventario
130	Can change inventario	36	change_inventario
131	Can delete inventario	36	delete_inventario
132	Can view inventario	36	view_inventario
133	Can add proveedores	37	add_proveedores
134	Can change proveedores	37	change_proveedores
135	Can delete proveedores	37	delete_proveedores
136	Can view proveedores	37	view_proveedores
137	Can add trans mp	38	add_transmp
138	Can change trans mp	38	change_transmp
139	Can delete trans mp	38	delete_transmp
140	Can view trans mp	38	view_transmp
141	Can add clientes	39	add_clientes
142	Can change clientes	39	change_clientes
143	Can delete clientes	39	delete_clientes
144	Can view clientes	39	view_clientes
145	Can add inventario	40	add_inventario
146	Can change inventario	40	change_inventario
147	Can delete inventario	40	delete_inventario
148	Can view inventario	40	view_inventario
149	Can add orden produccion	41	add_ordenproduccion
150	Can change orden produccion	41	change_ordenproduccion
151	Can delete orden produccion	41	delete_ordenproduccion
152	Can view orden produccion	41	view_ordenproduccion
153	Can add proveedores	42	add_proveedores
154	Can change proveedores	42	change_proveedores
155	Can delete proveedores	42	delete_proveedores
156	Can view proveedores	42	view_proveedores
157	Can add transformulas	43	add_transformulas
158	Can change transformulas	43	change_transformulas
159	Can delete transformulas	43	delete_transformulas
160	Can view transformulas	43	view_transformulas
161	Can add transaccion orden	44	add_transaccionorden
162	Can change transaccion orden	44	change_transaccionorden
163	Can delete transaccion orden	44	delete_transaccionorden
164	Can view transaccion orden	44	view_transaccionorden
165	Can add salidas mp orden	45	add_salidasmporden
166	Can change salidas mp orden	45	change_salidasmporden
167	Can delete salidas mp orden	45	delete_salidasmporden
168	Can view salidas mp orden	45	view_salidasmporden
169	Can add clientes	46	add_clientes
170	Can change clientes	46	change_clientes
171	Can delete clientes	46	delete_clientes
172	Can view clientes	46	view_clientes
173	Can add facturas	47	add_facturas
174	Can change facturas	47	change_facturas
175	Can delete facturas	47	delete_facturas
176	Can view facturas	47	view_facturas
177	Can add orden produccion	48	add_ordenproduccion
178	Can change orden produccion	48	change_ordenproduccion
179	Can delete orden produccion	48	delete_ordenproduccion
180	Can view orden produccion	48	view_ordenproduccion
181	Can add remisiones	49	add_remisiones
182	Can change remisiones	49	change_remisiones
183	Can delete remisiones	49	delete_remisiones
184	Can view remisiones	49	view_remisiones
185	Can add transaccion factura	50	add_transaccionfactura
186	Can change transaccion factura	50	change_transaccionfactura
187	Can delete transaccion factura	50	delete_transaccionfactura
188	Can view transaccion factura	50	view_transaccionfactura
189	Can add transaccion remision	51	add_transaccionremision
190	Can change transaccion remision	51	change_transaccionremision
191	Can delete transaccion remision	51	delete_transaccionremision
192	Can view transaccion remision	51	view_transaccionremision
193	Can add ajustes	52	add_ajustes
194	Can change ajustes	52	change_ajustes
195	Can delete ajustes	52	delete_ajustes
196	Can view ajustes	52	view_ajustes
197	Can add auth group	53	add_authgroup
198	Can change auth group	53	change_authgroup
199	Can delete auth group	53	delete_authgroup
200	Can view auth group	53	view_authgroup
201	Can add auth group permissions	54	add_authgrouppermissions
202	Can change auth group permissions	54	change_authgrouppermissions
203	Can delete auth group permissions	54	delete_authgrouppermissions
204	Can view auth group permissions	54	view_authgrouppermissions
205	Can add auth permission	55	add_authpermission
206	Can change auth permission	55	change_authpermission
207	Can delete auth permission	55	delete_authpermission
208	Can view auth permission	55	view_authpermission
209	Can add auth user	56	add_authuser
210	Can change auth user	56	change_authuser
211	Can delete auth user	56	delete_authuser
212	Can view auth user	56	view_authuser
213	Can add auth user groups	57	add_authusergroups
214	Can change auth user groups	57	change_authusergroups
215	Can delete auth user groups	57	delete_authusergroups
216	Can view auth user groups	57	view_authusergroups
217	Can add auth user user permissions	58	add_authuseruserpermissions
218	Can change auth user user permissions	58	change_authuseruserpermissions
219	Can delete auth user user permissions	58	delete_authuseruserpermissions
220	Can view auth user user permissions	58	view_authuseruserpermissions
221	Can add averias	59	add_averias
222	Can change averias	59	change_averias
223	Can delete averias	59	delete_averias
224	Can view averias	59	view_averias
225	Can add compras	60	add_compras
226	Can change compras	60	change_compras
227	Can delete compras	60	delete_compras
228	Can view compras	60	view_compras
229	Can add django admin log	61	add_djangoadminlog
230	Can change django admin log	61	change_djangoadminlog
231	Can delete django admin log	61	delete_djangoadminlog
232	Can view django admin log	61	view_djangoadminlog
233	Can add django content type	62	add_djangocontenttype
234	Can change django content type	62	change_djangocontenttype
235	Can delete django content type	62	delete_djangocontenttype
236	Can view django content type	62	view_djangocontenttype
237	Can add django migrations	63	add_djangomigrations
238	Can change django migrations	63	change_djangomigrations
239	Can delete django migrations	63	delete_djangomigrations
240	Can view django migrations	63	view_djangomigrations
241	Can add django session	64	add_djangosession
242	Can change django session	64	change_djangosession
243	Can delete django session	64	delete_djangosession
244	Can view django session	64	view_djangosession
245	Can add inventario	65	add_inventario
246	Can change inventario	65	change_inventario
247	Can delete inventario	65	delete_inventario
248	Can view inventario	65	view_inventario
249	Can add produccion salidasmporden	66	add_produccionsalidasmporden
250	Can change produccion salidasmporden	66	change_produccionsalidasmporden
251	Can delete produccion salidasmporden	66	delete_produccionsalidasmporden
252	Can view produccion salidasmporden	66	view_produccionsalidasmporden
253	Can add proveedores	67	add_proveedores
254	Can change proveedores	67	change_proveedores
255	Can delete proveedores	67	delete_proveedores
256	Can view proveedores	67	view_proveedores
257	Can add salidas mp orden	68	add_salidasmporden
258	Can change salidas mp orden	68	change_salidasmporden
259	Can delete salidas mp orden	68	delete_salidasmporden
260	Can view salidas mp orden	68	view_salidasmporden
261	Can add transaccion ajuste	69	add_transaccionajuste
262	Can change transaccion ajuste	69	change_transaccionajuste
263	Can delete transaccion ajuste	69	delete_transaccionajuste
264	Can view transaccion ajuste	69	view_transaccionajuste
265	Can add transaccion averias	70	add_transaccionaverias
266	Can change transaccion averias	70	change_transaccionaverias
267	Can delete transaccion averias	70	delete_transaccionaverias
268	Can view transaccion averias	70	view_transaccionaverias
269	Can add transaccion orden	71	add_transaccionorden
270	Can change transaccion orden	71	change_transaccionorden
271	Can delete transaccion orden	71	delete_transaccionorden
272	Can view transaccion orden	71	view_transaccionorden
273	Can add transformulas	72	add_transformulas
274	Can change transformulas	72	change_transformulas
275	Can delete transformulas	72	delete_transformulas
276	Can view transformulas	72	view_transformulas
277	Can add trans mp	73	add_transmp
278	Can change trans mp	73	change_transmp
279	Can delete trans mp	73	delete_transmp
280	Can view trans mp	73	view_transmp
281	Can add ventas	74	add_ventas
282	Can change ventas	74	change_ventas
283	Can delete ventas	74	delete_ventas
284	Can view ventas	74	view_ventas
\.


--
-- TOC entry 5088 (class 0 OID 33571)
-- Dependencies: 229
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$720000$8kIeGlsBHgmXDS62olcfQD$vHd8gmZ2/u/icAEKMhnHpx1RHFwlCbcpJpL6+psgj6M=	2024-06-28 10:13:50.280003-05	f	KeydenSaid	Keyden	peña	keyden@correo.com	f	t	2024-06-13 08:37:42-05
1	pbkdf2_sha256$720000$Qw2BeVMLKfqhs8EL7s2W8m$uKNnqhQCjXMoF9IN1hZghdkuwYT+NiRR+YL1e9emEK4=	2024-07-11 15:51:53.663009-05	t	kevin			kevin.alfred.sanchez@gmail.com	t	t	2024-04-26 09:33:02.388364-05
3	pbkdf2_sha256$720000$LK1UbhIgcD1ggB3fgpWGjD$aeZ2lIOSmNFKhdXIQWhzo6zr3bWiZzcLAm/cWQsx4Pw=	2024-06-17 18:16:11-05	f	lorena	lorena	lugrascol	lorenalugrascol@gmail.com	t	t	2024-06-17 18:10:32-05
\.


--
-- TOC entry 5090 (class 0 OID 33579)
-- Dependencies: 231
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- TOC entry 5092 (class 0 OID 33585)
-- Dependencies: 233
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
4	3	13
5	3	14
6	3	16
\.


--
-- TOC entry 5076 (class 0 OID 33469)
-- Dependencies: 217
-- Data for Name: compras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compras (id_compra, total_factura, estado) FROM stdin;
1234589	100000	t
748974	84800	f
369654	43558855	t
7895412	959900	t
498461	504210	t
\.


--
-- TOC entry 5094 (class 0 OID 33643)
-- Dependencies: 235
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2024-06-13 08:37:44.385958-05	2	KeydenSaid	1	[{"added": {}}]	4	1
2	2024-06-13 08:39:34.459857-05	2	KeydenSaid	2	[{"changed": {"fields": ["First name", "Last name", "Email address"]}}]	4	1
3	2024-06-13 08:39:39.420439-05	2	KeydenSaid	2	[]	4	1
4	2024-06-17 18:10:33.019473-05	3	lorena	1	[{"added": {}}]	4	1
5	2024-06-17 18:11:37.928621-05	3	lorena	2	[{"changed": {"fields": ["First name", "Last name", "Email address", "Staff status"]}}]	4	1
6	2024-06-17 18:15:54.731263-05	3	lorena	2	[{"changed": {"fields": ["User permissions"]}}]	4	1
7	2024-06-17 18:17:38.613803-05	3	lorena	2	[{"changed": {"fields": ["User permissions"]}}]	4	3
\.


--
-- TOC entry 5080 (class 0 OID 33543)
-- Dependencies: 221
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	dashboard	ajustes
8	dashboard	proveedores
9	dashboard	transaccionaverias
10	dashboard	authgroup
11	dashboard	authgrouppermissions
12	dashboard	authpermission
13	dashboard	authuser
14	dashboard	authusergroups
15	dashboard	authuseruserpermissions
16	dashboard	djangoadminlog
17	dashboard	djangocontenttype
18	dashboard	djangomigrations
19	dashboard	djangosession
20	inventario	ajustes
21	inventario	averias
22	inventario	inventario
23	inventario	proveedores
24	inventario	transaccionajuste
25	inventario	transaccionaverias
26	orden_compra	compras
27	orden_compra	inventario
28	orden_compra	proveedores
29	orden_compra	transmp
30	formulas	compras
31	formulas	inventario
32	formulas	proveedores
33	formulas	transformulas
34	formulas	transmp
35	proveedores	compras
36	proveedores	inventario
37	proveedores	proveedores
38	proveedores	transmp
39	produccion	clientes
40	produccion	inventario
41	produccion	ordenproduccion
42	produccion	proveedores
43	produccion	transformulas
44	produccion	transaccionorden
45	produccion	salidasmporden
46	facturacion	clientes
47	facturacion	facturas
48	facturacion	ordenproduccion
49	facturacion	remisiones
50	facturacion	transaccionfactura
51	facturacion	transaccionremision
52	facturacion	ajustes
53	facturacion	authgroup
54	facturacion	authgrouppermissions
55	facturacion	authpermission
56	facturacion	authuser
57	facturacion	authusergroups
58	facturacion	authuseruserpermissions
59	facturacion	averias
60	facturacion	compras
61	facturacion	djangoadminlog
62	facturacion	djangocontenttype
63	facturacion	djangomigrations
64	facturacion	djangosession
65	facturacion	inventario
66	facturacion	produccionsalidasmporden
67	facturacion	proveedores
68	facturacion	salidasmporden
69	facturacion	transaccionajuste
70	facturacion	transaccionaverias
71	facturacion	transaccionorden
72	facturacion	transformulas
73	facturacion	transmp
74	facturacion	ventas
\.


--
-- TOC entry 5078 (class 0 OID 33535)
-- Dependencies: 219
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2024-04-26 08:40:04.776454-05
2	auth	0001_initial	2024-04-26 08:40:04.918046-05
3	admin	0001_initial	2024-04-26 08:40:04.953871-05
4	admin	0002_logentry_remove_auto_add	2024-04-26 08:40:04.958687-05
5	admin	0003_logentry_add_action_flag_choices	2024-04-26 08:40:04.958687-05
6	contenttypes	0002_remove_content_type_name	2024-04-26 08:40:04.994964-05
7	auth	0002_alter_permission_name_max_length	2024-04-26 08:40:05.005021-05
8	auth	0003_alter_user_email_max_length	2024-04-26 08:40:05.005021-05
9	auth	0004_alter_user_username_opts	2024-04-26 08:40:05.017062-05
10	auth	0005_alter_user_last_login_null	2024-04-26 08:40:05.024587-05
11	auth	0006_require_contenttypes_0002	2024-04-26 08:40:05.024587-05
12	auth	0007_alter_validators_add_error_messages	2024-04-26 08:40:05.024587-05
13	auth	0008_alter_user_username_max_length	2024-04-26 08:40:05.041805-05
14	auth	0009_alter_user_last_name_max_length	2024-04-26 08:40:05.053547-05
15	auth	0010_alter_group_name_max_length	2024-04-26 08:40:05.053547-05
16	auth	0011_update_proxy_permissions	2024-04-26 08:40:05.069534-05
17	auth	0012_alter_user_first_name_max_length	2024-04-26 08:40:05.073001-05
18	sessions	0001_initial	2024-04-26 08:40:05.095185-05
19	dashboard	0001_initial	2024-06-07 10:07:24.382273-05
20	formulas	0001_initial	2024-06-07 10:07:24.399527-05
21	inventario	0001_initial	2024-06-07 10:07:24.405531-05
22	orden_compra	0001_initial	2024-06-07 10:07:24.411526-05
23	produccion	0001_initial	2024-06-07 10:07:24.420809-05
24	proveedores	0001_initial	2024-06-07 10:07:24.425802-05
25	dashboard	0002_delete_authgroup_delete_authgrouppermissions_and_more	2024-06-20 17:58:47.200697-05
26	produccion	0002_transaccionorden	2024-06-20 17:58:47.206428-05
27	produccion	0003_salidasmporden	2024-06-28 18:05:43.177052-05
28	produccion	0004_alter_salidasmporden_options	2024-07-02 13:13:21.797688-05
29	produccion	0005_alter_salidasmporden_table	2024-07-03 12:50:53.824996-05
30	facturacion	0001_initial	2024-07-04 16:31:08.993344-05
31	facturacion	0002_facturas_ordenproduccion_remisiones_and_more	2024-07-08 12:56:14.059745-05
32	facturacion	0003_ajustes_authgroup_authgrouppermissions_and_more	2024-07-08 17:38:06.071708-05
\.


--
-- TOC entry 5095 (class 0 OID 33671)
-- Dependencies: 236
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
efpdoq1dr4m2cpe5o1kbgrfc807ojgtm	.eJxVjDsOwjAQBe_iGlm7BH-gpM8ZLHt3jQPIluKkQtwdIqWAdmbee6kQ16WEtcscJlYXherwy1Kkh9RN8D3WW9PU6jJPSW-J3m3XY2N5Xvf276DEXr5rFw1aBkIPliVLYosZRZzPLhOdfAI3bGQAA2QT-HMGOHqDbD2LqPcH9bY4MA:1sLmeT:Hd_xc8uoLuhgEsyqnubbf5BIwRglivbNQ_vHFBcD3gE	2024-07-08 11:34:45.551124-05
qllmulnldhe01e4deis1pzgxkvgrykb6	.eJxVjMEOwiAQRP-FsyEI3aX16N1vILuwSNXQpLQn47_bJj3oaZJ5b-atAq1LCWuTOYxJXZRVp9-OKT6l7iA9qN4nHae6zCPrXdEHbfo2JXldD_fvoFAr27pHNkYcimB2KXuMEn2HYM4glME5MM6A3QI8kM89WuzYsuc4AMRBfb7SqTcb:1sNDIM:pjOG0STVhqri7Kyb9WADu17vf7U6DvBVKMtt1faM0iA	2024-07-12 10:13:50.280003-05
84pjs4vxc2yrl1rbpq7spw26t4im22l9	.eJxVjDsOwjAQBe_iGlm7BH-gpM8ZLHt3jQPIluKkQtwdIqWAdmbee6kQ16WEtcscJlYXherwy1Kkh9RN8D3WW9PU6jJPSW-J3m3XY2N5Xvf276DEXr5rFw1aBkIPliVLYosZRZzPLhOdfAI3bGQAA2QT-HMGOHqDbD2LqPcH9bY4MA:1sS0iP:7YoTXRzZQk6Hvw-S-AyyAOYwF7rUo7JOfPRb-yavIN0	2024-07-25 15:48:33.941903-05
zc121han5x4m4rjsgpt9yo6apms77rzr	.eJxVjDsOwjAQBe_iGlm7BH-gpM8ZLHt3jQPIluKkQtwdIqWAdmbee6kQ16WEtcscJlYXherwy1Kkh9RN8D3WW9PU6jJPSW-J3m3XY2N5Xvf276DEXr5rFw1aBkIPliVLYosZRZzPLhOdfAI3bGQAA2QT-HMGOHqDbD2LqPcH9bY4MA:1sS0ld:uRh0Ij8TG1JOV6B3g3fRaDSP6ux-fuAY1VbqzI0lm-s	2024-07-25 15:51:53.664091-05
xlfeigus5wnf5gxwyrkaamm3eui0og3e	.eJxVjDsOwjAQBe_iGlm7BH-gpM8ZLHt3jQPIluKkQtwdIqWAdmbee6kQ16WEtcscJlYXherwy1Kkh9RN8D3WW9PU6jJPSW-J3m3XY2N5Xvf276DEXr5rFw1aBkIPliVLYosZRZzPLhOdfAI3bGQAA2QT-HMGOHqDbD2LqPcH9bY4MA:1sAFsw:tyjjUB_WIc3Y_UK0y1AQbjfo2hZVFboHeE-lbo5-5qY	2024-06-06 16:22:02.267608-05
7viuurdmml4p4exe0xmdgs7tptv45fno	.eJxVjDsOwjAQBe_iGlm7BH-gpM8ZLHt3jQPIluKkQtwdIqWAdmbee6kQ16WEtcscJlYXherwy1Kkh9RN8D3WW9PU6jJPSW-J3m3XY2N5Xvf276DEXr5rFw1aBkIPliVLYosZRZzPLhOdfAI3bGQAA2QT-HMGOHqDbD2LqPcH9bY4MA:1sFLga:CY5Ae1OOo6BWLWNIN2qGHYzcjhF7xV0LUaE9hRP9QcI	2024-06-20 17:34:20.327879-05
zujc0e1mlsrgl6vgz11u3q7ezmogz019	.eJxVjMEOwiAQRP-FsyEI3aX16N1vILuwSNXQpLQn47_bJj3oaZJ5b-atAq1LCWuTOYxJXZRVp9-OKT6l7iA9qN4nHae6zCPrXdEHbfo2JXldD_fvoFAr27pHNkYcimB2KXuMEn2HYM4glME5MM6A3QI8kM89WuzYsuc4AMRBfb7SqTcb:1sHl90:fW8DNHyeSujzrS4BOTEpR_P2tTClg5PTG135tCz_rSk	2024-06-27 09:09:38.949262-05
xxvqwxdrejiim4r74v3gj6udqcgp326v	.eJxVjDsOwjAQBe_iGlm7BH-gpM8ZLHt3jQPIluKkQtwdIqWAdmbee6kQ16WEtcscJlYXherwy1Kkh9RN8D3WW9PU6jJPSW-J3m3XY2N5Xvf276DEXr5rFw1aBkIPliVLYosZRZzPLhOdfAI3bGQAA2QT-HMGOHqDbD2LqPcH9bY4MA:1sIESy:yO3b-U46RaYhIrwVONDI3ZONHq66Je-cQtuQ7rOkozI	2024-06-28 16:28:12.002357-05
sv7tkoa9ks4q9snmzoj7x03faxi224uf	.eJxVjDsOwjAQBe_iGlm7BH-gpM8ZLHt3jQPIluKkQtwdIqWAdmbee6kQ16WEtcscJlYXherwy1Kkh9RN8D3WW9PU6jJPSW-J3m3XY2N5Xvf276DEXr5rFw1aBkIPliVLYosZRZzPLhOdfAI3bGQAA2QT-HMGOHqDbD2LqPcH9bY4MA:1sJLcN:zkm-yMKrO56d_LI6JQyvMC4xecbFz9fIZnWINjS_Ig0	2024-07-01 18:18:31.624466-05
upjtfoajpeaq0vveko8xp1c8v36l8ipz	.eJxVjDsOwjAQBe_iGlm7BH-gpM8ZLHt3jQPIluKkQtwdIqWAdmbee6kQ16WEtcscJlYXherwy1Kkh9RN8D3WW9PU6jJPSW-J3m3XY2N5Xvf276DEXr5rFw1aBkIPliVLYosZRZzPLhOdfAI3bGQAA2QT-HMGOHqDbD2LqPcH9bY4MA:1sK1i9:QPOMfTne-9nGC5Q3H5FpsloQXmJ2gljT3ZfE3kCX70M	2024-07-03 15:15:17.659227-05
4qp3j2483upfi62w4wfhn43ktletkijw	.eJxVjDsOwjAQBe_iGlm7BH-gpM8ZLHt3jQPIluKkQtwdIqWAdmbee6kQ16WEtcscJlYXherwy1Kkh9RN8D3WW9PU6jJPSW-J3m3XY2N5Xvf276DEXr5rFw1aBkIPliVLYosZRZzPLhOdfAI3bGQAA2QT-HMGOHqDbD2LqPcH9bY4MA:1sKJoC:_gvQ4ByB1RWH199Io-hZ9u9qL-suYLynXBScW3SiJho	2024-07-04 10:34:44.97745-05
\.


--
-- TOC entry 5098 (class 0 OID 40999)
-- Dependencies: 239
-- Data for Name: inventario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventario (cod_inventario, nombre, cantidad, id_proveedor, tipo) FROM stdin;
800071	 prueba select2	0	1019161271	pt
500006	TAPA DE TAMBORES	-84	123456	m
500029	ENVASE PIMPINA NEGRA X 5	85	123456	m
500051	ENVASE  TAMBORES X 55 PARA PINTAR	-79	123456	m
601262	ETIQUETA XIOLUBE MOTOR 50 GRANDE FRONTAL PIMPINA BALDE Y TAMBOR	-126	123456	m
900002	MATERIA PRIMA BASE HYGOLD P300	-2837	123456	m
900100	BOLSAS PARA PIMPINAS X KILOS	-14	123456	m
900102	PINTURA PARA PINTAR TAMBORES	-108	123456	m
100608	TAMBOR DE ACEITE 2T X 55 ECOLÓGICO	31	1019161271	pt
100606	ACEITE 2T  X 5 ECOLÓGICO BALDE	9	1019161271	pt
800001	COLOR AMARILLO EN POLVO X LIBRA	0	123456	m
\.


--
-- TOC entry 5112 (class 0 OID 41166)
-- Dependencies: 253
-- Data for Name: produccion_salidasmporden; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produccion_salidasmporden (id, cantidad, fecha_salida, cod_inventario) FROM stdin;
\.


--
-- TOC entry 5075 (class 0 OID 33462)
-- Dependencies: 216
-- Data for Name: proveedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proveedores (id_proveedor, nombre_proveedor, direccion, telefono) FROM stdin;
123456	etiquetas de colombia	giron santander	3232510605
1019161271	Lugrascol SAS	Giron Santander 	3224799858
\.


--
-- TOC entry 5097 (class 0 OID 40982)
-- Dependencies: 238
-- Data for Name: trans_mp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trans_mp (id, nombre_mp, cant_mp, costo_unitario, total_linea, fecha_ingreso, unidad_medida, id_compra, id_proveedor, cod_inventario, tipo) FROM stdin;
41	ETIQUETA XIOLUBE MOTOR 50 GRANDE FRONTAL PIMPINA BALDE Y TAMBOR	10	600	6000	2024-06-06	Unidad	369654	123456	601262	m
42	MATERIA PRIMA BASE HYGOLD P300	2500	17300	43250000	2024-06-06	Galon	369654	123456	900002	m
43	TAPA DE TAMBORES	10	3000	30000	2024-06-06	Unidad	369654	123456	500006	m
44	PINTURA PARA PINTAR TAMBORES	10	2075	20750	2024-06-06	Unidad	369654	123456	900102	m
45	ENVASE  TAMBORES X 55 PARA PINTAR	5	50421	252105	2024-06-06	Unidad	369654	123456	500051	m
46	BOLSAS PARA PIMPINAS X KILOS	10	600	6000	2024-06-06	Unidad	7895412	123456	900100	m
47	ENVASE PIMPINA NEGRA X 5	100	9539	953900	2024-06-06	Unidad	7895412	123456	500029	m
48	ENVASE TAMBORES X 55 PARA PINTAR	10	50421	504210	2024-06-17	Unidad	498461	123456	500051	m
49	MATERIA PRIMA BASE HYGOLD P300	55	17500	962500	2024-06-17	Galon	369654	123456	900002	m
\.


--
-- TOC entry 5100 (class 0 OID 41020)
-- Dependencies: 241
-- Data for Name: transformulas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transformulas (id, nombre, materia1, cant_materia1, materia2, cant_materia2, materia3, cant_materia3, materia4, cant_materia4, materia5, cant_materia5, materia6, cant_materia6, materia7, cant_materia7, materia8, cant_materia8, cod_inventario, porcentajeiva, pocentajeutilidad, costosindirectos) FROM stdin;
31	TAMBOR DE ACEITE 2T X 55 ECOLÓGICO	900002	55	601262	1	900102	1	500051	1	500006	1	\N	\N	\N	\N	\N	\N	100608	19	20	33000
32	ACEITE 2T  X 5 ECOLÓGICO BALDE	900100	1	900102	1	601262	1	900002	5	\N	\N	\N	\N	\N	\N	\N	\N	100606	19	18	3000
33	 prueba select2	500029	5	900002	9	601262	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	800071	19	20	3300
\.


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 254
-- Name: Salidas_Mp_Orden_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Salidas_Mp_Orden_id_seq"', 88, true);


--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 256
-- Name: Transaccion_Factura_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transaccion_Factura_id_seq"', 9, true);


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 258
-- Name: Transaccion_Remision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transaccion_Remision_id_seq"', 18, true);


--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 243
-- Name: Transaccion_ajuste_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transaccion_ajuste_id_seq"', 32, true);


--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 246
-- Name: Transaccion_averias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transaccion_averias_id_seq"', 61, true);


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 249
-- Name: Transaccion_orden_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Transaccion_orden_id_seq"', 51, true);


--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 224
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 226
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 222
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 284, true);


--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 230
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 228
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 3, true);


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 232
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 6, true);


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 234
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 7, true);


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 220
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 74, true);


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 218
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 32, true);


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 252
-- Name: produccion_salidasmporden_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produccion_salidasmporden_id_seq', 1, false);


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 237
-- Name: trans_mp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trans_mp_id_seq', 49, true);


--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 240
-- Name: transformulas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transformulas_id_seq', 33, true);


--
-- TOC entry 4884 (class 2606 OID 41087)
-- Name: Averias Averias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Averias"
    ADD CONSTRAINT "Averias_pkey" PRIMARY KEY (id_averia);


--
-- TOC entry 4892 (class 2606 OID 41143)
-- Name: Clientes Clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Clientes"
    ADD CONSTRAINT "Clientes_pkey" PRIMARY KEY ("Nit");


--
-- TOC entry 4903 (class 2606 OID 41209)
-- Name: Facturas  Facturas _pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Facturas "
    ADD CONSTRAINT "Facturas _pkey" PRIMARY KEY ("Nfactura");


--
-- TOC entry 4888 (class 2606 OID 41118)
-- Name: Orden_produccion Orden_produccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orden_produccion"
    ADD CONSTRAINT "Orden_produccion_pkey" PRIMARY KEY (id_orden);


--
-- TOC entry 4905 (class 2606 OID 41224)
-- Name: Remisiones Remisiones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Remisiones"
    ADD CONSTRAINT "Remisiones_pkey" PRIMARY KEY ("Nremision");


--
-- TOC entry 4897 (class 2606 OID 41182)
-- Name: Salidas_Mp_Orden Salidas_Mp_Orden_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Salidas_Mp_Orden"
    ADD CONSTRAINT "Salidas_Mp_Orden_pkey" PRIMARY KEY (id);


--
-- TOC entry 4899 (class 2606 OID 41198)
-- Name: Transaccion_Factura Transaccion_Factura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaccion_Factura"
    ADD CONSTRAINT "Transaccion_Factura_pkey" PRIMARY KEY (id);


--
-- TOC entry 4901 (class 2606 OID 41204)
-- Name: Transaccion_Remision Transaccion_Remision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaccion_Remision"
    ADD CONSTRAINT "Transaccion_Remision_pkey" PRIMARY KEY (id);


--
-- TOC entry 4882 (class 2606 OID 41072)
-- Name: Transaccion_ajuste Transaccion_ajuste_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaccion_ajuste"
    ADD CONSTRAINT "Transaccion_ajuste_pkey" PRIMARY KEY (id);


--
-- TOC entry 4886 (class 2606 OID 41095)
-- Name: Transaccion_averias Transaccion_averias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaccion_averias"
    ADD CONSTRAINT "Transaccion_averias_pkey" PRIMARY KEY (id);


--
-- TOC entry 4890 (class 2606 OID 41126)
-- Name: Transaccion_orden Transaccion_orden_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaccion_orden"
    ADD CONSTRAINT "Transaccion_orden_pkey" PRIMARY KEY (id);


--
-- TOC entry 4821 (class 2606 OID 33461)
-- Name: Ventas Ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ventas"
    ADD CONSTRAINT "Ventas_pkey" PRIMARY KEY (id_venta);


--
-- TOC entry 4880 (class 2606 OID 41046)
-- Name: ajustes ajustes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ajustes
    ADD CONSTRAINT ajustes_pkey PRIMARY KEY (id_ajuste);


--
-- TOC entry 4839 (class 2606 OID 33669)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 4844 (class 2606 OID 33600)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 4847 (class 2606 OID 33569)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4841 (class 2606 OID 33561)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 4834 (class 2606 OID 33591)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 4836 (class 2606 OID 33555)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 4855 (class 2606 OID 33583)
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 4858 (class 2606 OID 33615)
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 4849 (class 2606 OID 33575)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 4861 (class 2606 OID 33589)
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4864 (class 2606 OID 33629)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 4852 (class 2606 OID 33664)
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 4825 (class 2606 OID 33473)
-- Name: compras compras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_pkey PRIMARY KEY (id_compra);


--
-- TOC entry 4867 (class 2606 OID 33650)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4829 (class 2606 OID 33549)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 4831 (class 2606 OID 33547)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4827 (class 2606 OID 33541)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4871 (class 2606 OID 33677)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 4876 (class 2606 OID 41005)
-- Name: inventario inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (cod_inventario);


--
-- TOC entry 4895 (class 2606 OID 41170)
-- Name: produccion_salidasmporden produccion_salidasmporden_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produccion_salidasmporden
    ADD CONSTRAINT produccion_salidasmporden_pkey PRIMARY KEY (id);


--
-- TOC entry 4823 (class 2606 OID 33468)
-- Name: proveedores proveedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id_proveedor);


--
-- TOC entry 4874 (class 2606 OID 40988)
-- Name: trans_mp trans_mp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trans_mp
    ADD CONSTRAINT trans_mp_pkey PRIMARY KEY (id);


--
-- TOC entry 4878 (class 2606 OID 41026)
-- Name: transformulas transformulas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transformulas
    ADD CONSTRAINT transformulas_pkey PRIMARY KEY (id);


--
-- TOC entry 4837 (class 1259 OID 33670)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 4842 (class 1259 OID 33611)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 4845 (class 1259 OID 33612)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 4832 (class 1259 OID 33597)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 4853 (class 1259 OID 33627)
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- TOC entry 4856 (class 1259 OID 33626)
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- TOC entry 4859 (class 1259 OID 33641)
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 4862 (class 1259 OID 33640)
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 4850 (class 1259 OID 33665)
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 4865 (class 1259 OID 33661)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 4868 (class 1259 OID 33662)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 4869 (class 1259 OID 33679)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 4872 (class 1259 OID 33678)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 4893 (class 1259 OID 41176)
-- Name: produccion_salidasmporden_cod_inventario_0eb729d1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX produccion_salidasmporden_cod_inventario_0eb729d1 ON public.produccion_salidasmporden USING btree (cod_inventario);


--
-- TOC entry 4923 (class 2606 OID 41144)
-- Name: Orden_produccion Orden_produccion_Nit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orden_produccion"
    ADD CONSTRAINT "Orden_produccion_Nit_fkey" FOREIGN KEY ("Nit") REFERENCES public."Clientes"("Nit") NOT VALID;


--
-- TOC entry 4919 (class 2606 OID 41073)
-- Name: Transaccion_ajuste ajuste_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaccion_ajuste"
    ADD CONSTRAINT ajuste_fk FOREIGN KEY (id_ajuste) REFERENCES public.ajustes(id_ajuste);


--
-- TOC entry 4920 (class 2606 OID 41078)
-- Name: Transaccion_ajuste ajuste_inventario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaccion_ajuste"
    ADD CONSTRAINT ajuste_inventario_fk FOREIGN KEY (cod_inventario) REFERENCES public.inventario(cod_inventario);


--
-- TOC entry 4907 (class 2606 OID 33606)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4908 (class 2606 OID 33601)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4906 (class 2606 OID 33592)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4909 (class 2606 OID 33621)
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4910 (class 2606 OID 33616)
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4911 (class 2606 OID 33635)
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4912 (class 2606 OID 33630)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4921 (class 2606 OID 41096)
-- Name: Transaccion_averias averia_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaccion_averias"
    ADD CONSTRAINT averia_fk FOREIGN KEY (id_averia) REFERENCES public."Averias"(id_averia);


--
-- TOC entry 4915 (class 2606 OID 40989)
-- Name: trans_mp compra_trans_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trans_mp
    ADD CONSTRAINT compra_trans_fk FOREIGN KEY (id_compra) REFERENCES public.compras(id_compra) NOT VALID;


--
-- TOC entry 4913 (class 2606 OID 33651)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4914 (class 2606 OID 33656)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4929 (class 2606 OID 41210)
-- Name: Transaccion_Factura factura_transaccion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaccion_Factura"
    ADD CONSTRAINT factura_transaccion_fk FOREIGN KEY ("Nfactura") REFERENCES public."Facturas "("Nfactura") NOT VALID;


--
-- TOC entry 4922 (class 2606 OID 41101)
-- Name: Transaccion_averias inventario_averia_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaccion_averias"
    ADD CONSTRAINT inventario_averia_fk FOREIGN KEY (cod_inventario) REFERENCES public.inventario(cod_inventario);


--
-- TOC entry 4924 (class 2606 OID 41127)
-- Name: Transaccion_orden inventario_orden_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaccion_orden"
    ADD CONSTRAINT inventario_orden_fk FOREIGN KEY (cod_inventario) REFERENCES public.inventario(cod_inventario);


--
-- TOC entry 4927 (class 2606 OID 41183)
-- Name: Salidas_Mp_Orden inventario_orden_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Salidas_Mp_Orden"
    ADD CONSTRAINT inventario_orden_fk FOREIGN KEY (cod_inventario) REFERENCES public.inventario(cod_inventario);


--
-- TOC entry 4917 (class 2606 OID 41032)
-- Name: inventario inventario_proveedor_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_proveedor_fk FOREIGN KEY (id_proveedor) REFERENCES public.proveedores(id_proveedor) NOT VALID;


--
-- TOC entry 4916 (class 2606 OID 41006)
-- Name: trans_mp inventario_tans_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trans_mp
    ADD CONSTRAINT inventario_tans_fk FOREIGN KEY (cod_inventario) REFERENCES public.inventario(cod_inventario) NOT VALID;


--
-- TOC entry 4928 (class 2606 OID 41188)
-- Name: Salidas_Mp_Orden orden_salidas_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Salidas_Mp_Orden"
    ADD CONSTRAINT orden_salidas_fk FOREIGN KEY (id_orden) REFERENCES public."Orden_produccion"(id_orden);


--
-- TOC entry 4925 (class 2606 OID 41132)
-- Name: Transaccion_orden orden_transaccion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaccion_orden"
    ADD CONSTRAINT orden_transaccion_fk FOREIGN KEY (id_orden) REFERENCES public."Orden_produccion"(id_orden);


--
-- TOC entry 4926 (class 2606 OID 41171)
-- Name: produccion_salidasmporden produccion_salidasmp_cod_inventario_0eb729d1_fk_inventari; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produccion_salidasmporden
    ADD CONSTRAINT produccion_salidasmp_cod_inventario_0eb729d1_fk_inventari FOREIGN KEY (cod_inventario) REFERENCES public.inventario(cod_inventario) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4918 (class 2606 OID 41037)
-- Name: transformulas trans_formula_inventario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transformulas
    ADD CONSTRAINT trans_formula_inventario_fk FOREIGN KEY (cod_inventario) REFERENCES public.inventario(cod_inventario) NOT VALID;


--
-- TOC entry 4930 (class 2606 OID 41230)
-- Name: Transaccion_Remision transaccion_remision_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Transaccion_Remision"
    ADD CONSTRAINT transaccion_remision_fk FOREIGN KEY ("Nremision") REFERENCES public."Remisiones"("Nremision") NOT VALID;


-- Completed on 2024-07-11 18:20:12

--
-- PostgreSQL database dump complete
--

