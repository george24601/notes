# Canary Release

1. code to go live process

2. Canary release support

3. fast rollback

4. automated testing

k8s in baremetal - need overlay network or SDN network

bind LB with k8s services

Promethus??

Traefik for reverse proxy??

Spinnaker by netflix? - integration & pipeline


Master dev mode - double write, old and new version co-exist, feature flag and a/b test, java checkstyle 

after story dev done, ask product and project manager to verify in UAT/stg environment 

mvn flyway:validate

mvn flyway:repair

rollback if unable to fix CI failure in time
