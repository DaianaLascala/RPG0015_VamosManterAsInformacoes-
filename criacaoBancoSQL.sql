CREATE TABLE Pessoa (
  idpessoa INTEGER NOT NULL IDENTITY,
  tipo CHAR(1)  NOT NULL,
  nomePessoa VARCHAR(100) NOT NULL CHECK (nomePessoa IN ('F', 'J')),
PRIMARY KEY(idpessoa));
GO



CREATE TABLE Produto (
  idProduto INTEGER NOT NULL IDENTITY,
  nomeProduto VARCHAR(100) NOT NULL,
  quantidadeProduto INTEGER NOT NULL,
  precoProduto NUMERIC NOT NULL,
PRIMARY KEY(idProduto));
GO



CREATE TABLE Usuarios (
  idUsuario INTEGER  NOT NULL IDENTITY,
  nomeUsuario VARCHAR(100) NOT NULL,
  senhaUsuario VARCHAR(20) NOT NULL,
  emailUsuario VARCHAR(80) UNIQUE NOT NULL,
  tipoUsuario BIT NOT NULL CHECK (tipoUsuario IN (0, 1)),
PRIMARY KEY(idUsuario));
GO



CREATE TABLE pessoaJuridica (
  idpessoaJuridica INTEGER NOT NULL IDENTITY,
  Pessoa_idpessoa INTEGER NOT NULL,
  cnpjJuridica CHAR(14) UNIQUE NOT NULL,
  razaoSocialJuridica VARCHAR(200) NOT NULL,
  logradouroJuridica VARCHAR(200),
  cidadeJuridica VARCHAR(50) NOT NULL,
  estadoJuridica CHAR(2) NOT NULL,
  cepJuridica CHAR(8) NOT NULL,
PRIMARY KEY(idpessoaJuridica, Pessoa_idpessoa),
  FOREIGN KEY(Pessoa_idpessoa)
    REFERENCES Pessoa(idpessoa));
GO


CREATE INDEX pessoaJuridica_FKIndex1 ON pessoaJuridica (Pessoa_idpessoa);
GO

CREATE INDEX IFK_fkPessoaJuridica ON pessoaJuridica (Pessoa_idpessoa);
GO


CREATE TABLE pessoaFisica (
  idpessoaFisica INTEGER NOT NULL IDENTITY,
  Pessoa_idpessoa INTEGER NOT NULL,
  cpfFisica CHAR(11) UNIQUE NOT NULL,
  dataNascimentoFisica DATE NOT NULL,
  logradouroFisica VARCHAR(200),
  cidadeFisica VARCHAR(50) NOT NULL,
  estadoFisica CHAR(2) NOT NULL,
  cepFisica CHAR(8) NOT NULL,
PRIMARY KEY(idPessoaFisica, Pessoa_idpessoa),
  FOREIGN KEY(Pessoa_idpessoa)
    REFERENCES Pessoa(idpessoa));
GO


CREATE INDEX pessoaFisica_FKIndex1 ON pessoaFisica (Pessoa_idpessoa);
GO

CREATE INDEX IFK_fkPessoaFisica ON pessoaFisica (Pessoa_idpessoa);
GO


CREATE TABLE movimentoCompra (
  idMovimentoCompra INTEGER NOT NULL IDENTITY,
  pessoaJuridica_Pessoa_idpessoa INTEGER NOT NULL,
  pessoaJuridica_idpessoaJuridica INTEGER NOT NULL,
  Produto_idProduto INTEGER NOT NULL,
  Usuarios_idUsuario INTEGER NOT NULL,
  quantidadeCompra INT NOT NULL,
  precoUnitarioCompra DECIMAL NOT NULL,
  dataMovimentoCompra DATETIME NOT NULL   DEFAULT GETDATE(),
PRIMARY KEY(idMovimentoCompra),
  FOREIGN KEY(Usuarios_idUsuario)
    REFERENCES Usuarios(idUsuario),
  FOREIGN KEY(Produto_idProduto)
    REFERENCES Produto(idProduto),
  FOREIGN KEY(pessoaJuridica_idpessoaJuridica, pessoaJuridica_Pessoa_idpessoa)
    REFERENCES pessoaJuridica(idpessoaJuridica, Pessoa_idpessoa));
GO


CREATE INDEX MovimentoCompra_FKIndex1 ON movimentoCompra (Usuarios_idUsuario);
GO
CREATE INDEX MovimentoCompra_FKIndex3 ON movimentoCompra (Produto_idProduto);
GO
CREATE INDEX movimentoCompra_FKIndex4 ON movimentoCompra (pessoaJuridica_idpessoaJuridica, pessoaJuridica_Pessoa_idpessoa);
GO

CREATE INDEX IFK_fkUsuarioMovimentoCompra ON movimentoCompra (Usuarios_idUsuario);
GO
CREATE INDEX IFK_fkProdutoMovimentoCompra ON movimentoCompra (Produto_idProduto);
GO
CREATE INDEX IFK_fkJuridicaMovimentoCompra ON movimentoCompra (pessoaJuridica_idpessoaJuridica, pessoaJuridica_Pessoa_idpessoa);
GO


CREATE TABLE movimentoVenda (
  idmovimentoVenda INTEGER NOT NULL IDENTITY,
  Usuarios_idUsuario INTEGER NOT NULL,
  pessoaFisica_Pessoa_idpessoa INTEGER NOT NULL,
  pessoaFisica_idpessoaFisica INTEGER NOT NULL,
  Produto_idProduto INTEGER NOT NULL,
  quantidadeVenda INTEGER NOT NULL,
  precoUnitarioVenda DECIMAL NOT NULL,
  dataMovimentoVenda DATETIME NOT NULL DEFAULT GETDATE(),
PRIMARY KEY(idmovimentoVenda),
  FOREIGN KEY(Produto_idProduto)
    REFERENCES Produto(idProduto),
  FOREIGN KEY(pessoaFisica_idpessoaFisica, pessoaFisica_Pessoa_idpessoa)
    REFERENCES pessoaFisica(idpessoaFisica, Pessoa_idpessoa),
  FOREIGN KEY(Usuarios_idUsuario)
    REFERENCES Usuarios(idUsuario));
GO


CREATE INDEX movimentoVenda_FKIndex1 ON movimentoVenda (Produto_idProduto);
GO
CREATE INDEX movimentoVenda_FKIndex2 ON movimentoVenda (pessoaFisica_idpessoaFisica, pessoaFisica_Pessoa_idpessoa);
GO
CREATE INDEX movimentoVenda_FKIndex3 ON movimentoVenda (Usuarios_idUsuario);
GO

CREATE INDEX IFK_fkProdutoMovimentoVenda ON movimentoVenda (Produto_idProduto);
GO
CREATE INDEX IFK_fkFisicaMovimentoVenda ON movimentoVenda (pessoaFisica_idpessoaFisica, pessoaFisica_Pessoa_idpessoa);
GO
CREATE INDEX IFK_fkUsuarioMovimentoVenda ON movimentoVenda (Usuarios_idUsuario);
GO



