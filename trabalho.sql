create database redesocial;
use redesocial;

CREATE TABLE usuarios (
<<<<<<< HEAD
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30)
);

CREATE TABLE postagens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    texto VARCHAR(200) NOT NULL,
    data_post DATE,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE comentarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    texto VARCHAR(280) NOT NULL,
    data_comentario DATE,
    postagem_id INT,
	usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (postagem_id) REFERENCES postagens(id)
);

CREATE TABLE amizades (
    data_amizade DATE,
    usuario1_id INT,
    usuario2_id INT,
    FOREIGN KEY (usuario1_id) REFERENCES usuarios(id),
    FOREIGN KEY (usuario2_id) REFERENCES usuarios(id)
);

INSERT INTO usuarios (nome) VALUES
('Matheus'),
('César'),
('Maria');

INSERT INTO postagens (texto, data_post, usuario_id) VALUES
('Elon musk devolve o twitter', CURRENT_TIMESTAMP, 1), 
('Ata amo',  CURRENT_TIMESTAMP, 2), 
('Grimes pelo amor de Deus lança uma música boa',  CURRENT_TIMESTAMP, 3); 

SELECT postagens.*
FROM postagens
INNER JOIN usuarios ON postagens.usuario_id = usuarios.id
WHERE usuarios.nome = 'Matheus';

INSERT INTO comentarios (texto, data_comentario, usuario_id, postagem_id) VALUES
('Elon musk devolve o twitter', CURRENT_TIMESTAMP, 2, 3), 
('Ata amo',  CURRENT_TIMESTAMP, 3, 1), 
('Grimes pelo amor de Deus lança uma música boa',  CURRENT_TIMESTAMP, 1, 2); 

SELECT comentarios.*
FROM comentarios
INNER JOIN postagens ON comentarios.postagem_id = postagens.id
WHERE comentarios.texto = 'Ata amo' AND postagens.id = 1;

SELECT usuarios.nome, COUNT(postagens.id) AS total_postagens, COUNT(comentarios.id) AS total_comentarios
FROM usuarios
LEFT JOIN postagens ON usuarios.id = postagens.usuario_id
LEFT JOIN comentarios ON usuarios.id = comentarios.usuario_id
GROUP BY usuarios.id;

INSERT INTO amizades (usuario1_id, usuario2_id, data_amizade) VALUES
(1, 2, CURRENT_TIMESTAMP), 
(1, 3, CURRENT_TIMESTAMP);

SELECT usuarios.nome AS usuario1, U2.nome AS usuario2, amizades.data_amizade
FROM amizades
INNER JOIN usuarios ON amizades.usuario1_id = usuarios.id
INNER JOIN usuarios U2 ON amizades.usuario2_id = U2.id
WHERE amizades.data_amizade >= DATE_SUB(NOW(), INTERVAL 7 DAY);

SELECT usuarios.nome AS nome_usuario, postagens.texto AS postagem, amizades.data_amizade, amigos.nome AS nome_amigo
FROM usuarios
LEFT JOIN postagens ON usuarios.id = postagens.usuario_id
LEFT JOIN amizades ON usuarios.id = amizades.usuario1_id OR usuarios.id = amizades.usuario2_id
LEFT JOIN usuarios AS amigos ON (amizades.usuario1_id = amigos.id OR amizades.usuario2_id = amigos.id) AND amigos.id != usuarios.id
WHERE usuarios.nome = 'Maria';

drop database redesocial;
drop table usuarios;
drop table postagem;
drop table comentarios;
drop table amigos;
=======
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

>>>>>>> a74b1d46155caadf83ce7406c484f28258c4b3ab
