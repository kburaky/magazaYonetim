USE [mavi]
GO
/****** Object:  StoredProcedure [dbo].[getProductsInSepet]    Script Date: 14.12.2015 00:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProductsInSepet]
@ref varchar(100)
AS
select sep.adet, ur.uAdi , ur.uFiyat , sep.durum , ur.urunID from urunler ur 
inner join sepet sep
on ur.urunID = sep.urunID
where sep.refKodu=@ref
GO
/****** Object:  StoredProcedure [dbo].[insertSatis]    Script Date: 14.12.2015 00:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertSatis]
	@ref varchar(100),
	@perID int ,
	@fiyat money,
	@odemeTipi tinyint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
insert into satis values(@ref,@perID,@fiyat,@odemeTipi,GETDATE())
END


GO
/****** Object:  StoredProcedure [dbo].[insertSepet]    Script Date: 14.12.2015 00:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insertSepet]
	@RefKod varchar(50),
	@PerID int,
	@barkod varchar(100)



AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   INSERT INTO [dbo].[sepet]
           ([refKodu]
           ,[personelID]
           ,[urunID]
           ,[urunFiyat]
           ,[adet]
           ,[durum]
           ,[tarih])
     VALUES
          ( @RefKod,@PerID,(select urunID from urunler where barkodNo=@barkod)
          
          
           ,(select uFiyat from urunler where barkodNo=@barkod)
           ,1
           ,0
           ,GETDATE())
END


GO
/****** Object:  StoredProcedure [dbo].[satisBilgiEkrani]    Script Date: 14.12.2015 00:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[satisBilgiEkrani] 

@barkod int

AS 

BEGIN

select ur.urunID ,ur.uAdi,ur.uKisaAciklama, ur.uFiyat,se.sBaslik,be.bBaslik,re.rAdi from urunler ur 
inner join sezonlar se on ur.sezonID=se.sezonID
inner join bedenler be on be.bedenID=ur.bedenID
inner join renkler re on ur.renkID=re.renkID
where ur.barkodNo=@barkod
 
END
GO
/****** Object:  StoredProcedure [dbo].[updateTerzi]    Script Date: 14.12.2015 00:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateTerzi]
@sayi int,
@id int,
@ref varchar(50)
AS 
BEGIN
UPDATE sepet SET durum =@sayi 
where sepetID =@id and refKodu =@ref
END
GO
