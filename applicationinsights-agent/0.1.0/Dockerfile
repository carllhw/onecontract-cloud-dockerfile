FROM alpine

ARG APPLICATION_INSIGHTS_VERSION=3.2.1

RUN wget -qO /tmp/applicationinsights-agent.jar "https://github.com/microsoft/ApplicationInsights-Java/releases/download/${APPLICATION_INSIGHTS_VERSION}/applicationinsights-agent-${APPLICATION_INSIGHTS_VERSION}.jar"; \
  mkdir -p /opt/ApplicationInsights; \
  cp /tmp/applicationinsights-agent.jar /opt/ApplicationInsights/applicationinsights-agent.jar; \
  rm /tmp/applicationinsights-agent.jar
