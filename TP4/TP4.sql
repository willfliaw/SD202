SELECT
  *
FROM
  unicode;

SELECT
  *
FROM
  unicode
WHERE
  codepoint = '0000';

SELECT
  *
FROM
  unicode
WHERE
  codepoint < '0000';

SELECT
  *
FROM
  unicode
WHERE
  charname = '<control>';

SELECT
  *
FROM
  unicode
WHERE
  numeric IS NOT NULL
  or codepoint = '0000';

SELECT
  *
FROM
  unicode
WHERE
  numeric IS NOT NULL
  AND charname < 'b';

SELECT
  *
FROM
  unicode
WHERE
  comment IS NOT NULL;

SELECT
  *
FROM
  unicode u1,
  unicode u2;

SELECT
  *
FROM
  unicode u1,
  unicode u2
WHERE
  u1.comment = u2.comment;

SELECT
  *
FROM
  unicode u1,
  unicode u2
WHERE
  u1.codepoint = u2.lowercase;
