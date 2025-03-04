use mercadoLivre


CREATE TABLE Customer (
    Icliente INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único para o cliente
	IdVendedor INT -- Identificador único para o vendedor
    Email VARCHAR(255) UNIQUE NOT NULL, -- Email único
    Nome VARCHAR(100) NOT NULL, -- Nome
    Sobrenome VARCHAR(100) NOT NULL, -- Sobrenome
    Sexo CHAR(1) CHECK (Sexo IN ('M', 'F', 'O')), -- Sexo (M = Masculino, F = Feminino, O = Outro)
    Endereco VARCHAR(255), -- Endereço
    [data de nascimento] DATE, -- Data de nascimento
    Telefone VARCHAR(20), -- Telefone
    DataCriacao DATETIME DEFAULT GETDATE(), -- Data de criação do cliente
    DataAtualizacao DATETIME DEFAULT GETDATE() -- Data da última atualização do cliente
);



CREATE TABLE [Order] (
    IdPedido INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único para o pedido
    Idcliente INT, -- Chave estrangeira para o comprador
    IdItem INT, -- Chave estrangeira para o item
    QtdVendas INT NOT NULL, -- Quantidade de vendas 
	QtdProduto INT NOT NULL, -- Quantidade comprada do item (no caso de pedidos de múltiplos itens)
    ValorPedido DECIMAL(10, 2) NOT NULL, -- Preço do item no momento da compra
    DataPedido DATETIME DEFAULT GETDATE(), -- Data do pedido
    StatusPedido VARCHAR(20) CHECK (StatusPedido IN ('Pendente', 'Concluído', 'Cancelado')), -- Status do pedido
    DataCriacao DATETIME DEFAULT GETDATE(), -- Data de criação do pedido
    DataAtualizacao DATETIME DEFAULT GETDATE(), -- Data da última atualização do pedido
    FOREIGN KEY (Idcliente) REFERENCES Customer(Idcliente), -- Relacionamento com o cliente
	FOREIGN KEY (IdVendedor) REFERENCES Customer(IdVendedor), -- Relacionamento com o cliente
    FOREIGN KEY (IdItem) REFERENCES Item(IdItem) -- Relacionamento com o item
);



CREATE TABLE Item (
    IdItem INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único para o item
    NomeItem VARCHAR(255) NOT NULL, -- Nome do item
    Descricao TEXT, -- Descrição do item
    ValorPedido DECIMAL(10, 2) NOT NULL, -- Preço do item
    StatusItem VARCHAR(20) CHECK (StatusItem IN ('Ativo', 'Inativo')), -- Status do item
    DataCancelamento DATE, -- Data de cancelamento, se houver
    IdCategoria INT, -- Chave estrangeira para a categoria
    DataCriacao DATETIME DEFAULT GETDATE(), -- Data de criação do item
    DataAtualizacao DATETIME DEFAULT GETDATE(), -- Data da última atualização do item
    FOREIGN KEY (IdCategoria) REFERENCES Category(IdCategoria), -- Relacionamento com a categoria
);


CREATE TABLE Category (
    CategoriaId INT IDENTITY(1,1) PRIMARY KEY, -- Identificador único para a categoria
    NomeCategoria VARCHAR(100) NOT NULL, -- Nome da categoria
	IdItem INT -- identificador do item dentro da categoria
    Subcategoria VARCHAR(255), -- Caminho ou estrutura hierárquica da categoria
    DataCriacao DATETIME DEFAULT GETDATE(), -- Data de criação da categoria
    DataAtualizacao DATETIME DEFAULT GETDATE(), -- Data da última atualização da categoria

);


