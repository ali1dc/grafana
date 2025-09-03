FROM grafana/grafana:main-ubuntu

# Update system packages to reduce vulnerabilities
# USER root
# RUN apt-get update && apt-get upgrade -y && apt-get clean
# USER grafana
