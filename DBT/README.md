Dbt is a  data transformation tool that enables data analysts and engineers to transform data in their warehouses by simply writing select statements. Dbt handles the transformation of data in the warehouse, and it  is a tool that enables data analysts and engineers to transform data in their warehouses by simply writing select statements. Dbt handles the transformation of data in the warehouse,


Traditional Data Teams

    Data engineers are responsible for maintaining data infrastructure and the ETL process for creating tables and views.
    Data analysts focus on querying tables and views to drive business insights for stakeholders.

ETL and ELT

    ETL (extract transform load) is the process of creating new database objects by extracting data from multiple data sources, transforming it on a local or third party machine, and loading the transformed data into a data warehouse.
    ELT (extract load transform) is a more recent process of creating new database objects by first extracting and loading raw data into a data warehouse and then transforming that data directly in the warehouse.
    The new ELT process is made possible by the introduction of cloud-based data warehouse technologies.

Analytics Engineering

    Analytics engineers focus on the transformation of raw data into transformed data that is ready for analysis. This new role on the data team changes the responsibilities of data engineers and data analysts.
    Data engineers can focus on larger data architecture and the EL in ELT.
    Data analysts can focus on insight and dashboard work using the transformed data.
    Note: At a small company, a data team of one may own all three of these roles and responsibilities. As your team grows, the lines between these roles will remain blurry.

dbt

    dbt empowers data teams to leverage software engineering principles for transforming data.
    The focus of this course is to build your analytics engineering mindset and dbt skills to give you more leverage in your work.


    
Setting up dbt Cloud and your data platform

As a learner, it is extremely beneficial to practice what you learn to lock in the learning. You can go through the lessons and watch all of the videos but we recommend you complete the practice exercises.

To complete the practice exercises, you will need a connection to a data platform. Before you proceed with the course, we highly recommend getting access to one of the following data platforms: BigQuery, Databricks, Redshift, or Snowflake.

The following pages will walk you through setting up your data platform and connecting to dbt Cloud. Once you have finished connecting dbt Cloud to your data platform, return to the course to continue your learning.

### Setting up dbt Cloud and your data platform
https://courses.getdbt.com/courses/take/fundamentals/texts/43380412-setting-up-dbt-cloud-and-your-data-platform


### dbt Cloud IDE


The dbt Cloud integrated development environment (IDE) is a single interface for building, testing, running, and version-controlling dbt projects from your browser. With the Cloud IDE, you can compile dbt code into SQL and run it against your database directly

1. Git repository link — Clicking the Git repository link, located on the upper left of the IDE, takes you to your repository on the same active branch.

2. Documentation site button — Clicking the Documentation site book icon, located next to the Git repository link, leads to the dbt Documentation site. The site is powered by the latest dbt artifacts generated in the IDE using the dbt docs generate command from the Command bar. 

3. Version Control — The IDE's powerful Version Control section contains all git-related elements, including the Git actions button and the Changes section.

4. File Explorer — The File Explorer shows the filetree of your repository. You can: 

    Click on any file in the filetree to open the file in the File Editor. 
    Click and drag files between directories to move files. 
    Right click a file to access the sub-menu options like duplicate file, copy file name, copy as ref, rename, delete. 
        Note: To perform these actions, the user must not be in read-only mode, which generally happens when the user is viewing the default branch. 
    Use file indicators, located to the right of your files or folder name, to see when changes or actions were made: 
        Unsaved (•) — The IDE detects unsaved changes to your file/folder 
        Modification (M) — The IDE detects a modification of existing files/folders 
        Added (A) — The IDE detects added files 
        Deleted (D) — The IDE detects deleted files



5.Command bar — The Command bar, located in the lower left of the IDE, is used to invoke dbt commands. When a command is invoked, the associated logs are shown in the Invocation History Drawer. 

6. IDE Status button — The IDE Status button, located on the lower right of the IDE, displays the current IDE status. If there is an error in the status or in the dbt code that stops the project from parsing, the button will turn red and display "Error". If there aren't any errors, the button will display a green "Ready" status. To access the IDE Status modal, simply click on this button.




Models

    Models are .sql files that live in the models folder.
    Models are simply written as select statements - there is no DDL/DML that needs to be written around this. This allows the developer to focus on the logic.
    In the Cloud IDE, the Preview button will run this select statement against your data warehouse. The results shown here are equivalent to what this model will return once it is materialized.
    After constructing a model, dbt run in the command line will actually materialize the models into the data warehouse. The default materialization is a view.
    The materialization can be configured as a table with the following configuration block at the top of the model file:

{{ config(
materialized='table'
) }}

    The same applies for configuring a model as a view:

