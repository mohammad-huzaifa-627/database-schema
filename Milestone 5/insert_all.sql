

-- 1. users
INSERT INTO users (id, name, email, password_hash, role, profile_pic, university, created_at) VALUES
(1, 'Ali Hassan',   'ali.hassan@school.edu',   'hashed_pass_1', 'admin',   NULL, 'Government College University', '2024-01-10 08:00:00'),
(2, 'Sara Khan',    'sara.khan@school.edu',    'hashed_pass_2', 'teacher', NULL, 'University of Peshawar',        '2024-01-11 09:00:00'),
(3, 'Bilal Ahmed',  'bilal.ahmed@school.edu',  'hashed_pass_3', 'user',    NULL, 'IMSciences',                    '2024-01-12 10:00:00'),
(4, 'Ayesha Noor',  'ayesha.noor@school.edu',  'hashed_pass_4', 'user',    NULL, 'FAST NUCES',                    '2024-01-13 11:00:00');

-- 2. courses
INSERT INTO courses (id, title, subject, description, teacher_id, enrollment_code, status, cover_color, created_at) VALUES
(1, 'Introduction to Algorithms', 'Computer Science', 'Covers basic algorithm design and analysis', 2, 'ALG101', 'active', '#4A90E2', '2024-01-15 08:00:00'),
(2, 'Database Systems',           'Computer Science', 'Relational databases and SQL',               2, 'DBS202', 'active', '#7ED321', '2024-01-15 09:00:00'),
(3, 'Probability & Statistics',   'Mathematics',      'Discrete and continuous distributions',      2, 'STA303', 'active', '#F5A623', '2024-01-15 10:00:00'),
(4, 'Software Engineering',       'Computer Science', 'SDLC methodologies and design patterns',     2, 'SE404',  'active', '#D0021B', '2024-01-15 11:00:00');

-- 3. enrollments
INSERT INTO enrollments (id, course_id, student_id, enrolled_at) VALUES
(1, 1, 3, '2024-01-16 08:00:00'),
(2, 2, 3, '2024-01-16 09:00:00'),
(3, 1, 4, '2024-01-17 08:00:00'),
(4, 3, 4, '2024-01-17 09:00:00');

-- 4. modules
INSERT INTO modules (id, course_id, title, order_index, published, unlock_date, created_at) VALUES
(1, 1, 'Introduction to Complexity',    1, true, '2024-01-20', '2024-01-18 08:00:00'),
(2, 1, 'Sorting Algorithms',            2, true, '2024-01-27', '2024-01-18 09:00:00'),
(3, 2, 'ER Diagrams and Normalization', 1, true, '2024-01-20', '2024-01-18 10:00:00'),
(4, 3, 'Bayes Theorem and Applications',1, true, '2024-01-22', '2024-01-18 11:00:00');

-- 5. content_items
INSERT INTO content_items (id, module_id, type, title, body, file_path, created_at) VALUES
(1, 1, 'lecture', 'What is Big-O?',          'Introduction to asymptotic notation',          NULL,                    '2024-01-19 08:00:00'),
(2, 1, 'file',    'Lecture Slides Week 1',   NULL,                                           '/files/algo_week1.pdf', '2024-01-19 09:00:00'),
(3, 2, 'lecture', 'Merge Sort Explained',    'Step by step merge sort walkthrough',          NULL,                    '2024-01-19 10:00:00'),
(4, 3, 'lecture', 'First Normal Form',       'Understanding 1NF with examples',              NULL,                    '2024-01-19 11:00:00');

