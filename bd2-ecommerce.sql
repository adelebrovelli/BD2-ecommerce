CREATE TABLE IF NOT EXISTS log_table (
  id INT AUTO_INCREMENT PRIMARY KEY,
  log_message TEXT,
  log_date DATETIME DEFAULT NOW()
);


CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    sexo ENUM('m', 'f', 'o'),
    idade INT,
    nascimento DATE
);

CREATE TABLE clienteespecial (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNIQUE,
    cashback DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id)
);

CREATE TABLE funcionario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    sexo ENUM('m', 'f', 'o'),
    idade INT,
    nascimento DATE,
    cargo ENUM('vendedor', 'gerente', 'CEO'),
    salario DECIMAL(10,2)
);

CREATE TABLE produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    quantidade INT,
    descricao TEXT,
    valor DECIMAL(10,2)
);

CREATE TABLE venda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_vendedor INT,
    id_cliente INT,
    id_produto INT,
    data DATE DEFAULT CURRENT_DATE,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_vendedor) REFERENCES funcionario(id),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    FOREIGN KEY (id_produto) REFERENCES produto(id)
);

CREATE TABLE funcionarioespecial (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT UNIQUE,
    bonus DECIMAL(10,2),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id)
);


INSERT INTO produto (nome, quantidade, descricao, valor) VALUES
('Saia Jeans', 30, 'Saia jeans azul escuro', 99.90),
('Calça Skinny', 25, 'Calça skinny preta', 129.90),
('Blusa Branca', 40, 'Blusa básica branca', 59.90),
('Vestido Floral', 15, 'Vestido com estampa floral', 149.90),
('Jaqueta Jeans', 20, 'Jaqueta jeans azul', 179.90),
('Camisa Social', 30, 'Camisa branca social', 89.90),
('Shorts Jeans', 35, 'Shorts jeans curto', 79.90),
('Blusa Listrada', 20, 'Blusa com listras horizontais', 64.90),
('Saia Mini', 10, 'Saia mini estampada', 69.90),
('Calça Cargo', 15, 'Calça cargo bege', 139.90),
('Top Cropped', 25, 'Top curto colorido', 49.90),
('Blazer Preto', 12, 'Blazer feminino preto', 199.90),
('Macacão', 8, 'Macacão longo', 159.90),
('Regata Básica', 50, 'Regata de algodão', 39.90),
('Kimono Floral', 7, 'Kimono leve com estampa', 109.90),
('Saia Plissada', 18, 'Saia com pregas', 89.90),
('Calça Alfaiataria', 14, 'Calça formal', 149.90),
('Blusa de Tricô', 22, 'Blusa para inverno', 129.90),
('Cardigan', 19, 'Cardigan cinza', 119.90),
('Blusa Canelada', 30, 'Blusa ajustada ao corpo', 69.90);

INSERT INTO funcionario (nome, sexo, idade, nascimento, cargo, salario) VALUES
('Ana', 'f', 28, '1996-01-10', 'vendedor', 2000.00),
('Bruno', 'm', 32, '1992-05-20', 'vendedor', 2000.00),
('Carla', 'f', 35, '1989-03-15', 'gerente', 3500.00),
('Diego', 'm', 30, '1994-08-30', 'gerente', 3500.00),
('Elisa', 'f', 25, '1999-12-01', 'CEO', 5000.00);

