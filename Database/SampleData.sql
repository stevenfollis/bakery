USE [BakeryDB]
GO

INSERT INTO [dbo].[Products]
           ([Name]
           ,[Description]
           ,[Price]
           ,[ImageName])
     VALUES
           ('Carrot Cake'
           ,'A scrumptious mini-carrot cake encrusted with sliced almonds'
           ,8.99
           ,'carrot_cake.jpg'),

		   ('Lemon Tart'
           ,'A delicious lemon tart with fresh meringue cooked to perfection'
           ,9.99
           ,'lemon_tart.jpg'),

		   ('Cupcakes'
           ,'Delectable vanilla and chocolate cupcakes'
           ,5.99
           ,'cupcakes.jpg'),

		   ('Bread'
           ,'Fresh baked French-style bread'
           ,1.49
           ,'bread.jpg'),

		   ('Pear Tart'
           ,'A glazed pear tart topped with sliced almonds and a dash of cinnamon'
           ,5.99
           ,'pear_tart.jpg'),

		   ('Chocolate Cake'
           ,'Rich chocolate frosting cover this chocolate lover’s dream.'
           ,8.99
           ,'chocolate_cake.jpg')
GO


