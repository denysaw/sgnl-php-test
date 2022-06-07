CREATE TYPE statuses AS ENUM (
    'active',
    'lost',
    'revoked'
    );

CREATE TABLE buildings (
                                  id integer NOT NULL,
                                  name character varying NOT NULL,
                                  country character varying,
                                  address character varying,
                                  zip character varying,
                                  created_at date DEFAULT now() NOT NULL,
                                  updated_at date
);

--
-- Name: buildings_id_seq; Type: SEQUENCE;
--

CREATE SEQUENCE buildings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: buildings_id_seq; Type: SEQUENCE OWNED BY;
--

ALTER SEQUENCE buildings_id_seq OWNED BY buildings.id;


--
-- Name: department_building; Type: TABLE;
--

CREATE TABLE department_building (
                                            department_id integer NOT NULL,
                                            building_id integer NOT NULL
);

--
-- Name: department_employee; Type: TABLE;
--

CREATE TABLE department_employee (
                                            department_id integer NOT NULL,
                                            employee_id integer NOT NULL
);

--
-- Name: departments; Type: TABLE;
--

CREATE TABLE departments (
                                    id integer NOT NULL,
                                    name character varying,
                                    created_at date DEFAULT now() NOT NULL,
                                    updated_at date
);


--
-- Name: departments_id_seq; Type: SEQUENCE;
--

CREATE SEQUENCE departments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY;
--

ALTER SEQUENCE departments_id_seq OWNED BY departments.id;


--
-- Name: employees; Type: TABLE;
--

CREATE TABLE employees (
                                  id integer NOT NULL,
                                  full_name character varying NOT NULL,
                                  email character varying,
                                  phone_number character varying,
                                  is_active boolean DEFAULT true,
                                  created_at date DEFAULT now() NOT NULL,
                                  updated_at date
);


--
-- Name: employees_id_seq; Type: SEQUENCE;
--

CREATE SEQUENCE employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY;
--

ALTER SEQUENCE employees_id_seq OWNED BY employees.id;


--
-- Name: rfid_cards; Type: TABLE;
--

CREATE TABLE rfid_cards (
                                   id integer NOT NULL,
                                   employee_id integer NOT NULL,
                                   card_number character varying NOT NULL,
                                   status statuses,
                                   created_at date DEFAULT now() NOT NULL,
                                   updated_at date
);

--
-- Name: rfid_cards_id_seq; Type: SEQUENCE;
--

CREATE SEQUENCE rfid_cards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: rfid_cards_id_seq; Type: SEQUENCE OWNED BY;
--

ALTER SEQUENCE rfid_cards_id_seq OWNED BY rfid_cards.id;


--
-- Name: buildings id; Type: DEFAULT;
--

ALTER TABLE ONLY buildings ALTER COLUMN id SET DEFAULT nextval('buildings_id_seq'::regclass);


--
-- Name: departments id; Type: DEFAULT;
--

ALTER TABLE ONLY departments ALTER COLUMN id SET DEFAULT nextval('departments_id_seq'::regclass);


--
-- Name: employees id; Type: DEFAULT;
--

ALTER TABLE ONLY employees ALTER COLUMN id SET DEFAULT nextval('employees_id_seq'::regclass);


--
-- Name: rfid_cards id; Type: DEFAULT;
--

ALTER TABLE ONLY rfid_cards ALTER COLUMN id SET DEFAULT nextval('rfid_cards_id_seq'::regclass);


--
-- Data for Name: buildings; Type: TABLE DATA;
--

INSERT INTO buildings VALUES (3, 'Charles Darwin', 'UK', 'York', '9000', '2022-06-07', NULL);
INSERT INTO buildings VALUES (4, 'Benjamin Franklin', 'US', 'New York', '12300', '2022-06-07', NULL);
INSERT INTO buildings VALUES (5, 'Luciano Pavarotti', 'Italy', 'Milan', '31412', '2022-06-07', NULL);
INSERT INTO buildings VALUES (1, 'Isaac Newton', 'UK', 'London', '10000', '2022-06-07', NULL);
INSERT INTO buildings VALUES (2, 'Oscar Wilde', 'UK', 'Edinburg', '11000', '2022-06-07', NULL);


--
-- Data for Name: department_building; Type: TABLE DATA;
--

INSERT INTO department_building VALUES (1, 1);
INSERT INTO department_building VALUES (2, 1);
INSERT INTO department_building VALUES (3, 2);
INSERT INTO department_building VALUES (4, 2);
INSERT INTO department_building VALUES (5, 3);
INSERT INTO department_building VALUES (1, 4);
INSERT INTO department_building VALUES (4, 4);
INSERT INTO department_building VALUES (1, 5);
INSERT INTO department_building VALUES (4, 5);


--
-- Data for Name: department_employee; Type: TABLE DATA;
--

INSERT INTO department_employee VALUES (1, 1);
INSERT INTO department_employee VALUES (6, 1);