{{ config(
materialized='view'
) }}

    When dbt run is executing, dbt is wrapping the select statement in the correct DDL/DML to build that model as a table/view. If that model already exists in the data warehouse, dbt will automatically drop that table or view before building the new database object. *Note: If you are on BigQuery, you may need to run dbt run --full-refresh for this to take effect.

    The DDL/DML that is being run to build each model can be viewed in the logs through the cloud interface or the target folder.

Modularity

    We could build each of our final models in a single model as we did with dim_customers, however with dbt we can create our final data products using modularity.
    Modularity is the degree to which a system's components may be separated and recombined, often with the benefit of flexibility and variety in use.
    This allows us to build data artifacts in logical steps.
    For example, we can stage the raw customers and orders data to shape it into what we want it to look like. Then we can build a model that references both of these to build the final dim_customers model.
    Thinking modularly is how software engineers build applications. Models can be leveraged to apply this modular thinking to analytics engineering.

ref Macro

    Models can be written to reference the underlying tables and views that were building the data warehouse (e.g. analytics.dbt_jsmith.stg_customers). This hard codes the table names and makes it difficult to share code between developers.
    The ref function allows us to build dependencies between models in a flexible way that can be shared in a common code base. The ref function compiles to the name of the database object as it has been created on the most recent execution of dbt run in the particular development environment. This is determined by the environment configuration that was set up when the project was created.
    Example: {{ ref('stg_customers') }} compiles to analytics.dbt_jsmith.stg_customers.
    The ref function also builds a lineage graph like the one shown below. dbt is able to determine dependencies between models and takes those into account to build models in the correct order.

Modeling History

    There have been multiple modeling paradigms since the advent of database technology. Many of these are classified as normalized modeling.
    Normalized modeling techniques were designed when storage was expensive and computational power was not as affordable as it is today.
    With a modern cloud-based data warehouse, we can approach analytics differently in an agile or ad hoc modeling technique. This is often referred to as denormalized modeling.
    dbt can build your data warehouse into any of these schemas. dbt is a tool for how to build these rather than enforcing what to build.

Naming Conventions 

In working on this project, we established some conventions for naming our models.

    Sources (src) refer to the raw table data that have been built in the warehouse through a loading process. (We will cover configuring Sources in the Sources module)
    Staging (stg) refers to models that are built directly on top of sources. These have a one-to-one relationship with sources tables. These are used for very light transformations that shape the data into what you want it to be. These models are used to clean and standardize the data before transforming data downstream. Note: These are typically materialized as views.
    Intermediate (int) refers to any models that exist between final fact and dimension tables. These should be built on staging models rather than directly on sources to leverage the data cleaning that was done in staging.
    Fact (fct) refers to any data that represents something that occurred or is occurring. Examples include sessions, transactions, orders, stories, votes. These are typically skinny, long tables.
    Dimension (dim) refers to data that represents a person, place or thing. Examples include customers, products, candidates, buildings, employees.
    Note: The Fact and Dimension convention is based on previous normalized modeling techniques.

Reorganize Project

    When dbt run is executed, dbt will automatically run every model in the models directory.
    The subfolder structure within the models directory can be leveraged for organizing the project as the data team sees fit.
    This can then be leveraged to select certain folders with dbt run and the model selector.
    Example: If dbt run -s staging will run all models that exist in models/staging. (Note: This can also be applied for dbt test as well which will be covered later.)
    The following framework can be a starting part for designing your own model organization:
    Marts folder: All intermediate, fact, and dimension models can be stored here. Further subfolders can be used to separate data by business function (e.g. marketing, finance)
    Staging folder: All staging models and source configurations can be stored here. Further subfolders can be used to separate data by data source (e.g. Stripe, Segment, Salesforce). (We will cover configuring Sources in the Sources module)


notes:
Data is stored in the data platform and code is stored in the git repository
Separate branches allow dbt developers to simultaneously work on the same code base without impacting production

```bash
dbt init xxxxx
dbt run
dbt docs generate
dbt docs serve
```
A given model called `events` is configured to be materialized as a view in dbt_project.yml and configured as a table in a config block at the top of the model. When you execute dbt run, what will happen in dbt? dbt will build the `events` model as a table

Which command below will attempt to only materialize dim_customers and its downstream models? dbt run --select dim_customers+

Which of the following is a benefit of using the sources feature?
- You can document raw tables in your data warehouse
- You can visualize raw tables in your DAG
- You can build dependencies between models and raw tables in your DAG


What is the correct command to test your source freshness,
 assuming the freshness config block is correct?
dbt source freshness