INSERT INTO cliente (nome, sexo, idade, nascimento) VALUES
('Amanda', 'f', 25, '1999-01-15'),
('Bruno', 'm', 30, '1994-03-10'),
('Camila', 'f', 22, '2002-07-25'),
('Daniel', 'm', 35, '1989-06-18'),
('Eduarda', 'f', 28, '1996-11-02'),
('Felipe', 'm', 33, '1991-04-08'),
('Gabriela', 'f', 24, '2000-09-12'),
('Henrique', 'm', 40, '1984-02-27'),
('Isabela', 'f', 26, '1998-05-19'),
('João', 'm', 29, '1995-10-01'),
('Karla', 'f', 32, '1992-08-23'),
('Leonardo', 'm', 27, '1997-06-14'),
('Marina', 'f', 21, '2003-03-05'),
('Nathan', 'm', 34, '1990-07-07'),
('Olívia', 'f', 23, '2001-12-16'),
('Paulo', 'm', 36, '1988-09-09'),
('Queila', 'f', 31, '1993-04-28'),
('Rafael', 'm', 38, '1986-11-11'),
('Sara', 'f', 20, '2004-01-30'),
('Tiago', 'm', 39, '1985-06-22'),
('Ursula', 'f', 29, '1995-02-14'),
('Victor', 'm', 33, '1991-06-07'),
('Wesley', 'm', 26, '1998-03-03'),
('Ximena', 'f', 30, '1994-11-25'),
('Yasmin', 'f', 22, '2002-04-17'),
('Zeca', 'm', 35, '1989-08-09'),
('Alice', 'f', 28, '1996-07-21'),
('Breno', 'm', 32, '1992-10-19'),
('Clara', 'f', 23, '2001-02-11'),
('Davi', 'm', 27, '1997-12-30'),
('Elena', 'f', 21, '2003-06-05'),
('Fernando', 'm', 40, '1984-01-04'),
('Giovanna', 'f', 24, '2000-10-10'),
('Heitor', 'm', 36, '1988-09-01'),
('Iris', 'f', 26, '1998-12-12'),
('Jonas', 'm', 31, '1993-05-15'),
('Lara', 'f', 20, '2004-03-03'),
('Miguel', 'm', 37, '1987-11-11'),
('Nina', 'f', 25, '1999-08-08'),
('Otávio', 'm', 29, '1995-09-09'),
('Priscila', 'f', 27, '1997-02-20'),
('Rodrigo', 'm', 30, '1994-05-25'),
('Sofia', 'f', 22, '2002-10-22'),
('Thales', 'm', 34, '1990-12-12'),
('Vanessa', 'f', 33, '1991-06-06'),
('Wallace', 'm', 28, '1996-01-01'),
('Yuri', 'm', 30, '1994-04-04'),
('Zilda', 'f', 32, '1992-07-07'),
('Alana', 'f', 21, '2003-02-02'),
('Benício', 'm', 35, '1989-03-03'),
('Carolina', 'f', 24, '2000-01-01'),
('Diego', 'm', 38, '1986-06-06'),
('Estela', 'f', 31, '1993-08-08'),
('Fabrício', 'm', 39, '1985-10-10'),
('Giulia', 'f', 27, '1997-11-11'),
('Hugo', 'm', 28, '1996-09-09'),
('Isis', 'f', 23, '2001-01-01'),
('Júlio', 'm', 37, '1987-05-05'),
('Letícia', 'f', 25, '1999-07-07'),
('Maurício', 'm', 36, '1988-02-02'),
('Natália', 'f', 29, '1995-06-06'),
('Otília', 'f', 34, '1990-04-04'),
('Pedro', 'm', 31, '1993-03-03'),
('Quésia', 'f', 30, '1994-12-12'),
('Rogério', 'm', 33, '1991-01-01'),
('Samara', 'f', 26, '1998-08-08'),
('Túlio', 'm', 28, '1996-10-10'),
('Vitória', 'f', 22, '2002-02-02'),
('William', 'm', 29, '1995-11-11'),
('Xuxa', 'f', 35, '1989-09-09'),
('Yara', 'f', 24, '2000-06-06'),
('Zion', 'm', 40, '1984-07-07'),
('Aline', 'f', 27, '1997-05-05'),
('Brenda', 'f', 32, '1992-03-03'),
('César', 'm', 30, '1994-02-02'),
('Dandara', 'f', 33, '1991-09-09'),
('Eduardo', 'm', 34, '1990-06-06'),
('Fernanda', 'f', 26, '1998-04-04'),
('Gabriel', 'm', 25, '1999-03-03'),
('Helena', 'f', 28, '1996-07-07'),
('Igor', 'm', 29, '1995-01-01'),
('Jéssica', 'f', 23, '2001-05-05'),
('Kevin', 'm', 30, '1994-08-08'),
('Larissa', 'f', 22, '2002-06-06'),
('Marcelo', 'm', 35, '1989-02-02'),
('Nicole', 'f', 31, '1993-09-09'),
('Orlando', 'm', 36, '1988-03-03'),
('Patrícia', 'f', 29, '1995-12-12'),
('Quirino', 'm', 27, '1997-04-04'),
('Rita', 'f', 28, '1996-11-11'),
('Sandro', 'm', 34, '1990-01-01'),
('Tereza', 'f', 30, '1994-10-10'),
('Ubirajara', 'm', 38, '1986-05-05'),
('Valéria', 'f', 32, '1992-02-02'),
('Wagner', 'm', 37, '1987-07-07'),
('Xavier', 'm', 33, '1991-11-11'),
('Yolanda', 'f', 24, '2000-09-09'),
('Zélia', 'f', 36, '1988-08-08');

DELIMITER //

