create database redesocial;
use redesocial;

CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE postagem (
    id_post INT PRIMARY KEY,
    id_usuario INT,
    texto TEXT NOT NULL,
    data_post DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE comentarios (
    id_comentario INT PRIMARY KEY,
    id_usuario INT,
    id_postagem INT,
    texto TEXT NOT NULL,
    data_comentario DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_postagem) REFERENCES postagem(id_post)
);

CREATE TABLE amigos (
    id_amigos INT PRIMARY KEY,
    id_user1 INT,
    id_user2 INT,
    data_amigos DATE,
    FOREIGN KEY (id_user1) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_user2) REFERENCES Usuarios(id_usuario)
);

SELECT * 
FROM postagem
WHERE id_usuario = (SELECT id_usuario FROM usuarios WHERE nome = 'Davi');

SELECT * 
FROM comentarios
WHERE id_postagem = (SELECT id_postagem FROM postagem WHERE texto = 'Fazendo um trabalho, e vocês');

SELECT *
FROM amigos
WHERE data_amigos >= CURDATE() - INTERVAL 7 DAY;

SELECT u.nome AS usuario,
       COUNT(DISTINCT p.id_post) AS total_postagem,
       COUNT(c.id_comentario) AS total_comentarios
FROM Usuarios u
LEFT JOIN postagem p ON u.id_usuario = p.id_usuario
LEFT JOIN comentarios c ON u.id_usuario = c.id_usuario
GROUP BY u.id_usuario, u.nome;

SELECT u.nome as usuario,
       p.texto as postagem,
       a.nome as amigo
FROM usuarios u
LEFT JOIN postagem p ON u.id_usuario = p.id_usuario
LEFT JOIN amigos am ON u.id_usuario = am.id_user1 OR u.id_usuario = am.id_user2
LEFT JOIN usuarios a ON (u.id_usuario = am.id_user1 AND a.id_usuario = am.id_user2) OR
                        (u.id_usuario = am.id_user2 AND a.id_usuario = am.id_user1)
WHERE u.nome = 'Maria';

