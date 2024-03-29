FROM alpine:3.18.5

# Versions of Hazelcast and Hazelcast plugins
ARG HZ_VERSION=3.12.13
ARG CACHE_API_VERSION=1.1.0
ARG HZ_EUREKA_VERSION=1.1.1
ARG JMX_PROMETHEUS_AGENT_VERSION=0.14.0

# Build constants
ARG HZ_HOME="/opt/hazelcast"

# JARs to download
ARG HAZELCAST_ALL_URL="https://repo1.maven.org/maven2/com/hazelcast/hazelcast-all/${HZ_VERSION}/hazelcast-all-${HZ_VERSION}.jar"
ARG CACHE_API_URL="https://repo1.maven.org/maven2/javax/cache/cache-api/${CACHE_API_VERSION}/cache-api-${CACHE_API_VERSION}.jar"
ARG PROMETHEUS_AGENT_URL="https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_PROMETHEUS_AGENT_VERSION}/jmx_prometheus_javaagent-${JMX_PROMETHEUS_AGENT_VERSION}.jar"
# If you update Eureka plugin version, please update also all its dependencies
# You can fetch Eureka plugin dependencies with `mvn dependency:list -DincludeScope=runtime -DoutputAbsoluteArtifactFilename=true` executed at https://github.com/hazelcast/hazelcast-eureka
# For the already formatted output, use `mvn dependency:list -DincludeScope=runtime -DoutputAbsoluteArtifactFilename=true | sed '/\.m2\/repository/!d' | sed 's/.*repository\//https:\/\/repo1\.maven\.org\/maven2\//' | sed -e 'H;${x;s/\n/ /g;s/^ //;p;};d'`
ARG EUREKA_PLUGIN_URLS='https://repo1.maven.org/maven2/com/hazelcast/hazelcast-eureka-one/1.1.2/hazelcast-eureka-one-1.1.2.jar https://repo1.maven.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.13/httpclient-4.5.13.jar https://repo1.maven.org/maven2/com/google/inject/guice/4.1.0/guice-4.1.0.jar https://repo1.maven.org/maven2/joda-time/joda-time/2.3/joda-time-2.3.jar https://repo1.maven.org/maven2/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar https://repo1.maven.org/maven2/aopalliance/aopalliance/1.0/aopalliance-1.0.jar https://repo1.maven.org/maven2/commons-configuration/commons-configuration/1.10/commons-configuration-1.10.jar https://repo1.maven.org/maven2/com/netflix/eureka/eureka-client/1.10.7/eureka-client-1.10.7.jar https://repo1.maven.org/maven2/com/thoughtworks/xstream/xstream/1.4.15/xstream-1.4.15.jar https://repo1.maven.org/maven2/com/netflix/servo/servo-core/0.12.21/servo-core-0.12.21.jar https://repo1.maven.org/maven2/com/google/code/gson/gson/2.8.6/gson-2.8.6.jar https://repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.3.4/error_prone_annotations-2.3.4.jar https://repo1.maven.org/maven2/com/netflix/netflix-commons/netflix-infix/0.3.0/netflix-infix-0.3.0.jar https://repo1.maven.org/maven2/xpp3/xpp3_min/1.1.4c/xpp3_min-1.1.4c.jar https://repo1.maven.org/maven2/commons-lang/commons-lang/2.6/commons-lang-2.6.jar https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.6.4/slf4j-api-1.6.4.jar https://repo1.maven.org/maven2/antlr/antlr/2.7.7/antlr-2.7.7.jar https://repo1.maven.org/maven2/com/google/guava/guava/30.0-jre/guava-30.0-jre.jar https://repo1.maven.org/maven2/com/sun/jersey/jersey-core/1.19.1/jersey-core-1.19.1.jar https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.10.5/jackson-annotations-2.10.5.jar https://repo1.maven.org/maven2/org/checkerframework/checker-qual/3.5.0/checker-qual-3.5.0.jar https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.10.5/jackson-core-2.10.5.jar https://repo1.maven.org/maven2/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar https://repo1.maven.org/maven2/org/antlr/stringtemplate/3.2.1/stringtemplate-3.2.1.jar https://repo1.maven.org/maven2/org/apache/commons/commons-math/2.2/commons-math-2.2.jar https://repo1.maven.org/maven2/javax/ws/rs/jsr311-api/1.1.1/jsr311-api-1.1.1.jar https://repo1.maven.org/maven2/org/codehaus/jettison/jettison/1.3.7/jettison-1.3.7.jar https://repo1.maven.org/maven2/com/netflix/archaius/archaius-core/0.7.7/archaius-core-0.7.7.jar https://repo1.maven.org/maven2/xmlpull/xmlpull/1.1.3.1/xmlpull-1.1.3.1.jar https://repo1.maven.org/maven2/com/github/andrewoma/dexx/dexx-collections/0.2/dexx-collections-0.2.jar https://repo1.maven.org/maven2/commons-codec/commons-codec/1.15/commons-codec-1.15.jar https://repo1.maven.org/maven2/javax/inject/javax.inject/1/javax.inject-1.jar https://repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar https://repo1.maven.org/maven2/commons-logging/commons-logging/1.1.1/commons-logging-1.1.1.jar https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.6/httpcore-4.4.6.jar https://repo1.maven.org/maven2/com/github/vlsi/compactmap/compactmap/2.0/compactmap-2.0.jar https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.10.5.1/jackson-databind-2.10.5.1.jar https://repo1.maven.org/maven2/com/netflix/netflix-commons/netflix-eventbus/0.3.0/netflix-eventbus-0.3.0.jar https://repo1.maven.org/maven2/commons-jxpath/commons-jxpath/1.3/commons-jxpath-1.3.jar https://repo1.maven.org/maven2/com/sun/jersey/contribs/jersey-apache-client4/1.19.1/jersey-apache-client4-1.19.1.jar https://repo1.maven.org/maven2/javax/servlet/servlet-api/2.5/servlet-api-2.5.jar https://repo1.maven.org/maven2/org/antlr/antlr-runtime/3.4/antlr-runtime-3.4.jar https://repo1.maven.org/maven2/com/sun/jersey/jersey-client/1.19.1/jersey-client-1.19.1.jar https://repo1.maven.org/maven2/stax/stax-api/1.0.1/stax-api-1.0.1.jar'

