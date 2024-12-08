-- доб файл
-- поправить время 

CREATE TABLE Roles  (
    role_id SERIAL PRIMARY   KEY,
    role_name TEXT NOT NULL UNIQUE
);

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY ,
    username VARCHAR(20) NOT NULL,
    age INTEGER NOT NULL,
    email VARCHAR(35) NOT NULL UNIQUE,
     phone_number VARCHAR(11) NOT NULL UNIQUE,
      role_id INTEGER NOT NULL,
    date_reg TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);



CREATE TABLE Notifications (
    notification_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    text_notifications TEXT NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Posts (
    post_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    content TEXT NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      category_id INTEGER,
    tag_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (tag_id) REFERENCES Tags(tag_id)
);

CREATE TABLE Comments (
    comment_id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    content TEXT NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Files (
    file_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    post_id INTEGER NOT NULL,
    file_name TEXT NOT NULL,
    file_path TEXT NOT NULL,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
);

CREATE TABLE Likes (
    like_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    post_id INTEGER,
    comment_id INTEGER,
    like_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (comment_id) REFERENCES Comments(comment_id)
);

CREATE TABLE Post_Tags (
    post_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    PRIMARY KEY (post_id, tag_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (tag_id) REFERENCES Tags(tag_id)
);

CREATE TABLE Subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    post_id INTEGER NOT NULL,
    subscription_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
);

CREATE TABLE Post_Categories (
    post_id INTEGER NOT NULL,
      category_id INTEGER NOT NULL,
    PRIMARY KEY (post_id, category_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Categories (
     category_id SERIAL PRIMARY KEY,
    category_name TEXT NOT NULL
);

CREATE TABLE Tags (
    tag_id SERIAL PRIMARY KEY,
    tag_name TEXT NOT NULL
);


INSERT INTO Roles (role_name) VALUES
('Admin'),
('User'),
('Moderator');

INSERT INTO Users (username, age, email, phone_number, role_id) VALUES
('иван', 25, 'ivan@mail.ru', '+79123456789', 2),
('мария', 30, 'maria@yandex.ru', '+79234567890', 2),
('алексей', 22, 'alexey@gmail.com', '+79345678901', 2),
('елена', 28, 'elena@outlook.com', '+79456789012', 2),
('дмитрий', 35, 'dmitry@rambler.ru', '+79567890123', 2),
('ольга', 27, 'olga@bk.ru', '+79678901234', 2),
('сергей', 29, 'sergey@inbox.ru', '+79789012345', 2),
('наталия', 24, 'natalia@list.ru', '+79890123456', 2),
('андрей', 31, 'andrey@yahoo.com', '+79901234567', 2),
('татьяна', 26, 'tatiana@hotmail.com', '+79012345678', 2),
('виктор', 33, 'viktor@zoho.com', '+79123456780', 2),
('светлана', 23, 'svetlana@protonmail.com', '+79234567801', 2);

INSERT INTO Categories (category_name) VALUES
 ('Технологии'),
('Спорт'),
('Здоровье'),
  ('Образование'),
('Развлечения'),
('Путешествия');

INSERT INTO Tags   (tag_name) VALUES
('Чат gpt'),
('Машинное обучение '),
('Фитнес'),
('Образование'),
('Фильмы'),
('Путешествия' );

INSERT INTO Posts (user_id, content, category_id,   tag_id) VALUES
(1, 'Люблю чат gpt', 1, 1),
 (2, 'Оставайтесь в форме этой зимой.', 3, 3),
(3, 'Образование формирует будущее.', 4, 4),
(4, 'Последний обзор фильма.', 5, 5),
(5, 'Этика в технологиях ИИ.', 1, 1),
(6, 'Советы по тренировкам для начинающих.', 3, 3),
(7, 'Образование дает силу.', 4, 4),
(8, 'Анализ кинематографических техник.', 5, 5);

INSERT INTO Comments (post_id, user_id, content) VALUES
(1, 2, 'Отличный пост об ИИ!'),
(2, 3, 'Спасибо за советы по фитнесу!'),
(3, 4, 'Очень информативный пост об образовании.'),
(4, 5, 'Мне понравился этот обзор фильма!'),
(5, 6, 'Еще один отличный пост об ИИ!'),
(6, 7, 'Больше советов по фитнесу, спасибо!'),
(7, 8, 'Образование - ключ к успеху!'),
(8, 9, 'Отличный обзор фильма!');

INSERT INTO Files (user_id, post_id, file_name, file_path) VALUES
(1, 1, 'ai_post.pdf', '/files/ai_post.pdf'),
(2, 2, 'fitness_post.pdf', '/files/fitness_post.pdf'),
(3, 3, 'education_post.pdf', '/files/education_post.pdf'),
(4, 4, 'movie_post.pdf', '/files/movie_post.pdf');

INSERT INTO Likes (user_id, post_id, comment_id) VALUES
(1, 2, NULL),
(2, 3, NULL),
(3, 4, NULL),
(4, 1, NULL),
(5, 5, NULL),
(6, 6, NULL),
(7, 7, NULL),
(8, 8, NULL),
(9, NULL, 1),
(10, NULL, 2),
(11, NULL, 3),
(12, NULL, 4);

INSERT INTO Post_Tags (post_id, tag_id) VALUES
(1, 1),
(2, 3),
(3, 4),
(4, 5),
(5, 1),
(6, 3),
(7, 4),
(8, 5);

INSERT INTO Subscriptions (user_id, post_id) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 1),
(5, 5),
(6, 6),
(7, 7),
(8, 8);

INSERT INTO Post_Categories (post_id, category_id) VALUES
(1, 1),
(2, 3),
(3, 4),
(4, 5),
(5, 1),
(6, 3),
(7, 4),
(8, 5);