CREATE TRIGGER trigger_bonus_funcionario
AFTER INSERT ON venda
FOR EACH ROW
BEGIN
  DECLARE total DECIMAL(10,2);
  DECLARE msg TEXT;

  SELECT SUM(valor_total) INTO total FROM venda WHERE id_vendedor = NEW.id_vendedor;

  IF total > 1000 THEN
    INSERT INTO funcionarioespecial (id_funcionario, bonus)
    VALUES (NEW.id_vendedor, total * 0.05)
    ON DUPLICATE KEY UPDATE bonus = bonus + (NEW.valor_total * 0.05);

    SET msg = CONCAT('Bônus necessário: R$', FORMAT(total * 0.05, 2));

    INSERT INTO log_table (log_message, log_date)
    VALUES (msg, NOW());
  END IF;
END//

DELIMITER //

CREATE TRIGGER trigger_cashback_cliente
AFTER INSERT ON venda
FOR EACH ROW
BEGIN
  DECLARE total DECIMAL(10,2);
  DECLARE msg TEXT;

  SELECT SUM(valor_total) INTO total FROM venda WHERE id_cliente = NEW.id_cliente;

  IF total > 500 THEN
    INSERT INTO clienteespecial (id_cliente, cashback)
    VALUES (NEW.id_cliente, total * 0.02)
    ON DUPLICATE KEY UPDATE cashback = cashback + (NEW.valor_total * 0.02);

    SET msg = CONCAT('Cashback necessário: R$', FORMAT(total * 0.02, 2));

    INSERT INTO log_table (log_message, log_date)
    VALUES (msg, NOW());
  END IF;
END//

CREATE TRIGGER remover_clienteespecial
AFTER UPDATE ON clienteespecial
FOR EACH ROW
BEGIN
  IF NEW.cashback <= 0 THEN
    DELETE FROM clienteespecial WHERE id_cliente = NEW.id_cliente;
  END IF;
END//

DELIMITER ;


DELIMITER //
CREATE PROCEDURE reajuste_salario(IN percentual DECIMAL(5,2), IN categoria VARCHAR(20))
BEGIN
  UPDATE funcionario
  SET salario = salario * (1 + percentual / 100)
  WHERE cargo = categoria;
END;//

CREATE PROCEDURE sorteio()
BEGIN
  DECLARE cid INT;
  SELECT id INTO cid FROM cliente ORDER BY RAND() LIMIT 1;
  IF EXISTS (SELECT 1 FROM clienteespecial WHERE id_cliente = cid) THEN
    INSERT INTO venda (id_vendedor, id_cliente, id_produto, valor_total)
    VALUES (1, cid, 1, -200);
  ELSE
    INSERT INTO venda (id_vendedor, id_cliente, id_produto, valor_total)
    VALUES (1, cid, 1, -100);
  END IF;
END;//

CREATE PROCEDURE registrar_venda(IN idVend INT, IN idCli INT, IN idProd INT)
BEGIN
  DECLARE preco DECIMAL(10,2);
  DECLARE qtd INT;
  SELECT valor, quantidade INTO preco, qtd FROM produto WHERE id = idProd;
  IF qtd > 0 THEN
    UPDATE produto SET quantidade = quantidade - 1 WHERE id = idProd;
    INSERT INTO venda (id_vendedor, id_cliente, id_produto, valor_total)
    VALUES (idVend, idCli, idProd, preco);
  END IF;
END;//


