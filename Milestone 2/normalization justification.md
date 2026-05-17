All the tables are normalized by default. Except a 3 tables which we have normalized. The justification and fix for each of those tables has been mentioned below. 

Table: questions
Justification: This table had a column named options of type JSON. It stored all the answer options (a,b,c,d) for a question in a single JSON object in one column. This violates 1NF which require every column to be atomic. Storing multiple options in a column breaks that rule. 

Fix: We created a child table named question_options. Each option is now its own row with question_id as a foriegn key. 

Table: quiz_attempts
Justification: The table had an answer column of type JSON which again breaks the 1NF rule like the above table. 

Fix: We separated the answers column from the quiz_attempts and created a child table attempt_answers. Each answer a student gave is now its own row with attempt_id linking back to the attempt and question_id linking to the specific question answered.


Table: project_activity_log
Justification: It had the column details as JSON and we kmow that it breaks the 1NF rule. 

Fix: Created a child table activity_log_details. Connected it back to the parent table with foriegn key.


