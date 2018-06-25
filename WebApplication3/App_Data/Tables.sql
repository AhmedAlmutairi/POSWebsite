IF OBJECT_ID('dbo.AspNetRoles','U') IS NOT NULL
	DROP TABLE [dbo].[AspNetRoles];
GO

IF OBJECT_ID('dbo.AspNetUsers','U') IS NOT NULL
	DROP TABLE [dbo].[AspNetUsers];
GO

IF OBJECT_ID('dbo.AspNetUserClaims','U') IS NOT NULL
	DROP TABLE [dbo].[AspNetUserClaims];
Go

IF OBJECT_ID('dbo.AspNetUserLogins','U') IS NOT NULL
	DROP TABLE [dbo].[AspNetUserLogins];
GO

IF OBJECT_ID('dbo.AspNetUserRoles','U') IS NOT NULL
	DROP TABLE [dbo].[AspNetUserRoles];
GO

IF OBJECT_ID('dbo.Branch','U') IS NOT NULL
	DROP TABLE [dbo].[Branch];
GO

IF OBJECT_ID('dbo.Employee','U') IS NOT NULL
	DROP TABLE [dbo].[Employee];
GO

IF OBJECT_ID('dbo.Category','U') IS NOT NULL
	DROP TABLE [dbo].[Category];
GO

IF OBJECT_ID('dbo.SubCategory','U') IS NOT NULL
	DROP TABLE [dbo].[SubCategory];
GO

IF OBJECT_ID('dbo.Product','U') IS NOT NULL
	DROP TABLE [dbo].[Product];
GO

IF OBJECT_ID('dbo.Order','U') IS NOT NULL
	DROP TABLE [dbo].[Order];
GO

IF OBJECT_ID('dbo.OrderProduct','U') IS NOT NULL
	DROP TABLE [dbo].[OrderProduct];
GO

-- ############# Branch #############
CREATE TABLE [dbo].[Branch]
(
    [Id] INT IDENTITY(0001,1) NOT NULL,
    [Name] NVARCHAR (256) NOT NULL,
    [Address] NVARCHAR(500) NULL,
    [City] NVARCHAR(128) NULL,
    [PhoneNumber] NVARCHAR(15) NULL,
    CONSTRAINT [PK_dbo.Branch] PRIMARY KEY CLUSTERED ([Id] ASC)

);


-- ############# Employee #############
CREATE TABLE [dbo].[Employee]
(
    [Id] INT IDENTITY(00001,1) NOT NULL,
    [BranchId] INT NOT NULL,
    [DateStart] DATETIME NOT NULL,
    [DateEnd] DATETIME NOT NULL,
    [Name] NVARCHAR(256) NOT NULL,
    [Address] NVARCHAR(500) NULL,
    [City] NVARCHAR(128) Null,
    [PhoneNumber] NVARCHAR(15) NULL,
    CONSTRAINT [PK_dbo.Employee] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.Employee_dbo.Branch_BranchId] FOREIGN KEY ([BranchId]) REFERENCES [dbo].[Branch] ([Id]) ON DELETE CASCADE

);

-- ############# AspNetRoles #############
CREATE TABLE [dbo].[AspNetRoles]
(
    [Id]   NVARCHAR (128) NOT NULL,
    [Name] NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex]
    ON [dbo].[AspNetRoles]([Name] ASC);

-- ############# AspNetUsers #############
CREATE TABLE [dbo].[AspNetUsers]
(
    [Id]                   NVARCHAR (128) NOT NULL,
    [EmployeeId]           INT NOT NULL,
    [Email]                NVARCHAR (256) NULL,
    [EmailConfirmed]       BIT            NOT NULL,
    [PasswordHash]         NVARCHAR (MAX) NULL,
    [SecurityStamp]        NVARCHAR (MAX) NULL,
    [PhoneNumber]          NVARCHAR (MAX) NULL,
    [PhoneNumberConfirmed] BIT            NOT NULL,
    [TwoFactorEnabled]     BIT            NOT NULL,
    [LockoutEndDateUtc]    DATETIME       NULL,
    [LockoutEnabled]       BIT            NOT NULL,
    [AccessFailedCount]    INT            NOT NULL,
    [UserName]             NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.AspNetUsers_dbo.Employee_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([Id]) ON DELETE CASCADE
);
GO
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]([UserName] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_EmployeeId] ON [dbo].[AspNetUsers]([EmployeeId] ASC);

