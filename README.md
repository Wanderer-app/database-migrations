# database-migrations

On Windows start commands with <b>gradlew</b>
On Linux start commands with <b>gradle</b>

<h4>Run 'gradle init' first</h4>

gradlew prod update  --- apply changes to production database <br>
gradlew local update  --- apply changes to local database <br>

gradlew prod rollbackCount -PliquibaseCommandValue=&lt;number&gt;  --- rollback a given number of changes from production database <br>
<br>
gradlew local rollbackCount -PliquibaseCommandValue=&lt;number&gt;  --- rollback a given number of changes local production database <br>

Specify local database params in db-local.properties file <br>