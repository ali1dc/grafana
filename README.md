# Grafana
Grafana CI/CD pipeline for AWS deployment.

## What is grafana?
[Grafana](https://grafana.com/) is an open source metric analytics & visualization suite. It is most commonly used for visualizing time series data for infrastructure and application analytics but many use it in other domains including industrial sensors, home automation, weather, and process control.

## Tech Stack
  * Grafana
  * Ruby
  * Cloudformation
  * Docker
  * Amazon Fargate
  * Jenkins

## Environment Variables
```sh
export GF_DATABASE_TYPE=postgres
export GF_DATABASE_HOST={db-host:port}
export GF_DATABASE_USER={db-user}
export GF_DATABASE_PASSWORD={db-password}
```

##### How to run
```sh
docker-compose up

http://localhost:3000
default user: admin
default password: admin
```
