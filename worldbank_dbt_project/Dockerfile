# Use Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install dbt-snowflake 1.9.4
RUN pip install --no-cache-dir dbt-snowflake==1.9.4

# Copy project into image
COPY . /app

# Default command
CMD ["dbt", "run"]




# Use official dbt-snowflake image (dbt-core + adapter)
#FROM ghcr.io/dbt-labs/dbt-snowflake:1.9.4

# Set working directory
#WORKDIR /app

# Copy dbt project into the container
#COPY . /app

# Optional: install extra dependencies (if you use packages.yml or requirements.txt)
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

# Set default dbt command
#CMD ["dbt", "run"]





# Use the dbt-core + dbt-snowflake image (latest compatible one)
#FROM ghcr.io/dbt-labs/dbt-snowflake:1.6.5

#WORKDIR /app

# Copy the dbt project into the container
#COPY . /app

# Optional: install extra dependencies if you use packages.yml or requirements.txt
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

# Default command (can be overridden)
#CMD ["dbt", "run"]