# Runtime constants / variables
ENV HZ_HOME="${HZ_HOME}" \
    CLASSPATH_DEFAULT="${HZ_HOME}/*:${HZ_HOME}/lib/*" \
    JAVA_OPTS_DEFAULT="-Djava.net.preferIPv4Stack=true -Djava.util.logging.config.file=${HZ_HOME}/logging.properties -XX:MaxRAMPercentage=80.0 --add-modules java.se --add-exports java.base/jdk.internal.ref=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/java.nio=ALL-UNNAMED --add-opens java.base/sun.nio.ch=ALL-UNNAMED --add-opens java.management/sun.management=ALL-UNNAMED --add-opens jdk.management/com.sun.management.internal=ALL-UNNAMED" \
    MIN_HEAP_SIZE="" \
    MAX_HEAP_SIZE="" \
    MANCENTER_URL="" \
    PROMETHEUS_PORT="" \
    PROMETHEUS_CONFIG="${HZ_HOME}/jmx_agent_config.yaml" \
    LOGGING_LEVEL="" \
    CLASSPATH="" \
    JAVA_OPTS=""

# Expose port
EXPOSE 5701

COPY *.xml *.sh *.yaml *.jar *.properties ${HZ_HOME}/

# Install
RUN echo "Installing new APK packages" \
    && apk add --no-cache openjdk11-jre-headless bash curl zip \
    && echo "Downloading Hazelcast and related JARs" \
    && mkdir "${HZ_HOME}/lib" \
    && cd "${HZ_HOME}/lib" \
    && for JAR_URL in ${HAZELCAST_ALL_URL} ${CACHE_API_URL} ${PROMETHEUS_AGENT_URL} ${EUREKA_PLUGIN_URLS}; do curl -sf -O -L ${JAR_URL} || exit $?; done \
    && mv jmx_prometheus_javaagent-*.jar jmx_prometheus_javaagent.jar \
    && echo "Setting Pardot ID to 'docker'" \
    && echo 'hazelcastDownloadId=docker' > "hazelcast-download.properties" \
    && zip -f hazelcast-all-${HZ_VERSION}.jar hazelcast-download.properties \
    && echo "Granting read permission to ${HZ_HOME}" \
    && chmod -R +r ${HZ_HOME} \
    && echo "Cleaning APK packages" \
    && apk del curl zip \
    && rm -rf /var/cache/apk/*

WORKDIR ${HZ_HOME}

RUN addgroup -S hazelcast && adduser -S hazelcast -G hazelcast
USER hazelcast

# Start Hazelcast server
CMD ["/opt/hazelcast/start-hazelcast.sh"]

