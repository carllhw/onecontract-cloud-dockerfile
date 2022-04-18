FROM alpine

RUN wget -qO /tmp/ArmsAgent.zip "http://arms-apm-shanghai.oss-cn-shanghai.aliyuncs.com/ArmsAgent.zip"; \
  mkdir -p /opt/ArmsAgent; \
  unzip /tmp/ArmsAgent.zip -d /opt/; \
  rm /tmp/ArmsAgent.zip
  
RUN wget -qO /opt/otel-javaagent.jar "http://nexus.saas.hand-china.com/repository/oc-release/io/hcbm/otel-javaagent/1.0/otel-javaagent-1.0.jar"
  
RUN wget -qO /opt/otel-extension.jar "http://nexus.saas.hand-china.com/repository/oc-release/io/hcbm/otel-extension/1.0/otel-extension-1.0.jar"