-- 6. assignments
INSERT INTO assignments (id, course_id, title, description, due_date, max_marks, submission_type, allow_late, late_penalty_pct, release_date, created_at) VALUES
(1, 1, 'Assignment 1: Big-O Analysis', 'Analyze time complexity of given functions',       '2024-02-01 23:59:00', 20, 'file', true,  10, '2024-01-20 08:00:00', '2024-01-20 08:00:00'),
(2, 2, 'Lab 1: SQL Queries',           'Write SQL queries for given schema',               '2024-02-05 23:59:00', 25, 'file', false,  0, '2024-01-22 08:00:00', '2024-01-22 08:00:00'),
(3, 3, 'Problem Set 1: Probability',   'Solve probability problems using Bayes theorem',   '2024-02-08 23:59:00', 30, 'text', true,   5, '2024-01-23 08:00:00', '2024-01-23 08:00:00'),
(4, 4, 'SRS Document',                 'Write a Software Requirements Specification',      '2024-02-10 23:59:00', 40, 'file', true,  15, '2024-01-25 08:00:00', '2024-01-25 08:00:00');

-- 7. submissions
INSERT INTO submissions (id, assignment_id, student_id, content, file_path, file_name, submitted_at, is_late, grade, feedback, graded_at) VALUES
(1, 1, 3, NULL, '/submissions/bilal_algo1.pdf',   'bilal_algo1.pdf',   '2024-01-31 20:00:00', false, 18, 'Good work on complexity analysis', '2024-02-03 10:00:00'),
(2, 2, 3, NULL, '/submissions/bilal_sql1.pdf',    'bilal_sql1.pdf',    '2024-02-05 22:00:00', false, 22, 'Mostly correct queries',           '2024-02-07 10:00:00'),
(3, 1, 4, NULL, '/submissions/ayesha_algo1.pdf',  'ayesha_algo1.pdf',  '2024-02-02 10:00:00', true,  15, 'Late submission penalty applied',   '2024-02-03 11:00:00'),
(4, 3, 4, 'Solved all problems using Bayes theorem as shown in class', NULL, NULL, '2024-02-07 18:00:00', false, 28, 'Excellent work', '2024-02-09 09:00:00');

-- 8. quizzes
INSERT INTO quizzes (id, course_id, student_creator_id, title, time_limit_mins, open_date, close_date, shuffle_questions, attempts_allowed, type, share_code, created_at) VALUES
(1, 1, NULL, 'Week 1 Quiz: Big-O',      30, '2024-01-25 09:00:00', '2024-01-25 11:00:00', true,  1, 'graded',   'ALG1Q1', '2024-01-23 08:00:00'),
(2, 2, NULL, 'SQL Basics Quiz',         20, '2024-01-28 09:00:00', '2024-01-28 10:30:00', false, 2, 'graded',   'DBS2Q1', '2024-01-26 08:00:00'),
(3, 3, NULL, 'Probability Quiz 1',      25, '2024-01-30 09:00:00', '2024-01-30 10:30:00', true,  1, 'graded',   'STA3Q1', '2024-01-27 08:00:00'),
(4, 1,    3, 'Practice Quiz: Sorting',  15, NULL,                  NULL,                  false, 5, 'practice', 'PRAC01', '2024-01-28 15:00:00');

-- 9. questions
INSERT INTO questions (id, quiz_id, type, text, options, correct_answer, marks, order_index) VALUES
(1, 1, 'mcq', 'What is the time complexity of binary search?', '{"a":"O(n)","b":"O(log n)","c":"O(n^2)","d":"O(1)"}',                             'b', 2, 1),
(2, 1, 'mcq', 'Which sorting algorithm has O(n log n) worst case?', '{"a":"Bubble Sort","b":"Quick Sort","c":"Merge Sort","d":"Insertion Sort"}', 'c', 2, 2),
(3, 2, 'mcq', 'Which SQL clause filters grouped records?', '{"a":"WHERE","b":"HAVING","c":"ORDER BY","d":"GROUP BY"}',                            'b', 2, 1),
(4, 3, 'mcq', 'Bayes theorem deals with which type of probability?', '{"a":"Marginal","b":"Joint","c":"Conditional","d":"None"}',                 'c', 2, 1);

