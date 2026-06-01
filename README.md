These are the milestones for our database lab project. A brief description of each milestone is mentioned below.

Milestone 2: Normalization of the all the tables of the project, Fortunately when making all the tables initially we made sure that all the the tables are normalized. But still we had 3 tables that were
not normalized. So we made sure that those tables are normalized. Due to normalization, we made an extra tables for those non-normalized tables. The non-normalized tables followed a similar pattern that 
some columns were of type JSON. One of the rules of 1NF normalization is that it must hold atomic values. Since JSON type can only hold "key pair" values, it isn't atomic. So in order for them to be atomic,
we had to make different tables.

Milestone 3: Data generation is a cruicial step. So for each table, we generated 5 rows of data in order to populate them. In the Milestone 3 folder, we have a csv file for each and every table. Since its
dummy data, we had to generate it through an AI model so we used Claude and validated it through all the database schema with the dataflow description.

Milestone 4: Currently we have, 23 tables and since we are working on an incremental build, this is not the final number. Now for the current tables, we made all the create table queries including all of
their constraints. This milestone is essential for the ERD diagram we wanted to update.

Milestone 5: For this milestone, we inserted all of the data we had in the csv files with the insert queries. All of it is compliant with the database schema and is ready to run.
