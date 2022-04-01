FROM alpine

ARG SRM_AGENT_CALL_CHAIN_VERSION_1=3.2.0-SNAPSHOT
ARG SRM_AGENT_CALL_CHAIN_VERSION_2=3.2.0-20220329.060408-3

RUN wget -qO /tmp/srm-agent-call-chain.jar "https://nexus.onecontract-cloud.com/repository/oc-maven-snapshot/org/srm/srm-agent-call-chain/${SRM_AGENT_CALL_CHAIN_VERSION_1}/srm-agent-call-chain-${SRM_AGENT_CALL_CHAIN_VERSION_2}.jar"; \
  mkdir -p /opt/srm-agent-call-chain; \
  cp /tmp/srm-agent-call-chain.jar /opt/srm-agent-call-chain/srm-agent-call-chain.jar; \
  rm /tmp/srm-agent-call-chain.jar
