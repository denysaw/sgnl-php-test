# SGNG Test App

## Prerequisites:
- installed PHP 8+
- running PostgreSQL
- created DB for the app

## How to start:
```bash
export DB_HOST=localhost
export DB_PORT=5432
export DB_NAME=sgnl_test
export DB_USER=root
export DB_PASS=secret

php -S localhost:8000
```

## How to test:
```bash
curl -S 'http://localhost:8000/employee/find?cn=not_found' | jq
curl -S 'http://localhost:8000/employee/find?cn=142594708f3a5a3ac2980914a0fc954f' | jq
```

## DB architecture and diagrams:
![](/Users/denysaw/git/sgnl-php-test/schema.png)
![](/Users/denysaw/git/sgnl-php-test/diagram.png)

## Steps I took:
- Architected DB.
- Architected simple source code structure, but decided to not waste a time on Models for now.
- Wrote simplest quick start migration with seeding.
- Implemented main endpoint.
- Manually tested.

## Next steps (TODO's):
- Add Redis or Memcached caching to not request DB for the same card number.
- Add CRUD's for departments, buildings, employees.
- Write simple unit-tests (but PHPUnit will be required as a dev dependency).