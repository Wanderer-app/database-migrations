gradlew prod update --- apply changes to production database
gradlew task local update --- apply changes to local database

gradlew prod rollbackCount -PliquibaseCommandValue=<number> --- rollback a given number of changes from production database
gradlew local rollbackCount -PliquibaseCommandValue=<number> --- rollback a given number of changes local production database

Specify local database params in gradle.properties file