### Testing

    Testing is used in software engineering to make sure that the code does what we expect it to.
    In Analytics Engineering, testing allows us to make sure that the SQL transformations we write produce a model that meets our assertions.
    In dbt, tests are written as select statements. These select statements are run against your materialized models to ensure they meet your assertions.

### Tests in dbt

    In dbt, there are two types of tests - generic tests and singular tests:
        Generic tests are written in YAML and return the number of records that do not meet your assertions. These are run on specific columns in a model.
        Singular tests are specific queries that you run against your models. These are run on the entire model.
    dbt ships with four built in tests: unique, not null, accepted values, relationships.
        Unique tests to see if every value in a column is unique
        Not_null tests to see if every value in a column is not null
        Accepted_values tests to make sure every value in a column is equal to a value in a provided list
        Relationships tests to ensure that every value in a column exists in a column in another model (see: referential integrity)
    Generic tests are configured in a YAML file, whereas singular tests are stored as select statements in the tests folder.
    Tests can be run against your current project using a range of commands:
        dbt test runs all tests in the dbt project
        dbt test --select test_type:generic
        dbt test --select test_type:singular
        dbt test --select one_specific_model
    Read more here in testing documentation.
    In development, dbt Cloud will provide a visual for your test results. Each test produces a log that you can view to investigate the test results further.

In production, dbt Cloud can be scheduled to run dbt test. The ‘Run History’ tab provides a similar interface for viewing the test results.

What command would you use to only run tests configured on a source named my_raw_data?
dbt test --select source:my_raw_data


### Documentation

    Documentation is essential for an analytics team to work effectively and efficiently. Strong documentation empowers users to self-service questions about data and enables new team members to on-board quickly.
    Documentation often lags behind the code it is meant to describe. This can happen because documentation is a separate process from the coding itself that lives in another tool.
    Therefore, documentation should be as automated as possible and happen as close as possible to the coding.
    In dbt, models are built in SQL files. These models are documented in YML files that live in the same folder as the models.

Writing documentation and doc blocks

    Documentation of models occurs in the YML files (where generic tests also live) inside the models directory. It is helpful to store the YML file in the same subfolder as the models you are documenting.
    For models, descriptions can happen at the model, source, or column level.
    If a longer form, more styled version of text would provide a strong description, doc blocks can be used to render markdown in the generated documentation.

Generating and viewing documentation

    In the command line section, an updated version of documentation can be generated through the command dbt docs generate. This will refresh the `view docs` link in the top left corner of the Cloud IDE.
    The generated documentation includes the following:
        Lineage Graph
        Model, source, and column descriptions
        Generic tests added to a column
        The underlying SQL code for each model
        and more...


### Development vs. Deployment

Development in dbt is the process of building, refactoring, and organizing different files in your dbt project. This is done in a development environment using a development schema (dbt_jsmith) and typically on a non-default branch (i.e. feature/customers-model, fix/date-spine-issue). After making the appropriate changes, the development branch is merged to main/master so that those changes can be used in deployment.
Deployment in dbt (or running dbt in production) is the process of running dbt on a schedule in a deployment environment. The deployment environment will typically run from the default branch (i.e., main, master) and use a dedicated deployment schema (e.g., dbt_prod). The models built in deployment are then used to power dashboards, reporting, and other key business decision-making processes.
The use of development environments and branches makes it possible to continue to build your dbt project without affecting the models, tests, and documentation that are running in production.

Creating your Deployment Environment

    A deployment environment can be configured in dbt Cloud on the Environments page.
    General Settings: You can configure which dbt version you want to use and you have the option to specify a branch other than the default branch.
    Data Warehouse Connection: You can set data warehouse specific configurations here. For example, you may choose to use a dedicated warehouse for your production runs in Snowflake.
    Deployment Credentials: Here is where you enter the credentials dbt will use to access your data warehouse:
        IMPORTANT: When deploying a real dbt Project, you should set up a separate data warehouse account for this run. This should not be the same account that you personally use in development.
        IMPORTANT: The schema used in production should be different from anyone's development schema.

Scheduling a job in dbt Cloud

    Scheduling of future jobs can be configured in dbt Cloud on the Jobs page.
    You can select the deployment environment that you created before or a different environment if needed.
    Commands: A single job can run multiple dbt commands. For example, you can run dbt run and dbt test back to back on a schedule. You don't need to configure these as separate jobs.
    Triggers: This section is where the schedule can be set for the particular job.
    After a job has been created, you can manually start the job by selecting Run Now

Reviewing Cloud Jobs

    The results of a particular job run can be reviewed as the job completes and over time.
    The logs for each command can be reviewed.
    If documentation was generated, this can be viewed.
    If dbt source freshness was run, the results can also be viewed at the end of a job.

    