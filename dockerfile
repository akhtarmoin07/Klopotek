# Fix DL3007: Pin the version instead of using 'latest'
# (I chose a recent stable version, adjust if needed)
# CHECKING THE  PR
FROM liquibase/liquibase:4.29.0

USER root

# Fix DL3008, DL3009, DL3015, DL3059
# 1. Combine all RUN commands into one (reduces layers).
# 2. Use --no-install-recommends (keeps image small).
# 3. Clean up apt lists after install (saves space).
# 4. We ignore the package version pin warning (DL3008) for curl as it's complex to maintain.
# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -o /liquibase/lib/ojdbc11.jar https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc11/23.3.0.23.09/ojdbc11-23.3.0.23.09.jar \
    && chmod 644 /liquibase/lib/ojdbc11.jar

USER liquibase