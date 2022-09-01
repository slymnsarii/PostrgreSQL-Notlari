Create table calisanlar
(
id char(5) primary key, --not null+unique
isim varchar(50) unique, --UNIQUE -->Bir sutundaki tum degerlerin BENZERSIZ yani tek olmasini saglar
maas int NOT NULL, --NOT NULL -->Bir sutunun NULL icermemesini yani bos olmamasini saglar
ise_baslama DATE	
);

INSERT INTO calisanlar VALUES('10002','Mehmet Yilmaz', 12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10004','Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005','Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10003','CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('','osman', 2000, '2018-04-14');

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

delete from calisanlar where id='10002'; --PARENT --Once child'dan silmen gerek burdan silemezsin

delete from adresler WHERE adres_id='10002'; --CHILD

drop table calisanlar; --silemezsin

-- ON DELETE CASCADE --
--Her defasında önce child tablodaki verileri silmek yerine 
--ON DELETE CASCADE silme özelliğini aktif hale getirebiliriz
--Bunun için FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmamız yeterli

CREATE TABLE talebeler
(
id CHAR(3) primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

CREATE TABLE notlar( 
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
ON DELETE CASCADE
);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90); 

select * from talebeler
select * from notlar

delete from notlar where talebe_id='123' --child(F.K oldugu icin,child'dan silince parent'tan silmez)

delete from talebeler where id='126' --parent ON DELETE CASCADE kullandigimiz icin PARENT table'dan 
--direk silebildik.Parent table'dan sildigimiz icin child table'dan da silinmis olur
Delete from talebeler 

DROP TABLE talebeler CASCADE; --parents tabloyu kaldirmak istersek Drop table tablo_adi'dan sonra
--CASCADE komutunu kullaniriz

--Talebeler tablosundaki isim sutununa NOT NULL kisitlamasi ekleyiniz ve veri tipini VARCHAR(30) olarak degistiriniz
alter table talebeler
alter column isim TYPE VARCHAR(30),
alter column isim SET NOT NULL;

--talebeler tablosundaki yazili_notu sutununu 60'dan buyuk rakam girilebilsin
alter table talebeler
add CONSTRAINT sinir CHECK (yazili_notu>60);
--CHECK kisitlamasi ile tablodaki istedigimiz sutunu sinirlandirabiliriz
--yukarda 60'i sinir belirledigimiz icin bunu eklemedi

INSERT INTO talebeler VALUES(128, 'Mustafa Bak', 'Can',45);--calismaz 60'dan kucuk

create table ogrenciler(
id int, 
isim varchar(45),
adres varchar(100),
sinav_notu int
);

Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler;

select * from ogrenciler
select * from ogrenci_adres

--Tablodaki bir sutuna PRIMARY KEY ekleme
alter table ogrenciler
ADD PRIMARY KEY (id);

--PRIMARY KEY olusturmada 2.yol
alter table ogrenciler
ADD CONSTRAINT pk_id PRIMARY KEY(id); 

--PK'dan sonra FK atamasi
alter table ogrenci_adres
add foreign key(id) REFERENCES ogrenciler;
--Child tabloyu Parent tablodan olusturdugumuz icin sutun adi verilmedi

--PK'yi CONSTRAINT silme
alter table ogrenciler DROP CONSTRAINT pk_id;					--sonra PK silinir
--FK'yi silme CONTRAINT silme
alter table ogrenci_adres DROP CONSTRAINT ogrenci_adres_id_fkey;  -- once FK silinir

--Yazili notu 85'den buyuk olan talebe bilgilerini getirin
select * from talebeler WHERE yazili_notu>85;

--ismi Mustafa Bak olan talebenin tum bilgilerini getirin
select * from talebeler Where isim='Mustafa Bak'

--SELECT komutunda --BETWEEN Kosulu
--Between belirttiginiz 2 veri arasindaki bilgileri listeler
--Between'de belirttiginiz degerlerde listelemeye dahildir


create table personel
(
id char(4),
isim varchar(50),
maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);

/*
    AND (ve): Belirtilen şartların her ikiside gerçekleşiyorsa o kayıt listelenir
Bir tanesi gerçekleşmezse listelemez
    Select * from matematik sinav1 > 50 AND sınav2 > 50
Hem sınav1 hemde sınav2 alanı, 50'den büyük olan kayıtları listeler
    OR (VEYA): Belirtilen şartlardan biri gerçekleşirse, kayıt listelenir
    select * From matematik sınav>50 OR sınav2>50 
Hem sınav1 veya sınav2 alanı, 50 den büyük olan kayıtları listeler    
*/

select * from personel

--id'si 1003 ile 1005 arasinda olan personel bilgisini listeleyiniz
select * from personel WHERE id BETWEEN '1003' and '1005';

--2.YOL
select * from personel WHERE id>='1003' and id<='1005';

--Derya Soylu ile Yavuz Bal arasindaki personel bilgisini guncelleyiniz
select * from personel Where isim between 'Derya Soylu' and 'Yavuz Bal'
--alfabeye gore aliyor isimlerde

-- Maaşı 70000 veya ismi Sena olan personeli listele
select * from personel where maas=70000 OR isim ='Sena Beyaz'

--IN : Birden fazla mantıksal ifade ile tanımlayabileceğimiz durumları tek komutta yazabilme imkanı verir
--Farklı sütunlar için IN kullanılamaz(ayni sutun icinde olacak)

--id'si 1001,1002 ve 1004 olan personelin bilgilerini listele
select * from personel WHERE id ='1001' or id ='1002' or id = '1004';

-- 2. YOL
select * from personel WHERE id IN ('1001','1002','1004');

-- Maaşı sadece 70000, 100000 olan personeli listele
select * from personel WHERE maas IN (70000,100000); 

/*
SELECT - LIKE koşulu
LIKE : Sorgulama yaparken belirli (pattern) kalıp ifadeleri kullanabilmemizi sağlar
ILIKE : Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir
LIKE : ~~
ILIKE : ~~*
NOT LIKE : !~~
NOT ILIKE :!~~*
% --> 0 veya daha fazla karakteri belirtir.
_(alt tire) --> Tek bir karakteri belirtir
*/

-- Ismi A harfi ile baslayan personeli listele
select * from personel WHERE isim like 'A%'; --A ile baslasin sonrasi onemli degil

-- Ismi t harfi ile biten personeli listele
select * from personel WHERE isim like '%t'; --t ile bitsin basi ne olursa olsun

-- Isminin 2. harfi e olan personeli listeleyiniz
select * from personel WHERE isim ilike '_e%' --istedigimiz harfi yazmadan oncekilerin her birine _ koyariz






