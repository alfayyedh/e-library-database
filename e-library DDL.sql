CREATE TABLE libraries (
  library_id serial PRIMARY KEY,
  library_name varchar not null
);

DROP TABLE IF EXISTS libraries;

CREATE TABLE books (
  book_id serial PRIMARY KEY,
  library_id integer not null,
  title varchar not null,
  author varchar not null,
  category varchar not null,
  book_quantity integer not null check(book_quantity >= 0),
  CONSTRAINT fk_libraries
	FOREIGN KEY (library_id) REFERENCES libraries(library_id)
);

DROP TABLE IF EXISTS books;

CREATE TABLE users (
  user_id serial PRIMARY KEY,
  first_name varchar not null,
  last_name varchar not null,
  username varchar not null unique,
  email varchar not null unique,
  phone_number varchar not null
);

DROP TABLE IF EXISTS users;

CREATE TABLE loans (
  loan_id serial PRIMARY KEY,
  book_id integer not null,
  user_id integer not null,
  loan_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
  due_date timestamp not null GENERATED ALWAYS AS (loan_date + INTERVAL '14 days') STORED,
  return_date timestamp null,
  CONSTRAINT fk_book
	FOREIGN KEY (book_id) REFERENCES books(book_id),
  CONSTRAINT fk_user
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

DROP TABLE IF EXISTS loans;

CREATE TABLE holds (
  hold_id serial PRIMARY KEY,
  book_id integer not null,
  user_id integer not null,
  hold_date timestamp not null DEFAULT CURRENT_TIMESTAMP,
  end_hold_date timestamp not null,
  CONSTRAINT fk_book
	FOREIGN KEY (book_id) REFERENCES books(book_id),
  CONSTRAINT fk_user
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

DROP TABLE IF EXISTS holds;


