
# Interview Prep Questions

## Module 1 - Relational Databases

### Theory

* What makes relational databases "relational"?
  * A relational database stores associated information across multiple tables; hence data from one table "relate to" or have "relationships with" data from other tables in the database.
* What types of relationship can exist between tables?
  * Tables can have one of the following 3 (4) relationships to each other: One-to-one, one-to-many (many-to-one), and many-to-many.
* What is an ERD?
  * An entity-relationship diagram (ERD) is a visual representation of database entities (tables), each entity's fields (including datatypes and keys), and the relationships between those entities.
* What is normalization?
  * Normalization is the process of applying best-practice designs to database schemas, namely, to **reduce redundancy and increase integrity**; these practices include removing row-row interdependencies, ensuring that each cell holds only a single value, eliminating redundancies (by not repeating data across tables), separating relationships across tables, and ensuring that dependencies are logical (by grouping related information into its own table).
  * Normalization can get very academic very quickly, but it is important to be aware of "normal forms". First (1NF), Second (2NF), Third (3NF), etc. normal forms of data represent iterative steps of normalization. (BCNF is Boyce-Codd Normal Form, which is essentially NF 3.5.)
* What is denormalization?
  * Denormalization is the deliberate relaxing of normalization principles to accommodate ease-of-use and efficiency. A common expression is "normalize until it hurts, then de-normalize until it works".
* What is a primary key?
  * A primary key is a column or group of columns that uniquely identifies rows of a table. There are three main classifications of primary keys: (1) synthetic keys, which are arbitrarily-assigned values, usually incrementing integers: 1, 2, 3, 4, etc.; (2) natural keys, which are inherent to the data, such as social security numbers (SSNs) or vehicle identification numbers (VINs); and (3) composite or multicolumn keys, which use two or more columns to identify a row.
* What is a foreign key?
  * A foreign key is a table's reference to another table's primary key. Foreign keys allow normalized tables to manage relationships.
* What is SQL?
  * Structured Query Language (SQL) is programming language used to manage relational databases.
* Is SQL case-sensitive?
  * No, SQL is not case-sensitive; however, the convention is to use all uppercase or all lowercase, not title case (e.g., `SELECT` or `select`, not `Select`).
* Is SQL whitespace-sensitive?
  * No, SQL is not whitespace-sensitive. Line breaks, spaces, and indents are for readability and do not affect the code itself.
* What is the difference between the datatypes FLOAT, DOUBLE, and DECIMAL?
  * Each of these data types encodes fractional/decimal values, but the difference is storage size and precision. `FLOAT` occupies ~4 bytes and is accurate to ~6 decimal places; `DOUBLE`, ~8 bytes and ~15 decimal places; `DECIMAL`, ~15 bytes and ~38 decimal places.
* What is the difference between the datatypes DATE, TIME, DATETIME, and DATETIMEOFFSET?
  * `DATE` has date (`YYYY-MM-DD`) without time, `TIME` has time (`HH:MM:SS.ffff`) without date, `DATETIME` has both date and time (`YYYY-MM-DD HH:MM:SS.ffff`), as determined by the server settings, usually its location, `DATETIMEOFFSET` (`YYYY-MM-DD HH:MM:SS.ffff+HH:MM`) appends a timeshift to datetime. `DATETIMEOFFSET` is  not a timezone; it is a simple arithmetic operation with no awareness of complex time zone features such as Daylight Savings.
* What is Z-formatting, as it pertains to temporal data types?
  * Z-formatting, noted by the letter "Z" at the end of a timestamp, indicates that it is in UTC time.
* What is the difference between the data types CHAR, NCHAR, VARCHAR, and NVARCHAR?
  * "N" stands for "*national* character/language". `N[VAR]CHAR` encodes UNICODE values and occupies at least two bytes of memory per character; `[VAR]CHAR` encodes ASCII values and occupies at least one byte per character. (UNICODE encodes most characters from most languages, whereas ASCII encodes the subset that is basically described by an English QWERTY keyboard.)
  * "VAR" stands for "*variable* length". `[N]CHAR` occupies a fixed amount of memory whereas `[N]VARCHAR` occupies a *VAR*iable about of memory based on the size of the string. `[N]CHAR` is rarely used; it is slightly more memory-efficient but can lead to unexpected results owing the way it pads values; generally, `[N]CHAR` will be limited to uses such as sex (`CHAR(1)`), country abbreviation (`CHAR(3)`), US partial zip code (`CHAR(5)`), and other fixed-length categorical data.

### Basic Querying

* Explain what `SELECT *` does.
  * `SELECT *` returns all columns of the table(s) being queried.
* What does a `WHERE` clause accomplish?
  * The `WHERE` clause uses a condition to limit which rows are returned by a query.
* How can one limit rows returned by a query?
  * The most common ways to limit the rows returned by a query are (1) imposition of a numeric limit using `SELECT TOP(N)` or `LIMIT N`, (2) inclusion of a `WHERE` clause, and/or (3) utilization of an `INNER JOIN`.
* How are the number of columns returned determined?
  * The columns returned by a query are determined by the list of columns in the `SELECT` statement; e.g., `SELECT *` will return all available columns, `SELECT *, *` will return all available columns twice, and `SELECT colA, colB` will return only the two columns specified.
