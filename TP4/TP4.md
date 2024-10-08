# TP4

## Exercice 1:

- To view the schema of a table named `unicode`, enter:

  ``` bash
  unicode=> \d+ unicode
  ```

```bash
                                            Table "public.unicode"
    Column     |         Type         | Collation | Nullable | Default | Storage  | Stats target | Description
---------------+----------------------+-----------+----------+---------+----------+--------------+-------------
 codepoint     | character varying(6) |           | not null |         | extended |              |
 charname      | text                 |           | not null |         | extended |              |
 category      | character(2)         |           | not null |         | extended |              |
 combining     | integer              |           | not null |         | plain    |              |
 bidi          | character varying(3) |           | not null |         | extended |              |
 decomposition | text                 |           |          |         | extended |              |
 decimal       | integer              |           |          |         | plain    |              |
 digit         | integer              |           |          |         | plain    |              |
 numeric       | text                 |           |          |         | extended |              |
 mirrored      | character(1)         |           | not null |         | extended |              |
 oldname       | text                 |           |          |         | extended |              |
 comment       | text                 |           |          |         | extended |              |
 uppercase     | character varying(6) |           |          |         | extended |              |
 lowercase     | character varying(6) |           |          |         | extended |              |
 titlecase     | character varying(6) |           |          |         | extended |              |
Indexes:
    "unicode_pkey" PRIMARY KEY, btree (codepoint)
    "unicode_charname_idx" btree (charname)
    "unicode_numeric_idx" btree ("numeric")
Foreign-key constraints:
    "unicode_lowercase_fkey" FOREIGN KEY (lowercase) REFERENCES unicode(codepoint)
    "unicode_titlecase_fkey" FOREIGN KEY (titlecase) REFERENCES unicode(codepoint)
    "unicode_uppercase_fkey" FOREIGN KEY (uppercase) REFERENCES unicode(codepoint)
Referenced by:
    TABLE "unicode" CONSTRAINT "unicode_lowercase_fkey" FOREIGN KEY (lowercase) REFERENCES unicode(codepoint)
    TABLE "unicode" CONSTRAINT "unicode_titlecase_fkey" FOREIGN KEY (titlecase) REFERENCES unicode(codepoint)
    TABLE "unicode" CONSTRAINT "unicode_uppercase_fkey" FOREIGN KEY (uppercase) REFERENCES unicode(codepoint)
```

## Exercice 2

```bash
Indexes:
    "unicode_pkey" PRIMARY KEY, btree (codepoint)
    "unicode_charname_idx" btree (charname)
    "unicode_numeric_idx" btree ("numeric")
```

## Exercice 3

- SeqScan

    ```bash
    unicode=> EXPLAIN SELECT * FROM unicode;
                              QUERY PLAN
    ---------------------------------------------------------------
     Seq Scan on unicode  (cost=0.00..725.26 rows=34626 width=137)
    (1 row)
    ```

- Index Scan

    ```bash
    unicode=> EXPLAIN SELECT * FROM unicode WHERE codepoint = '0000';
                                      QUERY PLAN
    ------------------------------------------------------------------------------
     Index Scan using unicode_pkey on unicode  (cost=0.29..8.31 rows=1 width=137)
       Index Cond: ((codepoint)::text = '0000'::text)
    (2 rows)
    ```

- Index Only Scan

    ```bash
    unicode=> EXPLAIN SELECT codepoint FROM unicode WHERE codepoint = '0000';
                                       QUERY PLAN
    ---------------------------------------------------------------------------------
     Index Only Scan using unicode_pkey on unicode  (cost=0.29..8.31 rows=1 width=5)
       Index Cond: (codepoint = '0000'::text)
    (2 rows)
    ```

- BitmapOr (Bitmap Index Scan, Bitmap Heap Scan)

    ```bash
    unicode=> EXPLAIN SELECT * FROM unicode WHERE codepoint = '0000' OR codepoint = '0001';
                                             QUERY PLAN
    --------------------------------------------------------------------------------------------
     Bitmap Heap Scan on unicode  (cost=8.60..16.19 rows=2 width=137)
       Recheck Cond: (((codepoint)::text = '0000'::text) OR ((codepoint)::text = '0001'::text))
       ->  BitmapOr  (cost=8.60..8.60 rows=2 width=0)
             ->  Bitmap Index Scan on unicode_pkey  (cost=0.00..4.30 rows=1 width=0)
                   Index Cond: ((codepoint)::text = '0000'::text)
             ->  Bitmap Index Scan on unicode_pkey  (cost=0.00..4.30 rows=1 width=0)
                   Index Cond: ((codepoint)::text = '0001'::text)
    (7 rows)
    ```

- Filter

    ```bash
    unicode=> EXPLAIN SELECT * FROM unicode WHERE charname = 'S%' AND codepoint = '0000';
                                      QUERY PLAN
    ------------------------------------------------------------------------------
     Index Scan using unicode_pkey on unicode  (cost=0.29..8.31 rows=1 width=137)
       Index Cond: ((codepoint)::text = '0000'::text)
       Filter: (charname = 'S%'::text)
    (3 rows)
    ```

- Nested Loop

    ```bash
    unicode=> EXPLAIN SELECT * FROM unicode AS tA, unicode AS tB WHERE tA.codepoint != tB.codepoint;
                                   QUERY PLAN
    ------------------------------------------------------------------------
     Nested Loop  (cost=0.00..40100576.47 rows=1198925250 width=274)
       Join Filter: ((ta.codepoint)::text <> (tb.codepoint)::text)
       ->  Seq Scan on unicode ta  (cost=0.00..725.26 rows=34626 width=137)
       ->  Seq Scan on unicode tb  (cost=0.00..725.26 rows=34626 width=137)
    (4 rows)
    ```

- Hash Join

    ```bash
    unicode=> EXPLAIN SELECT * FROM unicode AS tA, unicode AS tB WHERE tA.codepoint = tB.codepoint;
                                      QUERY PLAN
    ------------------------------------------------------------------------------
     Hash Join  (cost=1869.09..4818.25 rows=34626 width=274)
       Hash Cond: ((ta.codepoint)::text = (tb.codepoint)::text)
       ->  Seq Scan on unicode ta  (cost=0.00..725.26 rows=34626 width=137)
       ->  Hash  (cost=725.26..725.26 rows=34626 width=137)
             ->  Seq Scan on unicode tb  (cost=0.00..725.26 rows=34626 width=137)
    (5 rows)
    ```

- BitmapAnd
- Merge Join
