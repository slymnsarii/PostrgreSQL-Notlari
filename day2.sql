--Personel isminde bir tablo olusturalim
create table personel(
personel_id int,
isim varchar(30),
sehir varchar(30),
NSmaas int,
sirket varchar(20),
adres varchar(50)
);
--Varolan personel tablosundan pers_id,sehir,adres fieldlarina sahip personel_adres adinda yeni bir tablo olusturalim
CREATE table personel_adres
as
select personel_id, sehir, adres from personel;

select * from personel

-- DML -->Data MAnupulation Lang.
--INSERT - UPDATE -DELETE
--Tabloya veri ekleme, tablodan veri guncelleme ve silme islemlerinde kullanilan komutlar
--INSERT
create table student(
id varchar(4),
st_name varchar(30),
age int
);
INSERT into student VALUES ('1001','Ali Can',25);
INSERT into student VALUES ('1002','Veli Can',35);
INSERT into student VALUES ('1003','Ayse Can',45);
INSERT into student VALUES ('1004','Derya Can',55);
--Tabloya parcali veri ekleme
insert into student(st_name,age) VALUES ('Murat Can',65);

--DQL --> Data Query Lang.
--SELECT
SELECT * from student; -- * dersem bütün verileri getirir
select st_name from student; -- istedigim verinin bilgileri olsun dersem boyle yazarim
--SELECT komutu WHERE KOSULU
SELECT * from student where age>35;

--TCL - Transaction Control Lang.
--Begin - Savepoint - rollback - commit
--Transaciton veritabani sistemlerinde bir islem basladiginda baslar ve islem bitince sona erer
--Bu islemler veri tabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir

create table ogrenciler2
(
id serial,
isim varchar(50),
veli_isim VARCHAR(50),
yazili_notu real
);
Begin;
insert into ogrenciler2 values(default,'ali can','hasan can',75.5);
insert into ogrenciler2 values(default,'canan gul','ayse gul',90.5);
savepoint x;
insert into ogrenciler2 values(default,'kemal can','ahmet can',85.5);
insert into ogrenciler2 values(default,'canan can','ayse can',65.5);

ROLLBACK to x;

select * from ogrenciler2;

commit; --Transaction'dan cikmak icin

--Transaction kullaniminda SERIAL data turu kullanimi tavsiye edilmez
--savepoint'ten sonra ekledigimiz veride sayac mantigi ile calistigi icin
--sayacta en son hangi sayida kaldiysa ordan devam eder
--NOT : Postgre SQL'de transaction kullanimi icin 'Begin' komutu ile baslariz,
--sonrasinda tekrar yanlis bir veriyi duzeltmek veya bizim icin onemli olan verilerden sonra
--ekleme yapabilmek icin 'SAVEPOINT savepointismi' komutunu kullaniriz ve
--bu savepoint'e donebilmek icin 'ROLLBACK TO savepointismi' komutunu kullaniriz ve 
--rollback calistirildiginda savepoint yazdigimiz satirin ustundeki verileri tabloda bize verir
--Son olarak transaction'i sonlandirmak icin mutlaka 'COMMIT' komutu kullaniriz
--MySQL de transaction olmadan kullanilir

-- DML - DELETE -
--DELETE FROM tablo_adi --> Tablo'nun tum icerigini siler
--Veriyi secerek silmek icin WHERE kosulu kullanilir
--DELETE FROM tablo_adi WHERE sutun_adi =veri --Tablodaki istedigimiz veriyi siler

