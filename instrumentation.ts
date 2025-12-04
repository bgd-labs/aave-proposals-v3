// Minimal OpenTelemetry instrumentation
// This module gets required early to set up tracing before the application starts

try {
  // Lazy load to ensure modules are available
  const { NodeSDK } = require('@opentelemetry/sdk-node');
  const { getNodeAutoInstrumentations } = require('@opentelemetry/auto-instrumentations-node');
  const { OTLPTraceExporter } = require('@opentelemetry/exporter-trace-otlp-http');
  const { SemanticResourceAttributes } = require('@opentelemetry/semantic-conventions');
  
  const otelEndpoint = process.env.OTEL_EXPORTER_OTLP_ENDPOINT || 'http://localhost:4318';
  const headers = process.env.OTEL_EXPORTER_OTLP_HEADERS 
    ? Object.fromEntries(
        process.env.OTEL_EXPORTER_OTLP_HEADERS.split(',').map(h => {
          const [key, value] = h.trim().split('=');
          return [key, value];
        })
      )
    : {};

  const sdk = new NodeSDK({
    traceExporter: new OTLPTraceExporter({
      url: otelEndpoint,
      headers,
    }),
    instrumentations: [getNodeAutoInstrumentations()],
  });

  sdk.start();
  console.log('✓ OpenTelemetry initialized');

  process.on('SIGTERM', () => {
    sdk.shutdown()
      .then(() => {
        console.log('✓ OpenTelemetry stopped');
        process.exit(0);
      })
      .catch(error => {
        console.error('✗ Failed to shutdown:', error);
        process.exit(1);
      });
  });
} catch (error) {
  console.error('⚠ OpenTelemetry initialization skipped:', error.message);
}