* What is a table alias?
  * A table alias is a temporary name assigned to a table within a query to make reading and writing that query easier for the developer. It is accomplished by following the table's mention in the `FROM` clause by the alias or "`AS` alias". E.g., `SELECT * FROM myLongTableName myAlias;` or `SELECT * FROM myLongTableName AS myAlias;`. (This is only helpful when the table name is used multiple times in a single query, such as when selecting columns or using joins.)
* What is the purpose of a join?
  * A table join combines data from multiple tables.
* What are the different types of joins?
  * Broadly speaking there are `INNER` and `OUTER` joins. `INNER` joins return only records that satisfy the join condition ("intersection" from set theory); `LEFT OUTER` and `RIGHT OUTER` joins return the entire left or right table, respectively, and the records from the other table that satisfy the join condition; `FULL OUTER` joins return all the records from both tables ("union" from set theory).
* What is a self-referencing join?
  * A self-referencing join involves a table joining to itself; this is commonly used in tables that contain hierarchical data, such as an employee table with a "reports to" column that contains primary keys from the table itself.
* What makes a table "left" verses "right"?
  * Whether a joined table is "left" or "right" depends on the order in which it appears in the query. Thinking of a query being written from left to right, the first table is the left table, and the second table is the right table.
* What is an aggregated column?
  * An aggregated column uses an aggregate function to return a result that is compiled from multiple cells. Common examples of functions include COUNT(), SUM(), MAX(), and MIN(), but there are many other functions, including ones that combine columns (instead of rows) and aggregate string datatypes.
* What clause accompanies aggregate functions, and when is it required?
  * If individual columns are specified when using aggregate functions, a `GROUP BY` clause is required.
* How are aggregated columns filtered?
  * Aggregated columns are filtered using a `HAVING` clause.
* What is DDL?
  * Data Definition Language (DDL) is a subset of SQL used to define and modify data structures. Common commands include `CREATE`, `DROP`, and `ALTER`.
* What is DML?
  * Data Manipulation Language (DML) is a subset of SQL used to act on the information contained in a table (rather than on the table itself, for which DDL is used). Common commands include `SELECT`, `INSERT INTO`, `UPDATE`, and `DELETE`.
* How is data deleted from a table?
  * `DELETE FROM myTable WHERE condition;`. The `WHERE` clause is extremely important; without it, everything in the table will be deleted.

### Advanced Concepts

* How are variables created in SQL?
  * Variables are initialized using the `DECLARE` command. E.g., `DECLARE @myVar INT;`.
  * Variables are assigned using the `SET` command. E.g., `@myVar = 20`. (Note that a query can be used to assign a variable.)
* What is the `DISTINCT` command do?
  * The `DISTINCT` command, which immediately follows the word `SELECT` is used to return a dataset without duplicate rows.
* What are `UNION` and `UNION ALL`?
  * `UNION` and `UNION ALL` combine the results of two queries by "stacking" the results; that is, appending the results of the second query to those of the first. `UNION ALL` returns all results, whereas `UNION` returns only distinct results.
* What is a subquery?
  * A subquery is a query used within a query. E.g., `SELECT * FROM myTable WHERE col1 >= (SELECT AVG(col1) FROM myTable);` 
* What is a stored procedure?
  * A stored procedure (or stored proc) similar to a function in other programming languages; it is a reusable, callable block of code. They can return results and/or be parameterized.  
* What is indexing?
  * Indexing allows database rows to be stored in a sorted order. If a query meets certain requisite conditions, an indexed table can lead to improved performance (than if the table were non-indexed).
* What is partitioning?
  * Partitioning stores a table's data as discrete chunks based on the values of the partition column. If a query meets certain requisite conditions, a partitioned table can lead to improved performance (than if the table were non-partitioned.)
* What is a CTE?
  * A Common Table Expression (CTE) is a temporary, named result that can be used in a subsequent query. They are identified by the keyword `WITH`. (Multiple CTEs can be declared at once.)
* What is a view?
  * A view is a stored query that can be used in place of a table when writing a query.
* What is the difference between `DELETE`, `TRUNCATE`, and `DROP`?
  * `DELETE` is used to remove selected records from a table; a `WHERE` clause can be used, and identities are not reset. `TRUNCATE` is used to remove all data from a table; a `WHERE` clause cannot be used, and identities are reset. `DROP` completely removes a table and all of its data; a `WHERE` clause cannot be used, and identities will not exist post-execution.
* What is a transaction?
  * A transaction is a unit of work performed against a database. The best practice is to start transactions with the `BEGIN` command and either `ROLLBACK` or `COMMIT` the transaction based on its result. 
* What are the ACID principles?
  * The ACID principles are properties that all relational-database transactions should have.
  * Atomicity: Transactions are all-or-nothing. Either they completely succeed or completely fail; there is no "partial success".
  * Consistency: Transactions respect the constraints/rules of the database and leave the database in that consistent state when complete.
  * Isolation: Although multiple transactions can happen simultaneously, the final result must be the same as if each transaction were run separately from the others. I.e., one transaction does not affect a concurrently-running transaction.
  * Durability: Databases must be kept in permanent storage (such as written to disk) rather than in-memory, so that external influences (such as software updates) do not affect the data.
* What is a semi join?
  * A left semi join returns exactly one record from the left table for each record of the right table that satisfies the join condition. Unlike inner and outer joins, a semi join cannot multiply rows (i.e., return more than one row for a given row of the left table). Most versions of SQL do not support semi joins; instead, an `EXISTS` or `IN` condition is typically used; e.g., `SELECT a.* FROM a WHERE a.key IN (SELECT b.Key FROM b);`.
