-- TYPES
CREATE TYPE status_horario AS ENUM ('Disponivel', 'Reservado');

CREATE TYPE modalidade_aula AS ENUM ('Presencial', 'Remoto');

CREATE TYPE status_atendimento AS ENUM ('Agendado', 'Concluido', 'Cancelado');

CREATE TYPE status_solicitacao AS ENUM ('Pendente', 'Aprovada', 'Recusada', 'Cancelada');

-- TABELA DE disciplinas

CREATE TABLE disciplinas(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL
);

CREATE TABLE turmas(
	id SERIAL PRIMARY KEY,
	curso VARCHAR(50) NOT NULL,
	ano VARCHAR(50) NOT NULL,
	turno VARCHAR(50) NOT NULL
);

CREATE TABLE usuarios(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	matricula VARCHAR(50) NOT NULL,
	senha VARCHAR(255) NOT NULL
);

CREATE TABLE professor(
	id INT PRIMARY KEY REFERENCES usuarios(id)
);

CREATE TABLE mediador(
    id INT PRIMARY KEY REFERENCES usuarios(id)
);

CREATE TABLE alunos(
	id INT PRIMARY KEY REFERENCES usuarios(id),
	id_turma REFERENCES turmas(id),
    necessidades_especiais BOOLEAN DEFAULT FALSE,
);

CREATE TABLE notificacoes(
	id SERIAL PRIMARY KEY,
	titulo VARCHAR(250) NOT NULL,	
	mensagem VARCHAR(500) NOT NULL,
	lida BOOLEAN DEFAULT FALSE,
	criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	lido_em TIMESTAMP
);

CREATE TABLE horarios(
	id SERIAL PRIMARY KEY,
	horario_inicio TIMESTAMP NOT NULL,
	horario_termino TIMESTAMP NOT NULL,
	status_horario status_horario
);

CREATE TABLE salas(
	id SERIAL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL
);

CREATE TABLE atendimentos(
	id SERIAL PRIMARY KEY,
	id_professor INT REFERENCES professores(id) NOT NULL,
	id_turma INT REFERENCES turmas(id) NOT NULL,
	id_horario INT REFERENCES horarios(id) NOT NULL,
    id_sala INT REFERENCES salas(id) NOT NULL,
	id_disciplina INT REFERENCES disciplinas(id) NOT NULL,
    id_solicitacao INT UNIQUE REFERENCES solicitacoes(id),
	assunto VARCHAR(500),
    relatorio VARCHAR(500),
    situacao status_atendimento,
	modalidade modalidade_aula
);

CREATE TABLE solicitacoes(
    id SERIAL PRIMARY KEY,
    id_aluno INT REFERENCES alunos(id) NOT NULL,
    id_mediador INT REFERENCES mediador(id) NOT NULL,
    assunto VARCHAR(500),
    status_atendimento status_atendimento
);


---------- TABELAS AUXILIARES ----------

CREATE TABLE aluno_atendimento(
	id_aluno INT REFERENCES alunos(id),
	id_atendimento INT REFERENCES atendimentos(id)
);

CREATE TABLE usuario_notificacao(
	id_usuario INT REFERENCES usuarios(id),
	id_notificacao INT REFERENCES notificacoes(id)
);

CREATE TABLE professor_turma(
	id_professor INT REFERENCES professores(id),
	id_turma INT REFERENCES turmas(id)
);

CREATE TABLE professor_disiplinas
(
	id_professor INT REFERENCES professores(id),
	id_disciplina INT REFERENCES disciplinas(id)
);

CREATE TABLE horario_sala(
	id_horario INT REFERENCES horarios(id),
	id_sala INT REFERENCES salas(id)
);










