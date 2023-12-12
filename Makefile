postgres:
	docker run --name postgres15 -p 5455:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15

createdb:
	docker exec -it postgres15 createdb  --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres15 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5455/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5455/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

# PHONY is used to tell make that these are not files
.PHONY: postgres createdb dropdb migrateup migratedown