-- 10. quiz_attempts
INSERT INTO quiz_attempts (id, quiz_id, student_id, started_at, submitted_at, score, max_score, answers, auto_graded) VALUES
(1, 1, 3, '2024-01-25 09:05:00', '2024-01-25 09:28:00', 3.50, 4, '{"1":"b","2":"c"}', true),
(2, 2, 3, '2024-01-28 09:02:00', '2024-01-28 09:20:00', 2.00, 4, '{"3":"b"}',         true),
(3, 1, 4, '2024-01-25 09:10:00', '2024-01-25 09:35:00', 4.00, 4, '{"1":"b","2":"c"}', true),
(4, 3, 4, '2024-01-30 09:05:00', '2024-01-30 09:25:00', 2.00, 2, '{"4":"c"}',         true);

-- 11. tasks
INSERT INTO tasks (id, user_id, title, description, priority, status, due_date, parent_id, recurrence, created_at) VALUES
(1, 3, 'Submit Assignment 1',         'Upload Big-O analysis PDF to portal',         'high',   'completed',   '2024-02-01', NULL, 'none', '2024-01-20 10:00:00'),
(2, 3, 'Study Merge Sort',            'Review merge sort lecture slides',             'medium', 'in_progress', '2024-01-26', NULL, 'none', '2024-01-21 10:00:00'),
(3, 4, 'Prepare for Probability Quiz','Revise Bayes theorem and distributions',       'high',   'completed',   '2024-01-29', NULL, 'none', '2024-01-22 10:00:00'),
(4, 2, 'Grade Assignment 1',          'Review and grade student submissions',         'high',   'in_progress', '2024-02-05', NULL, 'none', '2024-02-01 09:00:00');

-- 12. projects
INSERT INTO projects (id, name, description, created_by, visibility, status, created_at, updated_at) VALUES
(1, 'Student Portal System',      'A web-based portal for managing student data', 2, 'private', 'active',   '2024-01-20 08:00:00', '2024-01-20 08:00:00'),
(2, 'Library Management System',  'Track books borrowing and returns',            2, 'public',  'active',   '2024-01-21 08:00:00', '2024-01-21 08:00:00'),
(3, 'Attendance Tracker',         'Automate daily attendance marking',            3, 'private', 'active',   '2024-01-22 08:00:00', '2024-01-22 08:00:00'),
(4, 'Result Management System',   'Generate and publish student results',         1, 'private', 'planning', '2024-01-23 08:00:00', '2024-01-23 08:00:00');

-- 13. project_members
INSERT INTO project_members (id, project_id, user_id, role, status, joined_at) VALUES
(1, 1, 2, 'owner',  'active', '2024-01-20 08:00:00'),
(2, 1, 3, 'member', 'active', '2024-01-20 09:00:00'),
(3, 2, 2, 'owner',  'active', '2024-01-21 08:00:00'),
(4, 2, 4, 'member', 'active', '2024-01-21 10:00:00');

-- 14. milestones
INSERT INTO milestones (id, project_id, name, due_date, status, approved_by, created_at) VALUES
(1, 1, 'Requirements Gathering', '2024-02-01', 'completed',   1,    '2024-01-20 08:00:00'),
(2, 1, 'Database Design',        '2024-02-15', 'in_progress', NULL, '2024-01-20 09:00:00'),
(3, 2, 'System Design',          '2024-02-10', 'completed',   1,    '2024-01-21 08:00:00'),
(4, 3, 'Prototype',              '2024-02-20', 'pending',     NULL, '2024-01-22 08:00:00');

-- 15. project_tasks
INSERT INTO project_tasks (id, project_id, milestone_id, title, description, assigned_to, status, due_date, created_at, updated_at) VALUES
(1, 1, 1,    'Design ER Diagram',          'Create entity relationship diagram for portal', 3, 'completed',   '2024-01-28', '2024-01-20 08:00:00', '2024-01-28 10:00:00'),
(2, 1, 2,    'Create Database Schema',     'Write CREATE TABLE queries',                   3, 'in_progress', '2024-02-10', '2024-01-20 09:00:00', '2024-01-20 09:00:00'),
(3, 2, 3,    'Design UI Mockups',          'Wireframes for library system',                4, 'completed',   '2024-02-05', '2024-01-21 08:00:00', '2024-02-05 12:00:00'),
(4, 3, NULL, 'Setup Project Repository',   'Initialize git repo and folder structure',     3, 'completed',   '2024-01-25', '2024-01-22 08:00:00', '2024-01-25 09:00:00');