create table ogrenciler
(
id int,
isim varchar(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler VALUES(123,'ali can','hasan',75);
INSERT INTO ogrenciler VALUES(124,'merve gul','ayse',85);
INSERT INTO ogrenciler VALUES(125,'kemal yasa','hasan',85);
INSERT INTO ogrenciler VALUES(126,'nesibe yilmaz','ayse',95);
INSERT INTO ogrenciler VALUES(127,'mustafa bak','hasan',99);
INSERT INTO ogrenciler VALUES(127,'mustafa bak','ali',99);

select * from ogrenciler;

--Soru : id'si 124 olan ogrenciyi siliniz
DELETE from ogrenciler where id=124;

--Soru2 :ismi kemal yasa olan satiri siliniz
Delete from ogrenciler where isim='kemal yasa';

--Soru3 : ismi nesibe yilmaz veya mustafa bak olan kayitlari siliniz
delete from ogrenciler where isim='nesibe yilmaz' or isim='mustafa bak';

--Soru4:ismi ali can ve id'si 123 olan kaydi silin
delete from ogrenciler where isim='ali can' or id=123;

--Tablodaki tum verileri silmek icin
delete from ogrenciler

--DELETE - TRUNCATE --
--TRUNCATE komutu DELETE komutu gibi bir tablodaki tum verileri siler.
--Ancak, secmeli silme yapamaz.

select * from ogrenciler;
TRUNCATE table ogrenciler

-- DDL - Data Definition Lang.
--CREATE - ALTER - DROP
--ALTER TABLE
--ALTER TABLE tabloda ADD, TYPE, SET, RENAME veya DROP COLUMNS islemleri icin kullanilir

--Personel tablosuna cinsiyet Varchar(20), ve yas int seklinde yeni sutunlar ekleyiniz
SELECT * from isciler;
alter table personel ADD cinsiyet VARCHAR(20), add yas INT;

--Personel tablosundan sirket field'ini(sutununu) siliniz
alter TABLE personel drop column sirket;

--Personel tablosundaki sehir sutununun adini ulke olarak degistiriniz
ALTER TABLE personel RENAME column sehir to ulke;

--Personel tablosunun adini isciler olarak degistiriniz
alter TABLE personel RENAME to isciler;

--DDL - DROP komutu-
DROP table isciler;

--CONSTRANINT--Kisitlamalar
--Primary Key -->Bir sutunun null icermemesini ve sutundaki verilerin benzersiz olmasini saglar(NOT NULL-UNIQUE)
--FOREGIN KEY -->Baska bir tablodaki PRIMARY KEY'i referans gostermek icin kullanilir
--Boylelikle tablolar arasında iliski kurmus oluruz.
--UNIQUE -->Bir sutundaki tum degerlerin BENZERSIZ yani tek olmasini saglar
--NOT NULL -->Bir sutunun NULL icermemesini yani bos olmamasini saglar
--NOT NULL kisitlamasi icin CONSTRAINT ismi tanimlanmaz.
--Bu kisitlama veri turunden hemen sonra yerlestirilir
--CHECK --> Bir sutuna yerlestirilecek deger araligini sinirlamak icin kullanilir

Create table calisanlar
(
id char(5) primary key, --not null+unique
isim varchar(50) unique, --UNIQUE -->Bir sutundaki tum degerlerin BENZERSIZ yani tek olmasini saglar
maas int NOT NULL, --NOT NULL -->Bir sutunun NULL icermemesini yani bos olmamasini saglar
ise_baslama DATE	
);

INSERT INTO calisanlar VALUES('10002','Mehmet Yilmaz', 12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010','Mehmet Yilmaz', 5000, '2018-04-14'); --UNIQUE
INSERT INTO calisanlar VALUES('10004','Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005','Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006','Canan Yas', NULL, '2019-04-12'); --NOT NULL
INSERT INTO calisanlar VALUES('10003','CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007','CAN', 5000, '2018-04-14'); --UNIQUE
--INSERT INTO calisanlar VALUES('10009','cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('','osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('','osman can', 2000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( '10002','ayse yilmaz', 12000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES(null,'filiz', 12000, '2018-04-14'); --PRIMARY KEY

select * from calisanlar

-- FOREIGN KEY--
create table adresler(
adres_id char(5),
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Aga Sok', '30.Cad.','Antep');

select * from adresler;

INSERT INTO adresler VALUES('10012','Aga Sok', '30.Cad.','Antep'); --Parent tabloda bu id olmadigi icin
																	--ekleme yapamazsin buraya

--Parent tabloda olmayan id ile child tabloya ekleme yapamayiz

INSERT INTO adresler VALUES(NULL,'Aga Sok', '30.Cad.','Antep');

--Calisanlar id ile adresler tablosundaki adres_id ile eslesenlere bakmak icin
select * from calisanlar, adresler where calisanlar.id = adresler.adres_id;
									--        P.K				F.K
Drop table calisanlar
--Parent tabloyu yani primary key olan tabloyu silmek istediginizde tabloyu silmez 
--once child tabloyu silmeniz gerekir








