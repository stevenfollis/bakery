CREATE TABLE [dbo].[Products] (
    [Id]          INT             IDENTITY (8, 1) NOT NULL,
    [Name]        NVARCHAR (50)   NOT NULL,
    [Description] NVARCHAR (1000) NOT NULL,
    [Price]       MONEY           NOT NULL,
    [ImageName]   NVARCHAR (50)   NULL,
    CONSTRAINT [Products_PK__Products__0000000000000018] PRIMARY KEY CLUSTERED ([Id] ASC)
);

