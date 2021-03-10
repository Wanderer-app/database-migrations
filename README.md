# database-migrations

gradlew prod update  --- apply changes to production database <br>
gradlew task local update  --- apply changes to local database <br>

gradlew prod rollbackCount -PliquibaseCommandValue=&lt;number&gt;  --- rollback a given number of changes from production database <br>
gradlew local rollbackCount -PliquibaseCommandValue=&lt;number&gt;  --- rollback a given number of changes local production database <br>

Specify local database params in gradle.properties file <br>