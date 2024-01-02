-- Import csv to database --

COPY users
FROM 'D:\3. Pacmann\2. SQL\Exercise\Week 6\csv files V2\users.csv'
DELIMITER ','
CSV
HEADER;

COPY libraries
FROM 'D:\3. Pacmann\2. SQL\Exercise\Week 6\csv files V2\libraries.csv'
DELIMITER ','
CSV
HEADER;

COPY books
FROM 'D:\3. Pacmann\2. SQL\Exercise\Week 6\csv files V2\books.csv'
DELIMITER ','
CSV
HEADER;

COPY loans
FROM 'D:\3. Pacmann\2. SQL\Exercise\Week 6\csv files V2\loans.csv'
DELIMITER ','
CSV
HEADER;

COPY holds
FROM 'D:\3. Pacmann\2. SQL\Exercise\Week 6\csv files V2\holds.csv'
DELIMITER ','
CSV
HEADER;

-- Query check --

select * from holds;

select * from books;

select * from libraries;

select * from users;

select * from loans;


-- 5 Questions --

-- 1. Pada setiap tahun, pada bulan apa buku paling banyak dipinjam? 
	
WITH monthly_loan_count AS (
    SELECT
        EXTRACT(YEAR FROM loan_date) AS loan_year,
        EXTRACT(MONTH FROM loan_date) AS loan_month,
        COUNT(*) AS total_loans,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM loan_date) ORDER BY COUNT(*) DESC) AS month_rank
    FROM
        loans
    GROUP BY
        loan_year, loan_month
)

SELECT
    loan_year,
    loan_month,
    total_loans,
    month_rank
FROM
    monthly_loan_count
WHERE
    month_rank = 1;


-- 2. Berikan data top 10 buku yang paling sering dipinjam!

SELECT
	b.title,
	b.category,
	count(l.book_id) as total_loan
FROM loans l
JOIN books b
	ON l.book_id = b.book_id
GROUP BY 1,2
ORDER BY total_loan DESC, category ASC
LIMIT 10;

-- 3. Berikan data top 3 kategori yang paling banyak di booking!

SELECT
	b.category,
	count(h.book_id) as total_booking
FROM holds h
JOIN books b
	ON h.book_id = b.book_id
GROUP BY 1
ORDER BY total_booking DESC
LIMIT 3;

-- 4. Berapa lama peminjaman minimum, maximum, dan rata-rata untuk setiap kategori buku?

WITH loan_duration as (
	SELECT
		loan_id,
		(return_date - loan_date) as duration
	FROM
		loans
)
	
SELECT
	category,
	min(duration) as minimum_duration,
	max(duration) as maximum_duration,
	avg(duration) as average_duration
FROM
	loans
JOIN loan_duration using(loan_id)
JOIN books using(book_id)
GROUP BY 1
ORDER BY 1;

-- 5. Tampilkan data 10 user yang paling sering melakukan peminjaman!

SELECT
	CONCAT(u.first_name, ' ', u.last_name) as customer_name,
	u.email,
	u.phone_number,
	count(l.user_id) as loan_frequency
FROM loans l
JOIN users u
	ON l.user_id = u.user_id
GROUP BY 1,2,3
ORDER BY loan_frequency DESC, customer_name ASC
LIMIT 10;

-- Dataset Verification Query --
-- Cek apakah ada user yang meminjam lebih dari 2 buku pada saat bersamaan --
WITH lag_return as (
	SELECT
		user_id,
		loan_date,
		return_date,
		LAG(return_date) OVER (PARTITION BY user_id ORDER BY user_id,loan_date) AS prev_return_date
	FROM
		loans
)
SELECT
	user_id,
	count(user_id) as user_count
FROM
	lag_return
WHERE
	(return_date - prev_return_date) < '14 days'
GROUP BY 1
HAVING count(user_id) > 2
ORDER BY 1;


-- Cek apakah ada user yang booking lebih dari 2 buku pada saat bersamaan --
WITH lag_end_hold_date as (
	SELECT
		user_id,
		hold_date,
		end_hold_date,
		LAG(end_hold_date) OVER (PARTITION BY user_id ORDER BY user_id,hold_date) AS prev_end_hold_date
	FROM
		holds
)
SELECT
	user_id,
	count(user_id) as user_count
FROM
	lag_end_hold_date
WHERE
	(end_hold_date - prev_end_hold_date) < '14 days'
GROUP BY 1
HAVING count(user_id) > 2
ORDER BY 1;