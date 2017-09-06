#!/usr/bin/env bash

cf cs p-mysql 100mb fortunes-db
cf create-service p-config-server standard config-service -c '{"git": { "uri": "https://iasgit.internal.t-mobile.com/ias-cf/PCF-101-Workshop", "searchPaths": "spring-cloud-services-app/configuration" } }'
cf cs p-service-registry standard service-registry
cf cs p-circuit-breaker-dashboard standard circuit-breaker
