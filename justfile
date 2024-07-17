setup:
  go mod init rqtx/workload-test-server
  go mod tidy

run:
  go run src/main.go

release-dry-run:
  goreleaser release --clean --skip=validate --skip=publish --snapshot
