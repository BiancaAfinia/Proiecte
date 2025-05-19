
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 04/07/2025 16:32:24
-- Generated from EDMX file: C:\Users\opris\OneDrive\Desktop\II_Proiect\II_Proiect\Proiect\Proiect\Model1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Librarie];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Cos]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Cos];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Autoris'
CREATE TABLE [dbo].[Autoris] (
    [Cod_autor] int  NOT NULL,
    [Nume] varchar(max)  NOT NULL,
    [Nationalitate] varchar(max)  NOT NULL
);
GO

-- Creating table 'Cartes'
CREATE TABLE [dbo].[Cartes] (
    [Cod_carte] int  NOT NULL,
    [Titlu] varchar(max)  NOT NULL,
    [Cod_autor] int  NOT NULL,
    [Cod_gen] int  NOT NULL,
    [Cod_edit] int  NOT NULL
);
GO

-- Creating table 'Conts'
CREATE TABLE [dbo].[Conts] (
    [Cod_cont] int  NOT NULL,
    [Email] varchar(max)  NOT NULL,
    [Parola] varchar(max)  NOT NULL
);
GO

-- Creating table 'Cos'
CREATE TABLE [dbo].[Cos] (
    [ID_cos] int  NOT NULL,
    [Cod_cont] int  NOT NULL,
    [Cod_carte] int  NOT NULL
);
GO

-- Creating table 'Edituras'
CREATE TABLE [dbo].[Edituras] (
    [Cod_edit] int  NOT NULL,
    [Nume] varchar(max)  NOT NULL
);
GO

-- Creating table 'Gens'
CREATE TABLE [dbo].[Gens] (
    [Cod_gen] int  NOT NULL,
    [Nume] varchar(max)  NOT NULL
);
GO

-- Creating table 'Vedere_Carti'
CREATE TABLE [dbo].[Vedere_Carti] (
    [Cod_Carte] int  NOT NULL,
    [Titlu_Carte] varchar(max)  NOT NULL,
    [Autor] varchar(max)  NOT NULL,
    [Gen] varchar(max)  NOT NULL,
    [Editura] varchar(max)  NOT NULL
);
GO

-- Creating table 'Vedere_Cos'
CREATE TABLE [dbo].[Vedere_Cos] (
    [ID_Cos] int  NOT NULL,
    [Email_Utilizator] varchar(max)  NOT NULL,
    [Titlu_Carte] varchar(max)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Cod_autor] in table 'Autoris'
ALTER TABLE [dbo].[Autoris]
ADD CONSTRAINT [PK_Autoris]
    PRIMARY KEY CLUSTERED ([Cod_autor] ASC);
GO

-- Creating primary key on [Cod_carte] in table 'Cartes'
ALTER TABLE [dbo].[Cartes]
ADD CONSTRAINT [PK_Cartes]
    PRIMARY KEY CLUSTERED ([Cod_carte] ASC);
GO

-- Creating primary key on [Cod_cont] in table 'Conts'
ALTER TABLE [dbo].[Conts]
ADD CONSTRAINT [PK_Conts]
    PRIMARY KEY CLUSTERED ([Cod_cont] ASC);
GO

-- Creating primary key on [ID_cos] in table 'Cos'
ALTER TABLE [dbo].[Cos]
ADD CONSTRAINT [PK_Cos]
    PRIMARY KEY CLUSTERED ([ID_cos] ASC);
GO

-- Creating primary key on [Cod_edit] in table 'Edituras'
ALTER TABLE [dbo].[Edituras]
ADD CONSTRAINT [PK_Edituras]
    PRIMARY KEY CLUSTERED ([Cod_edit] ASC);
GO

-- Creating primary key on [Cod_gen] in table 'Gens'
ALTER TABLE [dbo].[Gens]
ADD CONSTRAINT [PK_Gens]
    PRIMARY KEY CLUSTERED ([Cod_gen] ASC);
GO

-- Creating primary key on [Cod_Carte], [Titlu_Carte], [Autor], [Gen], [Editura] in table 'Vedere_Carti'
ALTER TABLE [dbo].[Vedere_Carti]
ADD CONSTRAINT [PK_Vedere_Carti]
    PRIMARY KEY CLUSTERED ([Cod_Carte], [Titlu_Carte], [Autor], [Gen], [Editura] ASC);
GO

-- Creating primary key on [ID_Cos], [Email_Utilizator], [Titlu_Carte] in table 'Vedere_Cos'
ALTER TABLE [dbo].[Vedere_Cos]
ADD CONSTRAINT [PK_Vedere_Cos]
    PRIMARY KEY CLUSTERED ([ID_Cos], [Email_Utilizator], [Titlu_Carte] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Cod_autor] in table 'Cartes'
ALTER TABLE [dbo].[Cartes]
ADD CONSTRAINT [FK__Carte__Cod_autor__3D5E1FD2]
    FOREIGN KEY ([Cod_autor])
    REFERENCES [dbo].[Autoris]
        ([Cod_autor])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__Carte__Cod_autor__3D5E1FD2'
CREATE INDEX [IX_FK__Carte__Cod_autor__3D5E1FD2]
ON [dbo].[Cartes]
    ([Cod_autor]);
GO

-- Creating foreign key on [Cod_edit] in table 'Cartes'
ALTER TABLE [dbo].[Cartes]
ADD CONSTRAINT [FK__Carte__Cod_edit__3F466844]
    FOREIGN KEY ([Cod_edit])
    REFERENCES [dbo].[Edituras]
        ([Cod_edit])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__Carte__Cod_edit__3F466844'
CREATE INDEX [IX_FK__Carte__Cod_edit__3F466844]
ON [dbo].[Cartes]
    ([Cod_edit]);
GO

-- Creating foreign key on [Cod_gen] in table 'Cartes'
ALTER TABLE [dbo].[Cartes]
ADD CONSTRAINT [FK__Carte__Cod_gen__3E52440B]
    FOREIGN KEY ([Cod_gen])
    REFERENCES [dbo].[Gens]
        ([Cod_gen])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__Carte__Cod_gen__3E52440B'
CREATE INDEX [IX_FK__Carte__Cod_gen__3E52440B]
ON [dbo].[Cartes]
    ([Cod_gen]);
GO

-- Creating foreign key on [Cod_carte] in table 'Cos'
ALTER TABLE [dbo].[Cos]
ADD CONSTRAINT [FK__Cos__Cod_carte__440B1D61]
    FOREIGN KEY ([Cod_carte])
    REFERENCES [dbo].[Cartes]
        ([Cod_carte])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__Cos__Cod_carte__440B1D61'
CREATE INDEX [IX_FK__Cos__Cod_carte__440B1D61]
ON [dbo].[Cos]
    ([Cod_carte]);
GO

-- Creating foreign key on [Cod_cont] in table 'Cos'
ALTER TABLE [dbo].[Cos]
ADD CONSTRAINT [FK__Cos__Cod_cont__44FF419A]
    FOREIGN KEY ([Cod_cont])
    REFERENCES [dbo].[Conts]
        ([Cod_cont])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__Cos__Cod_cont__44FF419A'
CREATE INDEX [IX_FK__Cos__Cod_cont__44FF419A]
ON [dbo].[Cos]
    ([Cod_cont]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------