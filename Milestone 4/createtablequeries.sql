

-- 1. users
CREATE TABLE IF NOT EXISTS users (
    id            INT             NOT NULL,
    name          VARCHAR(255)    NOT NULL,
    email         VARCHAR(255)    NOT NULL,
    password_hash TEXT            NOT NULL,
    role          ENUM('admin', 'teacher', 'user') NOT NULL,
    profile_pic   TEXT,
    university    VARCHAR(255),
    created_at    TIMESTAMP       NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_email (email)
);

-- 2. courses
CREATE TABLE IF NOT EXISTS courses (
    id              INT          NOT NULL,
    title           VARCHAR(200) NOT NULL,
    subject         VARCHAR(100) NOT NULL,
    description     TEXT,
    teacher_id      INT          NOT NULL,
    enrollment_code VARCHAR(10)  NOT NULL,
    status          ENUM('active', 'inactive', 'archived') NOT NULL,
    cover_color     VARCHAR(7)   NOT NULL,
    created_at      TIMESTAMP    NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_enrollment_code (enrollment_code),
    FOREIGN KEY (teacher_id) REFERENCES users(id)
);

-- 3. enrollments
CREATE TABLE IF NOT EXISTS enrollments (
    id          INT       NOT NULL,
    course_id   INT       NOT NULL,
    student_id  INT       NOT NULL,
    enrolled_at TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_course_student (course_id, student_id),
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (student_id) REFERENCES users(id)
);