-- ############# AspNetUserClaims #############
CREATE TABLE [dbo].[AspNetUserClaims]
(
    [Id]         INT      IDENTITY (1, 1) NOT NULL,
    [UserId]     NVARCHAR (128) NOT NULL,
    [ClaimType]  NVARCHAR (MAX) NULL,
    [ClaimValue] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]([UserId] ASC);

-- ############# AspNetUserLogins #############
CREATE TABLE [dbo].[AspNetUserLogins]
(
    [LoginProvider] NVARCHAR (128) NOT NULL,
    [ProviderKey]   NVARCHAR (128) NOT NULL,
    [UserId]        NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED ([LoginProvider] ASC, [ProviderKey] ASC, [UserId] ASC),
    CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]([UserId] ASC);

-- ############# AspNetUserRoles #############
CREATE TABLE [dbo].[AspNetUserRoles]
(
    [UserId] NVARCHAR (128) NOT NULL,
    [RoleId] NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC),
    CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]([UserId] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]([RoleId] ASC);

-- ############# Category #############
CREATE TABLE [dbo].[Category]
(
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR (256) NOT NULL,
    [Description] NVARCHAR(500) NULL,
    CONSTRAINT [PK_dbo.Category] PRIMARY KEY CLUSTERED ([Id] ASC)
);

-- ############# Sub_category #############
CREATE TABLE [dbo].[SubCategory]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    [CatId] INT NOT NULL,
    [Name] NVARCHAR (256) NOT NULL,
    [Description] NVARCHAR(500) NULL,
    CONSTRAINT [PK_dbo.SubCategory] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.SubCategory_dbo.Category_CatId] FOREIGN KEY ([CatId]) REFERENCES [dbo].[Category] ([Id]) ON DELETE CASCADE

);

-- ############# Product #############
CREATE TABLE [dbo].[Product]
(
    [Id] INT IDENTITY(1,1) NOT NULL,
    [SubCatId] INT NOT NULL,
    [Name] NVARCHAR (256) NOT NULL,
    [Price] DECIMAL(18,4) NOT NULL,
    [Quantity] DECIMAL(18,5) NOT NULL,
    [Other] NVARCHAR(500) NULL,
    [Description] NVARCHAR(500) NULL,
    [Image] VarBinary(max) NOT NULL,
    [BarCode] CHAR(25) NULL,
    CONSTRAINT [PK_dbo.Product] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.Product_dbo.SubCategory_SubCatId] FOREIGN KEY ([SubCatId]) REFERENCES [dbo].[SubCategory] ([Id]) ON DELETE CASCADE

);

-- ############# Order #############
CREATE TABLE [dbo].[Order]
(
    [Id] INT IDENTITY (1000,1) NOT NULL,
    [UserId] NVARCHAR (128) NOT NULL,
    [OrderDate] DATETIME NOT NULL,
    [Total] DECIMAL(18,4) NULL,
    [TotalQunt] INT NULL,
    [CustomerName] NVARCHAR (256) NOT NULL,
    [Address] NVARCHAR(500) NULL,
    [City] NVARCHAR(128) Null, 
    [PhoneNumber] NVARCHAR(15) Null,
    CONSTRAINT [PK_dbo.Order] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.Order_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE

);

-- ############# OrderProduct #############
CREATE TABLE [dbo].[OrderProduct]
(
    [OrderId] INT NOT NULL,
    [ProductId] INT NOT NULL,
    [Total] DECIMAL(18,4) NULL,
    [TotalQunt] INT NULL,
    [Remaining] DECIMAL(18,4) NULL,
    [Tax] DECIMAL(4,4) NULL,
    
    CONSTRAINT [PK_dbo.OrderProduct] PRIMARY KEY CLUSTERED ([OrderId] ASC, [ProductId] ASC),
    CONSTRAINT [FK_dbo.OrderProduct_dbo.Order_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Order] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_dbo.OrderProduct_dbo.Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([Id]) ON DELETE CASCADE
);