--
-- Data for Name: departments; Type: TABLE DATA;
--

INSERT INTO departments VALUES (1, 'development', '2022-06-07', NULL);
INSERT INTO departments VALUES (6, 'director', '2022-06-07', NULL);
INSERT INTO departments VALUES (5, 'headquarters', '2022-06-07', NULL);
INSERT INTO departments VALUES (4, 'sales', '2022-06-07', NULL);
INSERT INTO departments VALUES (3, 'HR', '2022-06-07', NULL);
INSERT INTO departments VALUES (2, 'accounting', '2022-06-07', NULL);


--
-- Data for Name: employees; Type: TABLE DATA;
--

INSERT INTO employees VALUES (1, 'Julius Caesar', 'Julius.Caesar@sgnl.test', '+123', true, '2022-06-07', NULL);


--
-- Data for Name: rfid_cards; Type: TABLE DATA;
--

INSERT INTO rfid_cards VALUES (1, 1, '142594708f3a5a3ac2980914a0fc954f', 'active', '2022-06-07', NULL);


--
-- Name: buildings_id_seq; Type: SEQUENCE SET;
--

SELECT pg_catalog.setval('buildings_id_seq', 5, true);


--
-- Name: departments_id_seq; Type: SEQUENCE SET;
--

SELECT pg_catalog.setval('departments_id_seq', 6, true);


--
-- Name: employees_id_seq; Type: SEQUENCE SET;
--

SELECT pg_catalog.setval('employees_id_seq', 1, true);


--
-- Name: rfid_cards_id_seq; Type: SEQUENCE SET;
--

SELECT pg_catalog.setval('rfid_cards_id_seq', 1, true);


--
-- Name: buildings buildings_pk; Type: CONSTRAINT;
--

ALTER TABLE ONLY buildings
    ADD CONSTRAINT buildings_pk PRIMARY KEY (id);


--
-- Name: departments departments_pk; Type: CONSTRAINT;
--

ALTER TABLE ONLY departments
    ADD CONSTRAINT departments_pk PRIMARY KEY (id);


--
-- Name: employees employees_pk; Type: CONSTRAINT;
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT employees_pk PRIMARY KEY (id);


--
-- Name: rfid_cards rfid_cards_pk; Type: CONSTRAINT;
--

ALTER TABLE ONLY rfid_cards
    ADD CONSTRAINT rfid_cards_pk PRIMARY KEY (id);


--
-- Name: buildings_id_uindex; Type: INDEX;
--

CREATE UNIQUE INDEX buildings_id_uindex ON buildings USING btree (id);


--
-- Name: department_building_department_id_building_id_uindex; Type: INDEX;
--

CREATE UNIQUE INDEX department_building_department_id_building_id_uindex ON department_building USING btree (department_id, building_id);


--
-- Name: department_employee_department_id_employee_id_uindex; Type: INDEX;
--

CREATE UNIQUE INDEX department_employee_department_id_employee_id_uindex ON department_employee USING btree (department_id, employee_id);


--
-- Name: departments_id_uindex; Type: INDEX;
--

CREATE UNIQUE INDEX departments_id_uindex ON departments USING btree (id);


--
-- Name: employees_id_uindex; Type: INDEX;
--

CREATE UNIQUE INDEX employees_id_uindex ON employees USING btree (id);


--
-- Name: rfid_cards_card_number_uindex; Type: INDEX;
--

CREATE UNIQUE INDEX rfid_cards_card_number_uindex ON rfid_cards USING btree (card_number);


--
-- Name: rfid_cards_id_uindex; Type: INDEX;
--

CREATE UNIQUE INDEX rfid_cards_id_uindex ON rfid_cards USING btree (id);


--
-- Name: department_building department_building_buildings_id_fk; Type: FK CONSTRAINT;
--

ALTER TABLE ONLY department_building
    ADD CONSTRAINT department_building_buildings_id_fk FOREIGN KEY (building_id) REFERENCES buildings(id) ON DELETE CASCADE;


--
-- Name: department_building department_building_departments_id_fk; Type: FK CONSTRAINT;
--

ALTER TABLE ONLY department_building
    ADD CONSTRAINT department_building_departments_id_fk FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE;


--
-- Name: department_employee department_employee_departments_id_fk; Type: FK CONSTRAINT;
--

ALTER TABLE ONLY department_employee
    ADD CONSTRAINT department_employee_departments_id_fk FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE;


--
-- Name: department_employee department_employee_employees_id_fk; Type: FK CONSTRAINT;
--

ALTER TABLE ONLY department_employee
    ADD CONSTRAINT department_employee_employees_id_fk FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE;


--
-- Name: rfid_cards rfid_cards_employees_id_fk; Type: FK CONSTRAINT;
--

ALTER TABLE ONLY rfid_cards
    ADD CONSTRAINT rfid_cards_employees_id_fk FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