* What is an anti join?
  * A left anti join returns the records from the left table that have no matches to the right table (left minus right, from set theory). Most versions of SQL do not support anti joins; instead, a join and filter are typically used; e.g., `SELECT a* FROM a LEFT OUTER JOIN b ON a.key = b.key WHERE b.key IS NULL`.
* What is a cross join?
  * A cross join (or Cartesian join) returns the Cartesian product of two table. A Cartesian product is the product set of multiple sets; that is, the combination of every member of the first set multiplied by every member of the second set. (This operation is potentially very expensive: If the left table has N records and the right has M records, the result will have N*M records. A `WHERE` clause can be used to filter results; however, in such cases, an inner join is typically a better approach.) 
* What is a cross apply?
  * A cross apply inner joins a left table to a table-valued function. E.g., `SELECT * FROM a CROSS APPLY myfn(a.key)`.
  * (An outer apply left outer joins a left table to a table-valued function.)
* What is a merge?
  * A merge is used to combine two datasets using logic based on the following conditions: `WHEN MATCHED`, `WHEN NOT MATCHED BY sourceTbl`, and/or `WHEN NOT MATCHED BY targetTbl`.

## Module 2 - Non-relational Databases

### General

* What is a non-relational database?
  * Non-relational databases (often called NoSQL ["Not only SQL"] databases) are collections of data that do not utilize table structures.
* What are the benefits and shortcomings of non-relational databases (as compared to relational databases)?
  * Benefits: Non-relational databases are easier to scale, generally faster to query, support flexible expansion, and accommodate inconsistent datatypes. They particularly excel with datasets whose structure is inconsistent, mutable, or unknown.
  * Shortcomings: Non-relational databases do not enforce ACID compliance, do not leverage relationships to reduce duplicate data, and do not enjoy querying languages as robust as SQL.
* In addition to key-value, document, column-store, and graph databases, what are some other types of non-relational databases?
  * Time-series databases, ledger databases, search databases.

### Key-value and Document

* What is a key-value database?
  * A key-value database stores data in key-value pairs (like a Python dictionary). Keys are unique and are associated with a single value. (The value can be simple, like a number or string, or complex, like a dictionary or JSON-like structure.)
* List common use cases for key-value databases.
  * Applications that require quick but simple reads and writes or use in-memory data caching to increase speed (such as user sessions and e-commerce shopping carts).
  * Stock ticker => company information. Airport call sign => airport information. URL => HTML text of website. Acronym => meaning.
* List some common key-value databases.
  * Redis, Riak, Oracle NoSQL, LMDB, Azure Key Vault, Azure Table Storage, Amazon DynamoDB, Oracle Berkeley DB
* What is a document database?
  * A document database stores data in collections of documents, most commonly in JSON-like structures or XML.
* List common use cases for document databases.
  * Datasets in which available data vary greatly from entry to entry (e.g., user profiles or patient records), book databases, catalogues, applications that extract big data in real-time.
* List some common document databases.
  * Azure CosmosDB, MongoDB, PostgreSQL, Amazon DocumentDB, ArangoDB, Couchbase Server, CouchDB
* How do key-value and document databases differ?
  * Though both key-value and document databases use the principle of key-value pairing, document databases enforce that the "value" is indeed a document (JSON-like object, XML, etc.) and not just anything (e.g, integer, string, etc.). Additionally, document databases support metadata and allow documents/values to be indexed and/or grouped into collections. Finally, document databases support more-advanced queries because of the predictable document format.

### Column-store

* What is a column-store database?
  * A column-store (or wide-column) database stores tabular data as individual columns (in contrast to a relational database table, which is stored as rows).
* List common use cases for column-store databases.
  * Large datasets that can be formatted as tables, especially when such datasets are rarely accessed (thus are good candidates for the highly-compressed files that column-store databases utilize), are subjected to aggregate functions, or do not usually need all the columns to be read. 
* List some common column-store databases.
  * Cassandra, Google BigTable, Amazon Redshift, HBase, MariaDB, Druid, Hypertable

### Graph