-- 16. task_comments
INSERT INTO task_comments (id, task_id, user_id, message, file_attachment, created_at) VALUES
(1, 1, 2, 'Please make sure to follow the ER diagram guidelines provided in class', NULL,                        '2024-01-21 09:00:00'),
(2, 1, 3, 'Understood, I will follow the guidelines and submit by Friday',          NULL,                        '2024-01-21 10:00:00'),
(3, 2, 2, 'Reference the normalization slides for schema design',                   NULL,                        '2024-01-22 09:00:00'),
(4, 3, 4, 'Mockups are ready for review',                                           '/files/library_mockups.pdf','2024-02-05 11:00:00');

-- 17. project_messages
INSERT INTO project_messages (id, project_id, user_id, message, is_read, created_at) VALUES
(1, 1, 2, 'Team meeting scheduled for Monday at 10AM',                        true,  '2024-01-22 08:00:00'),
(2, 1, 3, 'Noted. I will prepare the ER diagram before the meeting',          true,  '2024-01-22 09:00:00'),
(3, 2, 2, 'Please push your changes to the repository by end of week',        false, '2024-01-23 08:00:00'),
(4, 3, 3, 'Prototype demo is ready. Please review when available',            false, '2024-01-24 10:00:00');

-- 18. project_files
INSERT INTO project_files (id, project_id, uploaded_by, file_name, file_path, file_size, mime_type, folder, version, created_at) VALUES
(1, 1, 3, 'er_diagram.pdf',          '/files/project1/er_diagram.pdf',          204800, 'application/pdf', 'designs',  1, '2024-01-28 10:00:00'),
(2, 1, 3, 'schema.sql',              '/files/project1/schema.sql',              10240,  'text/plain',       'database', 1, '2024-02-01 11:00:00'),
(3, 2, 4, 'library_mockups.pdf',     '/files/project2/library_mockups.pdf',     512000, 'application/pdf', 'designs',  1, '2024-02-05 11:00:00'),
(4, 3, 3, 'attendance_tracker.py',   '/files/project3/attendance_tracker.py',   20480,  'text/x-python',   'src',      1, '2024-01-25 09:00:00');

-- 19. project_activity_log
INSERT INTO project_activity_log (id, project_id, user_id, action, details, created_at) VALUES
(1, 1, 3, 'uploaded_file',      '{"file":"er_diagram.pdf"}',                                    '2024-01-28 10:00:00'),
(2, 1, 2, 'updated_milestone',  '{"milestone":"Requirements Gathering","status":"completed"}',   '2024-02-01 09:00:00'),
(3, 2, 4, 'uploaded_file',      '{"file":"library_mockups.pdf"}',                               '2024-02-05 11:00:00'),
(4, 3, 3, 'created_task',       '{"task":"Setup Project Repository"}',                          '2024-01-22 08:00:00');

-- 20. project_notifications
INSERT INTO project_notifications (id, user_id, type, reference_id, message, is_read, created_at) VALUES
(1, 3, 'task_assigned',      1, 'You have been assigned a new task: Design ER Diagram',                  true,  '2024-01-20 08:00:00'),
(2, 4, 'task_assigned',      3, 'You have been assigned a new task: Design UI Mockups',                  true,  '2024-01-21 08:00:00'),
(3, 2, 'milestone_completed',1, 'Milestone Requirements Gathering has been marked as completed',          true,  '2024-02-01 09:00:00'),
(4, 3, 'file_uploaded',      2, 'A new file has been uploaded to Student Portal System',                 false, '2024-02-01 11:00:00');