-- 4. modules
CREATE TABLE IF NOT EXISTS modules (
    id          INT          NOT NULL,
    course_id   INT          NOT NULL,
    title       VARCHAR(200) NOT NULL,
    order_index INT          NOT NULL,
    published   BOOLEAN      NOT NULL,
    unlock_date DATE,
    created_at  TIMESTAMP    NOT NULL,
    PRIMARY KEY (id),
    KEY idx_course_order (course_id, order_index),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- 5. content_items
CREATE TABLE IF NOT EXISTS content_items (
    id          INT          NOT NULL,
    module_id   INT          NOT NULL,
    type        ENUM('lecture', 'file', 'video', 'quiz') NOT NULL,
    title       VARCHAR(200) NOT NULL,
    body        TEXT,
    file_path   VARCHAR(500),
    created_at  TIMESTAMP    NOT NULL,
    PRIMARY KEY (id),
    KEY idx_module (module_id),
    FOREIGN KEY (module_id) REFERENCES modules(id)
);

-- 6. assignments
CREATE TABLE IF NOT EXISTS assignments (
    id               INT          NOT NULL,
    course_id        INT          NOT NULL,
    title            VARCHAR(200) NOT NULL,
    description      TEXT,
    due_date         DATETIME     NOT NULL,
    max_marks        INT          NOT NULL,
    submission_type  ENUM('file', 'text', 'link') NOT NULL,
    allow_late       BOOLEAN      NOT NULL,
    late_penalty_pct INT          NOT NULL,
    release_date     DATETIME,
    created_at       TIMESTAMP    NOT NULL,
    PRIMARY KEY (id),
    KEY idx_course_due (course_id, due_date),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- 7. submissions
CREATE TABLE IF NOT EXISTS submissions (
    id            INT          NOT NULL,
    assignment_id INT          NOT NULL,
    student_id    INT          NOT NULL,
    content       TEXT,
    file_path     VARCHAR(500),
    file_name     VARCHAR(255),
    submitted_at  DATETIME     NOT NULL,
    is_late       BOOLEAN      NOT NULL,
    grade         INT,
    feedback      TEXT,
    graded_at     DATETIME,
    PRIMARY KEY (id),
    UNIQUE KEY uq_assignment_student (assignment_id, student_id),
    KEY idx_student_submitted (student_id, submitted_at),
    FOREIGN KEY (assignment_id) REFERENCES assignments(id),
    FOREIGN KEY (student_id) REFERENCES users(id)
);

-- 8. quizzes
CREATE TABLE IF NOT EXISTS quizzes (
    id                 INT          NOT NULL,
    course_id          INT,
    student_creator_id INT,
    title              VARCHAR(200) NOT NULL,
    time_limit_mins    INT          NOT NULL,
    open_date          DATETIME,
    close_date         DATETIME,
    shuffle_questions  BOOLEAN      NOT NULL,
    attempts_allowed   INT          NOT NULL,
    type               ENUM('graded', 'practice', 'survey') NOT NULL,
    share_code         VARCHAR(10),
    created_at         TIMESTAMP    NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_share_code (share_code),
    KEY idx_course_type_dates (course_id, type, open_date, close_date),
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (student_creator_id) REFERENCES users(id)
);

-- 9. questions (normalized, no JSON)
CREATE TABLE IF NOT EXISTS questions (
    id             INT     NOT NULL,
    quiz_id        INT     NOT NULL,
    type           ENUM('mcq', 'true_false', 'short_answer') NOT NULL,
    text           TEXT    NOT NULL,
    correct_answer TEXT,
    marks          INT     NOT NULL,
    order_index    INT     NOT NULL,
    PRIMARY KEY (id),
    KEY idx_quiz_order (quiz_id, order_index),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id)
);

-- 9b. question_options
CREATE TABLE IF NOT EXISTS question_options (
    id          INT     NOT NULL,
    question_id INT     NOT NULL,
    option_key  CHAR(1) NOT NULL,
    option_text TEXT    NOT NULL,
    PRIMARY KEY (id),
    KEY idx_question (question_id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- 10. quiz_attempts (normalized, no JSON)
CREATE TABLE IF NOT EXISTS quiz_attempts (
    id           INT          NOT NULL,
    quiz_id      INT          NOT NULL,
    student_id   INT          NOT NULL,
    started_at   DATETIME     NOT NULL,
    submitted_at DATETIME,
    score        DECIMAL(6,2),
    max_score    INT,
    auto_graded  BOOLEAN      NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id),
    FOREIGN KEY (student_id) REFERENCES users(id)
);

-- 10b. attempt_answers
CREATE TABLE IF NOT EXISTS attempt_answers (
    id          INT  NOT NULL,
    attempt_id  INT  NOT NULL,
    question_id INT  NOT NULL,
    answer      TEXT NOT NULL,
    PRIMARY KEY (id),
    KEY idx_attempt (attempt_id),
    FOREIGN KEY (attempt_id) REFERENCES quiz_attempts(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- 11. tasks
CREATE TABLE IF NOT EXISTS tasks (
    id          INT          NOT NULL,
    user_id     INT          NOT NULL,
    title       VARCHAR(200) NOT NULL,
    description TEXT,
    priority    ENUM('low', 'medium', 'high') NOT NULL,
    status      ENUM('pending', 'in_progress', 'completed') NOT NULL,
    due_date    DATE,
    parent_id   INT,
    recurrence  ENUM('none', 'daily', 'weekly', 'monthly') NOT NULL,
    created_at  TIMESTAMP    NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (parent_id) REFERENCES tasks(id)
);

-- 12. projects
CREATE TABLE IF NOT EXISTS projects (
    id          INT          NOT NULL,
    name        VARCHAR(255) NOT NULL,
    description TEXT,
    created_by  INT          NOT NULL,
    visibility  ENUM('public', 'private') NOT NULL,
    status      ENUM('planning', 'active', 'completed', 'archived') NOT NULL,
    created_at  TIMESTAMP    NOT NULL,
    updated_at  TIMESTAMP    NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- 13. project_members
CREATE TABLE IF NOT EXISTS project_members (
    id         INT       NOT NULL,
    project_id INT       NOT NULL,
    user_id    INT       NOT NULL,
    role       ENUM('owner', 'member', 'viewer') NOT NULL,
    status     ENUM('active', 'inactive') NOT NULL,
    joined_at  TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_project_user (project_id, user_id),
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 14. milestones
CREATE TABLE IF NOT EXISTS milestones (
    id          INT          NOT NULL,
    project_id  INT          NOT NULL,
    name        VARCHAR(255) NOT NULL,
    due_date    DATE,
    status      ENUM('pending', 'in_progress', 'completed') NOT NULL,
    approved_by INT,
    created_at  TIMESTAMP    NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (approved_by) REFERENCES users(id)
);

-- 15. project_tasks
CREATE TABLE IF NOT EXISTS project_tasks (
    id           INT          NOT NULL,
    project_id   INT          NOT NULL,
    milestone_id INT,
    title        VARCHAR(255) NOT NULL,
    description  TEXT,
    assigned_to  INT,
    status       ENUM('pending', 'in_progress', 'completed') NOT NULL,
    due_date     DATE,
    created_at   TIMESTAMP    NOT NULL,
    updated_at   TIMESTAMP    NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (milestone_id) REFERENCES milestones(id),
    FOREIGN KEY (assigned_to) REFERENCES users(id)
);

-- 16. task_comments
CREATE TABLE IF NOT EXISTS task_comments (
    id              INT          NOT NULL,
    task_id         INT          NOT NULL,
    user_id         INT          NOT NULL,
    message         TEXT         NOT NULL,
    file_attachment VARCHAR(500),
    created_at      TIMESTAMP    NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (task_id) REFERENCES project_tasks(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 17. project_messages
CREATE TABLE IF NOT EXISTS project_messages (
    id         INT       NOT NULL,
    project_id INT       NOT NULL,
    user_id    INT       NOT NULL,
    message    TEXT      NOT NULL,
    is_read    BOOLEAN   NOT NULL,
    created_at TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 18. project_files
CREATE TABLE IF NOT EXISTS project_files (
    id          INT          NOT NULL,
    project_id  INT          NOT NULL,
    uploaded_by INT,
    file_name   VARCHAR(500) NOT NULL,
    file_path   VARCHAR(500) NOT NULL,
    file_size   BIGINT       NOT NULL,
    mime_type   VARCHAR(100),
    folder      VARCHAR(255),
    version     INT          NOT NULL,
    created_at  TIMESTAMP    NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (uploaded_by) REFERENCES users(id)
);

-- 19. project_activity_log (normalized, no JSON)
CREATE TABLE IF NOT EXISTS project_activity_log (
    id         INT          NOT NULL,
    project_id INT          NOT NULL,
    user_id    INT,
    action     VARCHAR(255) NOT NULL,
    created_at TIMESTAMP    NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 19b. activity_log_details
CREATE TABLE IF NOT EXISTS activity_log_details (
    id         INT          NOT NULL,
    log_id     INT          NOT NULL,
    detail_key VARCHAR(100) NOT NULL,
    detail_val TEXT         NOT NULL,
    PRIMARY KEY (id),
    KEY idx_log (log_id),
    FOREIGN KEY (log_id) REFERENCES project_activity_log(id)
);

-- 20. project_notifications
CREATE TABLE IF NOT EXISTS project_notifications (
    id           INT       NOT NULL,
    user_id      INT       NOT NULL,
    type         ENUM('task_assigned', 'milestone_completed', 'file_uploaded', 'message_received') NOT NULL,
    reference_id INT,
    message      TEXT      NOT NULL,
    is_read      BOOLEAN   NOT NULL,
    created_at   TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
