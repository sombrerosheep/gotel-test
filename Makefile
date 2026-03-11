gen:
	go tool go.opentelemetry.io/collector/cmd/builder --config builder-config.yaml && \
	pushd otelcontribcol && \
	go mod tidy && \
	go get go.opentelemetry.io/otel/exporters/otlp/otlpmetric/otlpmetrichttp@v1.41.0 && \
	popd

build:
	pushd otelcontribcol && \
	GOOS=linux go build . && \
	popd

run: gen build
	docker compose up --build collector
