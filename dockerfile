# Use the standard image
FROM liquibase/liquibase:latest

# Switch to root to install dependencies
USER root

# Install curl (just in case the base image doesn't have it)
RUN apt-get update && apt-get install -y curl

# Download the Oracle Driver explicitly to the internal lib folder
RUN curl -o /liquibase/lib/ojdbc11.jar https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc11/23.3.0.23.09/ojdbc11-23.3.0.23.09.jar

# Give it read permissions
RUN chmod 644 /liquibase/lib/ojdbc11.jar

# Switch back to the standard user
USER liquibase