CREATE PROCEDURE estatisticas()
BEGIN
  DECLARE prod_mais_vendido INT;
  DECLARE prod_menos_vendido INT;
  DECLARE vendas_existem INT;

  -- Verifica se há vendas
  SELECT COUNT(*) INTO vendas_existem FROM venda;

  IF vendas_existem = 0 THEN
    SELECT 'Nenhuma venda registrada ainda.' AS mensagem;
  ELSE

    -- Produto mais vendido
    SELECT id_produto INTO prod_mais_vendido
    FROM venda
    GROUP BY id_produto
    ORDER BY COUNT(*) DESC
    LIMIT 1;

    -- Produto menos vendido
    SELECT id_produto INTO prod_menos_vendido
    FROM venda
    GROUP BY id_produto
    ORDER BY COUNT(*) ASC
    LIMIT 1;

    -- 1. Produto mais vendido
    SELECT 'Produto mais vendido:' AS descricao, p.nome AS produto, COUNT(*) AS qtd_vendas
    FROM venda v
    JOIN produto p ON v.id_produto = p.id_produto
    WHERE v.id_produto = prod_mais_vendido
    GROUP BY v.id_produto;

    -- 2. Vendedor associado ao produto mais vendido
    SELECT 'Vendedor com mais vendas do produto mais vendido:' AS descricao, f.nome AS vendedor, COUNT(*) AS qtd
    FROM venda v
    JOIN funcionario f ON v.id_vendedor = f.id_funcionario
    WHERE v.id_produto = prod_mais_vendido
    GROUP BY v.id_vendedor
    ORDER BY qtd DESC
    LIMIT 1;

    -- 3. Produto menos vendido
    SELECT 'Produto menos vendido:' AS descricao, p.nome AS produto, COUNT(*) AS qtd_vendas
    FROM venda v
    JOIN produto p ON v.id_produto = p.id_produto
    WHERE v.id_produto = prod_menos_vendido
    GROUP BY v.id_produto;

    -- 4. Valor ganho com o produto mais vendido
    SELECT 'Valor ganho com o produto mais vendido:' AS descricao, SUM(v.valor_total) AS total
    FROM venda v
    WHERE v.id_produto = prod_mais_vendido;

    -- 5. Mês de maior venda do produto mais vendido
    SELECT 'Mês de maior venda do produto mais vendido:' AS descricao, MONTH(v.data) AS mes, COUNT(*) AS total_vendas
    FROM venda v
    WHERE v.id_produto = prod_mais_vendido
    GROUP BY mes
    ORDER BY total_vendas DESC
    LIMIT 1;

    -- 6. Mês de menor venda do produto mais vendido
    SELECT 'Mês de menor venda do produto mais vendido:' AS descricao, MONTH(v.data) AS mes, COUNT(*) AS total_vendas
    FROM venda v
    WHERE v.id_produto = prod_mais_vendido
    GROUP BY mes
    ORDER BY total_vendas ASC
    LIMIT 1;

    -- 7. Valor ganho com o produto menos vendido
    SELECT 'Valor ganho com o produto menos vendido:' AS descricao, SUM(v.valor_total) AS total
    FROM venda v
    WHERE v.id_produto = prod_menos_vendido;

    -- 8. Mês de maior venda do produto menos vendido
    SELECT 'Mês de maior venda do produto menos vendido:' AS descricao, MONTH(v.data) AS mes, COUNT(*) AS total_vendas
    FROM venda v
    WHERE v.id_produto = prod_menos_vendido
    GROUP BY mes
    ORDER BY total_vendas DESC
    LIMIT 1;

    -- 9. Mês de menor venda do produto menos vendido
    SELECT 'Mês de menor venda do produto menos vendido:' AS descricao, MONTH(v.data) AS mes, COUNT(*) AS total_vendas
    FROM venda v
    WHERE v.id_produto = prod_menos_vendido
    GROUP BY mes
    ORDER BY total_vendas ASC
    LIMIT 1;

  END IF;
END //

DELIMITER ;


CREATE VIEW vendas_por_vendedor AS
SELECT f.nome, COUNT(*) AS total_vendas, SUM(v.valor_total) AS total
FROM venda v JOIN funcionario f ON v.id_vendedor = f.id
GROUP BY f.nome;

CREATE VIEW clientes_total_gasto AS
SELECT c.nome, SUM(v.valor_total) AS gasto
FROM venda v JOIN cliente c ON v.id_cliente = c.id
GROUP BY c.nome;

CREATE VIEW estoque_produto AS
SELECT nome, quantidade, valor FROM produto;

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'gerente';
GRANT SELECT, INSERT, UPDATE, DELETE ON empresa.* TO 'gerente'@'localhost';
GRANT EXECUTE ON PROCEDURE empresa.reajuste_salario TO 'gerente'@'localhost';
GRANT EXECUTE ON PROCEDURE empresa.sorteio TO 'gerente'@'localhost';
GRANT EXECUTE ON PROCEDURE empresa.registrar_venda TO 'gerente'@'localhost';
GRANT EXECUTE ON PROCEDURE empresa.estatisticas TO 'gerente'@'localhost';
FLUSH PRIVILEGES;

CREATE USER 'funcionario'@'localhost' IDENTIFIED BY 'funcionario';
GRANT SELECT, INSERT ON empresa.* TO 'funcionario'@'localhost';
GRANT EXECUTE ON PROCEDURE empresa.registrar_venda TO 'funcionario'@'localhost';
GRANT EXECUTE ON PROCEDURE empresa.estatisticas TO 'funcionario'@'localhost';
FLUSH PRIVILEGES;