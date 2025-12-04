import { NodeSDK } from '@opentelemetry/sdk-node';
import { getNodeAutoInstrumentations } from '@opentelemetry/auto-instrumentations-node';
import { OTLPTraceExporter } from '@opentelemetry/exporter-trace-otlp-http';
import { BatchSpanProcessor } from '@opentelemetry/sdk-trace-node';
import { Resource } from '@opentelemetry/resources';
import { SemanticResourceAttributes } from '@opentelemetry/semantic-conventions';

const resource = Resource.default().merge(
  new Resource({
    [SemanticResourceAttributes.SERVICE_NAME]:
      process.env.OTEL_SERVICE_NAME || 'aave-proposals-v3',
    [SemanticResourceAttributes.SERVICE_VERSION]: '1.0.0',
  }),
);

const sdk = new NodeSDK({
  resource,
  traceExporter: new OTLPTraceExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT || 'http://localhost:4318',
  }),
  instrumentations: [getNodeAutoInstrumentations()],
  spanProcessor: new BatchSpanProcessor(
    new OTLPTraceExporter({
      url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT || 'http://localhost:4318',
    }),
  ),
});

sdk.start();

console.log('OpenTelemetry instrumentation initialized');

process.on('SIGTERM', () => {
  sdk.shutdown()
    .then(() => {
      console.log('OpenTelemetry instrumentation stopped');
      process.exit(0);
    })
    .catch((error) => {
      console.error('Failed to shutdown OpenTelemetry SDK:', error);
      process.exit(1);
    });
});