* What is a graph database?
  * A graph database emphasizes networks by storing information in **nodes** (or vertices), **edges** (which are the relationships between nodes, and **properties** that describe those nodes and edges.
* List common use cases for graph databases.
  * Applications that generate recommendations, applications that relate users together via friends/connections/etc., fraud detection, computing-network management and routing, semantic searches, master data management, dependencies, interests.
* List some common graph databases.
  * JanusGraph, Neo4j, DGraph, DataStax, TigerGraph, Amazon Neptune, Amazon TinkerPop, Apache Spark, Azure CosmosDB Gremlin API

## Module 3 - Excel

* How can Excel be used by data analysts?
    * Excel is a "Swiss-Army knife" that can perform many functions well, especially spot-checking and formatting data. Power Query Editor is used to create a reusable sequence of data-cleansing steps. 
* What does ETL stand for?
    * ETL, which stands for extract, transform and load, is a data integration process that combines data from multiple data sources into a single, consistent data store that is loaded into a data warehouse or other target system.
* Define each stage of ETL and talk about the steps involved in each stage.
    * *Extract* gathers data from one or more source systems.
    * *Transform* modifies data, including cleansing and mapping: changing data types, filling values, dropping rows, removing columns, standardizing values, etc.
    * *Load* writes data to a sink. 
* How can data be imported into Excel?
    * Excel's "Get & Transform" includes built-in methods to import data from over 40 sources, including CSV files, Excel workbooks, and SQL databases.
* What are some of the common file formats for Excel import?
    * Text/CSV, Excel, JSON, XML, and PDF. 
* What are some common issues that occur when importing data?
    * Many data sources--including databases and some websites--require proper access credentials.
    * Extremely-large datasets can be too large or Excel to handle.
    * As with importing data anywhere, the source might be corrupt or incompatible.
* What is the 1900 problem?
    * Excel incorrectly assumes that the year 1900 is a leap year. (Read more at [learn.microsoft.com](https://learn.microsoft.com/en-us/office/troubleshoot/excel/wrongly-assumes-1900-is-leap-year).) Additionally, Excel does not store dates prior to 1900-01-01.
* What does the Transform functionality do in Excel?
    * Power Query Editor (backed by Power Query M) is a user interface that allows for easy data manipulation, including fitlering, replacing values, creating and removing fields, merging and appending datasets, and much more.
* When transforming a JSON dataset, how can `null` values be removed?
    * Use the filter dropdown by a column's header to select everything *except* "(blank)".
* What is a Pivot Table?
    * A PivotTable is an interactive way to quickly summarize large amounts of data. You can use a PivotTable to analyze numerical data in detail, and answer unanticipated questions about your data. A PivotTable is especially designed for:
        * Querying large amounts of data in many user-friendly ways.
        * Subtotaling and aggregating numeric data, summarizing data by categories and subcategories, and creating custom calculations and formulas.
        * Expanding and collapsing levels of data to focus your results, and drilling down to details from the summary data for areas of interest to you.
        * Moving rows to columns or columns to rows (or "pivoting") to see different summaries of the source data.
        * Filtering, sorting, grouping, and conditionally formatting the most useful and interesting subset of data enabling you to focus on just the information you want.
        * Presenting concise, attractive, and annotated online or printed reports.    
* What is correlation?
    * Correlation is a statistical measure that expresses the extent to which two variables are linearly related (meaning they change together at a constant rate). It’s a common tool for describing simple relationships WITHOUT making a statement about cause and effect.
    * Correlation is on a scale of -1 to +1
        * A Negative correlation means that as one variable increases, the other decreases
        * A Positive correlation means that the variables change in the same direction, that is: As one increases, the other increases. Or, as one decreases, the other also decreases.
        * No correlation means there is no linear relationship between the two variables
     * Correlation can’t look at the presence or effect of other variables outside of the two being explored. Importantly, correlation doesn’t tell us about cause and effect. Correlation also cannot accurately describe curvilinear relationships.
* What are some of the limitations of Excel?
    * Excel does not handle dates earlier than 1900-01-01 well.
    * An Excel workbook is limited to just over 1 million records.
* Explain the benefits of Power Query Editor and its pros/cons versus importing and transforming data directly in a workbook. 
    * Pros: PQE is reusable.  Various steps are easy to remove or reorder.  Can merge datasets. 
    * Cons: Users are less likely to be familiar with it.  Tasks are accomplished using a different UI than normal Excel. 

## Module 4 - Data Visualizations and Power BI

* Why are data visualizations important?
    * The importance of data visualization is simple: it helps people see, interact with, and better understand data. Whether simple or complex, the right visualization can bring everyone on the same page, regardless of their level of expertise.

* What are some considerations when designing data visualizations?
    * Data Visualizations Should Be:
        * Observable. The graphic contains a fact or a trend that a lay person can see. Visuals should speak for themselves! Graphs should tell a story that ANYONE can follow. You should be able to show your graphic to someone and they should be able to interpret the meaning, trend, and story from the graph itself. If you need to be present to tell the story of the graph, then your graph should be reconsidered.  
        * Accessible. This means taking things like color palatte (consider red/green color blindness), font size, font shapes, etc into account.
        * Objective. The graphic does not attempt to hide a fact or trend, nor does it attempt to create one that is not there. The graph does NOT hide or misrepresent anything; often, an incorrect or misleading title is applied to a graph.
        * Original. The graphic contains verifiable data sources. Sources, any restrictions on the data, and any other condition that was used to create the graphic should be cited. Anyone should be able to re-create the graph from the information provided in the graph itself from the underlying data.
        * Open. The graphic is clear and concise. Simple is best! Complicated graphs with many moving parts, fancy colors, arrows, and/or text boxes are confusing and difficult to explain and interpret. 
    * Data Visualizations Should Have:
        * Title. A simple but descriptive title that explains the graph; the title should be descriptive and tell the story. Good titles grab the attention of the viewer and explain what is happening.
        * Axis Labels. This is so the viewer can tell exactly what they're looking at - what are the variables used? What units are these variables in?
        * Caption. If the title is not enough to explain what is happening, then a caption should be added. Even if your report explains it in the text, consider adding a caption to help let the graph stand alone.
        * Citations and Sources. The graph should include all data sources and citations. The graph should be thoroughly cited. If the graph was removed from the report completely (say as a trial exhibit), could it stand alone?
        * Colors. Proper use of color is key to telling the story. Colors that flow together can hide trends and patterns, while colors that deviate wildly from each other can distract from the overall meaning. Balance is key.        

* Name appropriate visualization types for the following: 
    * To display relationships between numerical data? 
        * Scatter plot 
        * Line chart – good for change in some numerical value over time  
    * To display distributions 
        * Histograms 
        * Box plots 
            * What's the advantage of a box plot over a histogram? 
                * Shows distribution WITH stats 
    * Categorical variable comparisons 
        * Bar charts 
    * What visualizations can look cool but are challenging to interpret quickly and completely? 
        * Pie Charts 
        * Treemaps 
        * Word Clouds 

* What are common data visualization design principals and why do they matter? 
    * Design Principals: 
        - Principle: The human eye is drawn to large objects 
            - Bold font for most important things 
        - Principle: Shapes are inherently different 
            - shapes and sizes of font, icons etc matter 
        - Principle: Things close together are related 
            - group like things together 
            - hierarchy - most important things at the top 
        - Principle: The number one indicator of an amateur design in misalignment 
            - lay things our nicely! 
        - Principle: Color has meaning and may illicit an emotional response 
            - how do different colors make us feel? How do we want our audience to feel? 
            - what other considerations should be be aware of with color? Red/green color blindness 
        -  Principle: Typefaces convey meaning 
            - font matters 
            - Think comic sans vs Times new roman 
  
 * Why do design principals matter? 
        * The clearer a message is, the more likely it is to be understood and adopted 
        * The human brain's capacity for storing and processing information in the short term is very, very limited 
        * Because of these assumptions, we have to do everything we can to make sure that we capture the viewer's attention and when we have it, effectively communicate the intended message. 
        * In short: They matter because how we represent our data and how we display ideas impacts their effectiveness.
    

## Module 6 - Python Basics
### Concepts
* What are common Python datatypes?
    * `int` (integer), `float` (floating-point), `bool` (Boolean), sequences (list, tuple, range), `str` (string/text), `set` (set), `dict` (dictionary)
* Explain the difference between integers and floating-point numbers.
    * Integers do not have decimals whereas floats do have decimals. (Additionally, integers have infinite precision whereas floats have 64-bit double precision.)
* What is a variable, and how are a variable's type and value set?
    * A variable a "storage container" for a value. A variable is created when a value is assigned to, and the variable's type equals the type of the assigned value.
* Compare and contrast lists, tuples, sets, and dictionaries.
    * A list is a mutable, ordered sequence that permits duplicates.
    * A tuple is an immutable, ordered sequence that permits duplicates.
    * A set is a mutable, unordered collection that forbids duplicates.
    * A dictionary is a mutable, ordered* mapping object that uses key-value pairs, of which duplicate keys are forbidden but duplicate values are permitted. (*since Python version 3.7)
* Describe different methods for accessing information in a dictionary.
    * `dict.items()` returns a view object containing tuples of the dictionary's key-value pairs
    * `list(dict)` and `dict.keys()` are used to retrieve a dictionary's keys. The former returns a static list that does not respond as the dictionary's keys update; the latter returns a view object that is dynamic and does respond as the dictionary's keys update.
    * `dict.values()` returns a view object containing the dictionary's values
    * `dict[key]` and `dict.get(key)` are used to retrieve the value for a given key. The former throws an exception if the key does not exist; the latter returns `None` or an optional default value.
* What is the format for list comprehension?
    * `newlist = [expression for item in iterable if condition]`. E.g., `newlist = [i*2 for i in [1,2,3,4,5] if i>2]`
* What does the `enumerate()` function do?
    * The `enumerate()` function takes an iterable object and an optional start value (default = 0) and returns an enumerate object that contains tuples of the values incremented by 1 from the start value and the item from the iterable. It is frequently used to access both the index and value of items in a list while looping through that list using a `for` loop 
* Compare and contrast functions and methods.
    * Both functions and methods are callable, reusable code that can return values.
    * A function is called by name, may or may not takes parameters, and is not associated with a class.
    * A method is called by name through an object, takes `self` and possibly other parameters, and is associated with a class
* What is recursion?
    * Recursion is the process of a function calling itself. (Such a function is called a recursive function.)
* Explain different types of loops.
    * A `where` loop will continue to execute provided that its condition is true; these are used when the number of needed loops is not known prior to beginning the loop.
    * A `for` loop will execute a set number of times.
* Explain the keywords `break`, `continue`, `pass`, and `return`.
    * `break` terminates a loop
    * `continue` halts the iteration of a loop but does not terminate the loop itself
    * `pass` does nothing; it is used to create a placeholder for future code or to skip a block of code that cannot be empty
    * `return` is used by methods and functions end the method/function and yield one or more values to the caller
* What is slicing?
    * Slicing is used to create a subset of an iterable (i.e., list, tuple, or range). To slice from index `i` to index `j-1`, use syntax `newit = it[i:j]`. To slice from index `i` to index `j-1` with step `k`, use syntax `newit = it[i:j:k]`
* What is exception handling?
    * Exception handling controls how errors (that is, exceptions) from a code block are managed. The attempted code placed in a `try` block; the code to run if an exception is raised if placed in an `except` block. An optional `finally` block can be appended which will run after all other code from the try-except.
* What is the difference between `=` and `==`?
    * `=` is the assignment operator; it assigned a variable to a given value
    * `==` is the equal operator; it is a comparison operator that returns `True` if the values being compared are equal, and `False` otherwise
* What is the modulo operator?
    * The modulo operator--`%`--is used to determine the remainder of division. E.g., `4%2` returns 0 because 4 is evenly divisible by 2, whereas `5%2` returns 1 because 5/2 has a remainder of 1
* How can numbers be exponentiated in Python?
    * Number a raised to the power of number b can be accomplished using either `a**b` or `pow(a,b)`

### How would you...
* Implement fizz-buzz (divisible by 3 = fizz, by 5 = buzz, by 3 and 5 = fizz-buzz)?
    * Use a `for` loop and conditional logic:
    ```
    for i in range(max_num):
        if i%3 and i%5:
            print(f'{i} fizz-buzz)
        elif i%3:
            print(f'{i} fizz')
        elif i%5:
            print(f'{i} buzz')
        else:
            print(i)
* Determine a variable's type?
    * Using the `type()` function: `var_type = type(my_var)`
* Loop through all items in a list? Loop through every other item in a list?
    * Using a `for` loop: `for i in my_list: <code>`
* Ask the user for input ensure that it is an integer?
    * Use the `input()` function, the `int()` function, and a `try-except`:
    ```
    user_input = input('Prompt: ')
    try:
        user_input = int(user_input)
    except:
        pass
    ```

## Module 7 - Object Oriented Data Modeling

* What are methods?
    * A method is a function that “belongs to” an object. (In Python, the term method is not unique to class instances: other object types can have methods as well. For example, list objects have methods called append, insert, remove, sort, and so on.
* Compare and contrast methods and functions. 
    * Both are callable, reusable code. 
    * Methods are called by name through its object, takes self and possibly other parameters, and is associated with a class 
    * Functions are called by name, may or may not take parameters, and are not associated with a class.  
* What are attributes?
    * Attributes of a class are function objects that define corresponding methods of its instances. They are used to implement access controls of the classes.
    * Attributes of a class can also be accessed using the following built-in methods and functions :
        * getattr() – This function is used to access the attribute of object.
        * hasattr() – This function is used to check if an attribute exist or not.
        * setattr() – This function is used to set an attribute. If the attribute does not exist, then it would be created.
        * delattr() – This function is used to delete an attribute. If you are accessing the attribute after deleting it raises error “class has no attribute”.
* Explain lambda functions. 
    * Lambda functions are Python short-hand:  They are anonymous (unnamed) functions that can be used in place of defining a function and calling it later.   The syntax of a lambda function is "lambda arguments : expression"; e.g., "lambda x, y : x + y", where the value x + y is returned. 
* Why is flowcharting or pseudocoding important?
    * Pre-code planning plays an important role in creating an algorithm or a program, helping programmers plan how to write the code. Pseudocode is a false code used to describe how a computer program or an algorithm works. It uses annotations and text written in English because it’s meant for humans to read instead of computers.  
    * Flowcharts offer a visual representation of an algorithm. This type of diagram helps explain the algorithm to other people (and yourself) by spelling out the flow of logic behind a program module. It also provides the coder with a guide to writing the real code.  Specifically, a flow diagram presents how codes are organized, offers a visualization presentation of how codes are used in the executable program. It illustrates the structure of an application or a website and explains the path users take to navigate an actual program or website. 
    * Using flowcharts in pre-code planning offers a handful of benefits. 
        * They enable easy communication between the programmer and other members. 
        * They help analyze a process to ensure the inclusion of all inputs, outputs, and processes.
        * They make sure coding is efficient. 
        * Flowcharts assist programmers in identifying potential issues so they can fix the actual code. 
* What is the different between an object and a class? How are the two related?
    * A class defines object properties including a valid range of values, and a default value. A class also describes object behavior. An object is a member or an "instance" of a class. An object has a state in which all of its properties have values that you either explicitly define or that are defined by default settings.
* What does init do?  What is the purpose of a constructor?
    * The __init__ method lets the class initialize the object's attributes. 
    * Constructors are used to initializing the object’s state. The task of constructors is to initialize(assign values) to the data members of the class when an object of the class is created. Like methods, a constructor also contains a collection of statements(i.e. instructions) that are executed at the time of Object creation. It is run as soon as an object of a class is instantiated. The method is useful to do any initialization you want to do with your object. 
* How do we use the keyword self within classes? 
    * Self is used at the first argument passed into [almost] every classmethod we construct on a class. Self refers to the instance of the object created and thus will reference two separate data objects when called. Self can be used to attach  
    * One of the implications of self is that of self is that an object must be instantiated before it's methods can be called. Take the example of LinearRegression in sklearn where we first instatiate an instance lr=LinearRegression() before we call lr.fit() 
    * To remove this instantiation requirement and invoke classmethods before instantiation we can use the @classmethod or @staticmethod decoarators to indvidual methods in the classes we define. Also we can use @dataclass's on our class definition to reduce the self boilerplate. 

## Module 8 - Pandas and Visualizations
* What is pandas? How is it used by data analysts?
    * `pandas` is the most popular python package for managing datasets and is used extensively by data scientists.
[Pandas documentation](https://pandas.pydata.org/about/index.html)
    *  Data analysis library - **Panel data system** (doesn't actually have to do with the animal)
    *  Most ubiquitous tool used to start data analysis projects within the Python scientific ecosystem.
    * Pandas is an open source Python package that is most widely used for data science/data analysis and machine learning tasks. It is built on top of another package named Numpy, which provides support for multi-dimensional arrays. As one of the most popular data wrangling packages, Pandas works well with many other data science modules inside the Python ecosystem, and is typically included in every Python distribution.
    * Pandas provide tools for reading and writing data into data structures and files. It also provides powerful aggregation functions to manipulate data. Pandas provide extended data structures to hold different types of labeled and relational data. This makes python highly flexible and extremely useful for data cleaning and manipulation. 
    * Pandas makes it simple to do many of the time consuming, repetitive tasks associated with working with data, including:
        * Data cleansing
        * Data fill
        * Data normalization
        * Merges and joins
        * Data visualization
        * Statistical analysis
        * Data inspection
        * Loading and saving data
        
* What are the two main types of objects used in the pandas library?
    * The two primary data structures of pandas, Series (1-dimensional. Like an individual column) and DataFrame (2-dimensional - has both columns and rows), handle the vast majority of typical use cases in finance, statistics, social science, and many areas of engineering.
    * A **`Series`** is a one-dimensional array of values **with an index**.
    * A **`DataFrame`** is a two-dimensional array of values **with both a row and column index**.
    * It turns out - each column of a `DataFrame` is actually a `Series`!
    * There is an important difference between using a list of strings and just a string with a column's name: when you use a list with the string it returns another **DataFrame**, but when you use just the string it returns a pandas **Series** object.   
    
* What pandas method might you use to get the frequency of unique values in a column?
    * Using values_counts() to calculate the frequency of unique value. 
    * df['column_name'].value_counts()   
    
* What pandas method might you use to calculate aggregate values for distinct groups in your data? (Alternatively: What pandas method uses the "split-apply-combine" pattern for data aggregation?)
    * Split: Separate your data into different DataFrames, one for each category.
    * Apply: On each split-up DataFrame, apply some function or transformation (for example, the mean).
    * Combine: Take the results and combine the split-up DataFrames back into one aggregate DataFrame.
    * You use a Groupby!
    
* How does a groupby operation work in pandas?
    * df.groupby('categorical_variable')['continuous_variable'].some_aggregation()    
    
* How might you find all rows with missing values in a dataset using pandas?
    * df.isnull().sum()
    * df.info()

* How would you get a count of missing values in each column of a dataframe?
    * df.isnull().sum()
    * df.info()
    
* What information does a .info() return?
    * .info() is a function that is available on every DataFrame object. It gives you information about:
    * Name of column / variable attribute
    * Type of index (RangeIndex is default)
    * Count of non-null values by column / attribute
    * Type of data contained in column / attribute
    * Unique counts of dtypes (Pandas data types)
    * Memory usage of our dataset   
     
* What are some common data issues we have to deal with when working with an uncleaned dataset?
Typical problems when working with new datasets:
        * Missing values
        * Unexpected types (string/object instead of int/float)
        * Dirty data (commas, dollar signs, unexpected characters, etc)
        * Blank values that are actually "non-null" or single white-space characters
        
* What information does a .describe() provide?
    * .describe() gives us these statistics:
        * count, which is equivalent to the number of cells (rows)
        * mean, the average of the values in the column
        * std, which is the standard deviation
        * min, the minimum value
        * 25%, the 25th percentile of the values
        * 50%, the 50th percentile of the values, which is the equivalent to the median
        * 75%, the 75th percentile of the values
        * max, the maximum value        
        
* You're looking at your Pandas Dataframe and all data appears to be either an int or a float.   
    * How can you confirm your datatypes?  
        * Df.info()  
        * Df.dtypes  
    * One of the columns is flagged as an object – what's going on here?  
        * Likely a special character or string somewhere in the column.      
* What is the difference between .loc and .iloc?
    * .loc requires that you specify the rows you want and the name of the column:
        * df.loc[what rows you want, 'column_name']
        * df.loc[2:20, 'species']
    * .iloc requires that you specify the rows that you want and the index (or indicies) of the column you want.
        * df.iloc[what rows you want, 1]
        * df.iloc[:, 0:2]
      * Pandas has two properties that you can use for indexing:
            * .loc indexes with the labels for rows and columns axis.
            * .iloc indexes with the integer positions for rows and columns axis.  
                      
* What is inplace = True?
    * Using the inplace=True keyword in a pandas method changes the default behaviour such that the operation on the dataframe doesn't return anything, it instead 'modifies the underlying data'. It mutates the actual object which you apply it to.   
    
* Describe a barchart:
    * A bar chart or bar graph is a chart or graph that presents categorical data with rectangular bars with heights or lengths proportional to the values that they represent.
    
* What are correlation heatmaps? What data visualization library (ies) can we use to create a heatmap?
    * Heat maps use color to show the strength of a relationship between two or more variables.
    * A commonly seen implementation of a heatmap uses the Seaborn library.


## Module 9 - Machine Learning Basics

* What is the Variance/Bias Tradeoff? What are examples of models that accentuate one of the other side of this tradeoff?
  * The bias variance tradeoff is the idea that every model or statistical estimator will trade off bias (inaccuracy or poor fit) and variance (overfitting or high complexity). In ML you want to have models that have low bias and variance, ie they fit the dataset well without overfitting, giving a good model overall, while variance reflects the variation or dispersiveness of the estimator.
  * Machine learning algorithms with low variance include linear regression, logistics regression, and especially regularized regression. In contrast, nonlinear algorithms often have low bias. For example random forests or neural networks, and decision trees.
* Why would we normalize / scale inputs as a transformation step. Can you cite an example where normalized input features create easy interpretation of the model?
  * One main reason we normalize the inputs is to allow easier comparison between different input features on their weight of impact in the model. For example, if we were analyzing the price of a house as our dependant variable (Y), and used independent variables (X's) number of square feet, and number of bathrooms, we would find the regression beta coefficient for the bathrooms to be larger if there was no normalization. This is because the scale of these variables in 1,500- 5,000 vs 1-6 respectively. By scaling these inputs to the same scale (zero to one) we allow the coefficient in the regression model to be more interpretable across these input variables in regards to their impact on the price of a house.
  * There are a few other reasons for normalization in machine learning. Normalizing our input makes the model more robust since outliers in the raw data can have a large influence on the model's behavior if not normalized. Other reasons for normalizing include: Reducing variance (in the case of standardization) 
* Explain training vs. testing data and where they come from.
  * Data available for ML is split into training and testing data by the programmer. Training is used to fit the model; testing is used to validate the model, specifically to determine if the model has been over-fit. (If the model performs well on training data but poorly on test data, it has likely been over-fit.) Although training and testing data can be split-out by-hand, it is common to use sklearn.model_selection.test_train_split() function. Common practice is to use 70-80% of available data to train the model, and use the remaining to test it.
* Differentiate between categorical data and text/string data.
  * Categorical data are string values that represent meaningful partitions of data; i.e., groups. Not all text/string data are categorical. For example: A car's make or model is string/text but not categorical; car type (SUV, sedan, truck, etc.) is categorical. A street address is not categorical, but a state, country, or region generally is.

## Modules 10 & 11 - Kafka & Cloud ETL and Applied Kafka

* What is a stream of data, what are some examples of streams of data used in a data pipeline?
  * Streams of data are continuous sequences of data that are constantly being generated and updated with an open connection where the total volume may not be known ahead of time. For example, real time data from sensors or social media.This is opposed to batch processing which is processing a group of data at once where that data already exists and it's shape (e.g number of rows and columns) of that incoming batch can be known ahead of time. Streams also will have variable flow over time, e.g. there is more time spent on video games, then when school is in session, and that's part of stream processing, to handle this peaks and valleys of the rate of incoming data.
  * An example of companies using streams could be in social media of in asset trading exchanges, or sensor data from an industrial process. For example, if Twitter wants to know what the most talked about things that are emerging on its platform in the last hour it would want to use a stream to create this analysis. Or say a company that is collecting all the trade data posted on the NYSE, this data is constantly emerging from companies putting in bids/asks/orders for different assets at different prices and volumes. If you were to take a snapshot through a traditional database query, by the time you got the result, the answer would not reflect the latest data. 
* What is a data lake and how is it different from a database?
  * A data lake is a large repository of data stored in its native format. It is different from a database because data lakes don't have any structure or schema. It does not organize or label data in any way and data can be stored in a variety of formats such as images, text, and audio files. Data lakes can also support many concurrent users accessing the same data set. However, because the content is not structured, it is not designed for query optimization, thus getting every piece of data that satisfies certain condition(s) will take longer. The result is that data lakes are well suited as the starting point for data analytics but are not suited for transactional applications.
* What is a cluster?
  * A cluster is a group of computers (called nodes) that run in parallel. Databricks notebooks are run on configurable clusters. Some benefits include *High reliability* (because if one node fails, others will take over) and *Load balancing* (as workloads are shared optimally across nodes).
* How do you run a pipeline in Azure Data Factory?
  * In ADF, open the pipeline, click either "Debug" or "Add trigger". With add trigger, the options are to "trigger now" or create a new trigger (can be on schedule, tumbling window, storage events, or custom events). Additionally, previously-run jobs can be rerun from ADF's Monitor page.
* "Systems Design" - What are some resources you're familiar with to build a cloud based ETL pipeline. What are good uses and limitations of those resources. From a pseudo-code perspective, how might you pipe those resources into a data pipeline. 
    * Most of my familiarity is with the Azure cloud, and some stops along the way I've hit in a data pipeline are Blob storage, Azure hosted SQL Server and databases, databricks and a sprinkling of kafka in between these as well. At the reporting level, I might expect to ingest the results of the pipeline via MS PowerQuery, bringing the final data to be reported on into Excel pivottable or PowerBI dashboard, into a pandas dataframe in a jupyter notebook for visualization, or even through a raw sql query 
    * Azure Blob Storage and SQL Server are obviously the main ways to persist the data. In terms of inputting or outputing data, both these services have possibilities: Blob storage has an api we can connect with and we can control access to that resource with sas_token.  
    * In terms of computation, Databricks is our driver here, where we treat this as a VM that can make connection to blob storage or sql or produce/consume kafka topic streams. 
    * Scheduling batch job's can be handled over AzureDataFactory  

## General

* What are the stages you'd take in a data analysis project?
  * Gather data, clean the data, load the data, exploratory data analysis, build ML model, gather conclusions.
* How would you choose which tool to use for cleaning data?
  * Some solutions may be easier to use depending on the size of the dataset and format.
* What would you do to help non-technical folks understand the results of a data analysis project?
  * Clear visualizations can convey conclusions to a non-technical audience. Also refrain from using technical jargon when explaining results.

[Return to Home](../README.md)
