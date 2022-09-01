/*
DDL - DATA DEFINITION LANG.
CREATE - ALTER - DROP
*/
--CREATE - TABLO OLUSTURMA -
CREATE table ogrenci(
ogr_no int,
ogr_isim VARCHAR(30),
notlar REAL,
yas int,
adress varchar(50),
kayit_tarih date
);
-- VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA
CREATE TABLE ogr_notlari
AS
SELECT ogr_no, notlar FROM ogrenci;

select * from ogrenci;
select * from ogr_notlari;